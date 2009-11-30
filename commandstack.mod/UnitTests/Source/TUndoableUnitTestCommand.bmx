rem
	bbdoc: Mock command object for unit testing
	about: This command can be undone
endrem
Type TUndoableUnitTestCommand Extends TCommand

	Global g_executeCount:Int = 0
	Global g_unexecuteCount:Int = 0
	Global g_mergeCount:Int = 0
	
	Rem
		bbdoc:Executes the command
	End Rem
	Method Execute:Int()
		g_executeCount:+1
		Return True
	End Method

	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return True
	End Method

	Rem
		bbdoc:Returns a copy of the command
	End Rem
	Method Copy:TUndoableUnitTestCommand()
		' Can't copy this one
		Return Null
	End Method

	Rem
		bbdoc:Attempts to merge two commands
	End Rem
	Method Merge:Int(command:TCommand)
		Return False
	End Method

	Rem
		bbdoc:Undoes the command
	End Rem
	Method Unexecute()
		g_unexecuteCount:+1
	End Method

End Type
