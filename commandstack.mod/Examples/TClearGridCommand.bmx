'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TClearGridCommand Extends TCommand

	Field oldColours:Int[16, 16]
		
	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return True
	End Method


	Rem
		bbdoc:Executes the command
	End Rem
	Method Execute:Int()
		For Local x:Int = 0 To 15
			For Local y:Int = 0 To 15
				oldColours[x, y] = colours[x, y]
				colours[x, y] = 0
			Next
		Next
		Return True
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
		For Local x:Int = 0 To 15
			For Local y:Int = 0 To 15
				colours[x, y] = oldColours[x, y]
			Next
		Next
	End Method

End Type


