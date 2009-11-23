'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TClearGridCommand Extends TCommand

	Field _oldColours:TColour[,]
		
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
		_oldColours = TEditor.GetInstance().CloneGrid()
		TEditor.GetInstance().ClearGrid()
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
		TEditor.GetInstance().SetGrid(_oldColours)
	End Method

End Type


