Rem
	bbdoc:Command that clears all cells in the grid
End Rem
Type TClearGridCommand Extends TCommand

	Field _oldColours:TColour[,]
	
	
		
	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return True
	End Method


	
	rem
		bbdoc: Create a copy of the command
	endrem
	Method Copy:TClearGridCommand()
		Return New TClearGridCommand
	End Method

	
	
	Rem
		bbdoc:Executes the command
	End Rem
	Method Execute:Int()
		' first take a copy of the current grid for unexecute purposes
		_oldColours = TEditor.GetInstance().CloneGrid()
		
		TEditor.GetInstance().ClearGrid()
		Return True
	End Method

	
	
	Rem
		bbdoc:Attempts to merge two commands
	End Rem
	Method Merge:Int(command:TCommand)
		' We can merge with other clear grid commands, and
		' we don't actually have to do anything fancy to do so.
		Return SameCommandType(command)
	End Method

	
	
	Rem
		bbdoc:Undoes the command
	End Rem
	Method Unexecute()
		' Just reset the grid the the old values we saved
		TEditor.GetInstance().SetGrid(_oldColours)
	End Method

End Type


