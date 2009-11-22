rem
	bbdoc: Mock command object for unit testing
	about: This command cannot be undone
endrem
Type TUnitTestCommand Extends TUndoableUnitTestCommand
	
	Rem
		bbdoc:Attempts to merge two commands
	End Rem
	Method Merge:Int(command:TCommand)
		Return False
	End Method
	
	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return False
	End Method

End Type
