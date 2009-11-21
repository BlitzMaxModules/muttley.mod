rem
'
' Copyright (c) 2007-2009 Paul Maskelyne <muttley@muttleyville.org>.

' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
endrem

Type TCommandStack
	Field _undoCommands:TStack
	Field _redoCommands:TStack
	Field _undoCommandCountAtLastSave:Int = 0
	
	rem
		bbdoc: Adds the command to the command stack (which may involve losing Redo or even
		potentially Undo information) and issues the command.
		returns:
	endrem
	Method AddCommand(command:TCommand)
		If command.Execute()

			If Not command.CanBeUndone()
				'This command cannot be undone, so clear the stack  - we don't need it any more
				_undoCommands.Clear()
				_redoCommands.Clear()
				_undoCommandCountAtLastSave = -1 ' We can't undo the get to the last saved state
				' No point pushing the command on the stack - we can't undo it!
			Else
				' We can't redo anything having just done something
				_redoCommands.Clear()
				
				If _undoCommandCountAtLastSave > _undoCommands.GetSize()
					_undoCommandCountAtLastSave = -1 ' We can't undo to get to the last saved state
				End If
				
				Rem
				Attempts to merge the command on the tope of the stack.
				EndRem
				If _undoCommands.GetSize() = 0 Or Not TCommand(_undoCommands.Peek()).Merge(command)
					_undoCommands.Push(command)
				EndIf
			End If
		End If
	End Method

	Method CanRedo:Int()
		Return _redoCommands.GetSize() > 0
	End Method
	
	Method CanUndo:Int()
		Return _undoCommands.GetSize() > 0
	End Method
	
	Method IsDirty:Int()
		Return _undoCommandCountAtLastSave <> _undoCommands.GetSize()
	End Method
	
	Method New()
		_undoCommands = TStack.Create(10, 10)
		_redoCommands = TStack.Create(10, 10)
		_undoCommandCountAtLastSave = 0
	End Method
	
	Method ProgressSaved()
		_undoCommandCountAtLastSave = _undoCommands.GetSize()
	End Method

	Method Redo()
		If CanRedo()
			Local command:TCommand = TCommand(_redoCommands.Pop())
			command.Execute()
			_undoCommands.Push(command)
		End If
	End Method
			
	Method Undo()
		If CanUndo()
			Local command:TCommand = TCommand(_undoCommands.Pop())
			command.Unexecute()
			_redoCommands.Push(command)
		End If
	End Method

End Type