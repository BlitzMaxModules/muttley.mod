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

	
	
	rem
		bbdoc: Returns whether this macro can be undone
		returns: True if the macro can be undone, otherwise False
		about: A macro command can only be undone if all the individual commands
		in the macro can also be undone
	endrem	
	Method CanBeUndone:Int()
		For Local command:TCommand = EachIn _commands
		
			If Not command.CanBeUndone()
				Return False
			End If
			
		Next
		
		Return True
	End Method
	
	
	
	rem
		bbdoc: Returns a copy of the macro
	endrem
	Method Copy:TCommand()
		Local macro:TMacroCommand = New TMacroCommand
		
		For Local command:TCommand = EachIn _commands
		
			macro.AddCommand(command.Copy())
		
		Next
		
		Return macro
	End Method
	
	
	
	rem
		bbdoc: Creates a macro command from a provided TList of commands
		returns: TMacroCommand
	endrem
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

	

	Rem
		bbdoc: Attempts to merge two commands
		about: Macro commands by their very nature cannot be merged so this just returns False
	End Rem
	Method Merge:Int(command:TCommand)
		Return False
	End Method

		
	
	rem
		bbdoc: Default constructor
	endrem	
	Method New()
		_commands = New TList
	End Method

	
	
	Rem
		bbdoc: Returns a human readable description of the macro command
	End Rem
	Method ToString:String()
		Local asString:String = "Macro Command:~n"
		
		For Local command:TCommand = EachIn _commands
			asString:+"+ " + command.ToString() + "~n"
		Next
	
		Return asString
	End Method	
	

	
	Rem
		bbdoc: Undoes the command
		about: Calls the unexecute method of each command in the macro in reverse order
	End Rem
	Method Unexecute:Int()
		Local reversedCommands:TList = _commands.Reversed()
		
		For Local command:TCommand = EachIn reversedCommands
			command.Execute()
		Next
		
		Return reversedCommands.Count()
	End Method
	
End Type
