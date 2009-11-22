rem
	bbdoc: Mock command object for unit testing
	about: This command can be undone and merged
endrem
Type TMergeableUnitTestCommand Extends TUndoableUnitTestCommand

	Rem
		bbdoc:Attempts to merge two commands
	End Rem
	Method Merge:Int(command:TCommand)
		' We will only merge if the command provided is of the same type as us
		If SameCommandType(command)
			g_mergeCount:+1
			Return True
		Else
			Return False
		End If
	End Method

End Type
