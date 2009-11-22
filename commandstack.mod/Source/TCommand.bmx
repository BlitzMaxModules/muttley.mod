rem
'
' Copyright (c) 2007-2009 Paul Maskelyne <muttley@muttleyville.org>.

' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
endrem

rem
	bbdoc: Base class that represents commands
	about: Extend this class to provide command functions for your applications
endrem
Type TCommand

	rem
		bbdoc: Executes the command
		returns: True if successfull, otherwise False
		about: This method should actually perform the command itself and should
		be called via the command stack. If the command succeeds it will be added
		to the undo stack.
	endrem
	Method Execute:Int() Abstract
	
	

	rem
		bbdoc: Returns whether the command can be undone or not
		returns: True if the command can be undone, otherwise False
		about: If a command makes destructive changes to your application
		you will need to return false here.
	endrem
	Method CanBeUndone:Int() Abstract
	
	
	
	rem
		bbdoc: Attempts to merge two commands
		returns: True if the commands have been merged, otherwise False
		about: If two identical commands are performed in quick succession it is
		possible that they can be merged to save undo/redo stack space.  If they
		can, this method should perform that merge and return the appropriate
		response.  Commands that are merged with an existing command on the stack
		are not added to the stack themselves.
	endrem
	Method Merge:Int(command:TCommand) Abstract
	
	
	
	rem
		bbdoc: Determine whether the provided command is the same type as ourselves
		returns: True if the same type, otherwise false
	endrem
	Method SameCommandType:Int(command:TCommand)
		If TTypeId.ForObject(Self) = TTypeId.ForObject(command)
			Return True
		Else
			Return False
		End If
	End Method
	
	
	
	rem
		bbdoc: Returns a human readable description of the class
	endrem
	Method ToString:String()
		Return "Command Pattern function object"
	End Method

	
			
	rem
		bbdoc: Undoes the command
		about: This method should revert any change that was made by the
		Execute() method
	endrem
	Method Unexecute() Abstract
	
End Type

