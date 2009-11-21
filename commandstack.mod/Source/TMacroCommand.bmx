rem
'
' Copyright (c) 2007-2009 Paul Maskelyne <muttley@muttleyville.org>.
'
' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
endrem

Rem
	bbdoc: Class representing #TCommand macros.
	about: A macro is two or more commands that are executed in sequence
End Rem
Type TMacroCommand Extends TCommand Final

	' The list of commands that make up this macro
	Field _commands:TList
	
	

	rem
		bbdoc: Adds a command to the macro
	endrem
	Method AddCommand(command:TCommand)
		_commands.AddLast(command)
	End Method

	
		
	Method CanBeUndone:Int()
		For Local command:TCommand = EachIn _commands
			If Not command.CanBeUndone()
				Return False
			End If
		Next
		Return True
	End Method
	
	
		
	Function Create:TMacroCommand(commandList:TList)
		Local macro:TMacroCommand = New TMacroCommand
		
		For Local command:TCommand = EachIn commandList
			macro.AddCommand(command)
		Next
		
		Return macro
	End Function

	
			
	rem
		bbdoc: Executes all commands in the macro
		returns: The number of commands executed
		about: This method performs each command in the macro and should be called
		via the command stack. If the command succeeds it will be added to the undo
		stack.
	endrem
	Method Execute:Int()
		For Local command:TCommand = EachIn _commands
			command.Execute()
		Next
		
		Return _commands.Count()
	End Method

	


	
		
	Method Merge:Int(command:TCommand)
		Return False
	End Method

	
		
	rem
		bbdoc: Default constructor
	endrem	
	Method New()
		_commands = New TList
	End Method

	
		
	Method Unexecute:Int()
		Local reversedCommands:TList = _commands.Reversed()
		For Local command:TCommand = EachIn reversedCommands
			command.Execute()
		Next
		Return reversedCommands.Count()
	End Method
	
	
	Method ToString:String()
		Local asString:String = "Macro Command:~n"
		
		For Local command:TCommand = EachIn _commands
			asString:+"+ " + command.ToString() + "~n"
		Next
	
		Return asString
	End Method
	
End Type
