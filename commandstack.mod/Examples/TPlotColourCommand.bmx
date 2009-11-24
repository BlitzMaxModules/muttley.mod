'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TPlotColourCommand Extends TCommand

	Field colour:TColour
	Field lastColour:TColour
	Field x:Int
	Field y:Int
		
	
	
	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return True
	End Method

	
	' Create a new instance of the command
	Function Create:TCommand(plotX:Int, plotY:Int, colour:TColour)
		Local command:TPlotColourCommand = New TPlotColourCommand
		command.x = plotX
		command.y = plotY
		command.colour = colour
		Return command
	End Function

	
	
	Rem
		bbdoc:Executes the command
	End Rem
	Method Execute:Int()
		
		' We fail if the mouse was clicked outside the grid
		If Not TEditor.GetInstance().InCell(x, y) Then Return False
		
		' Find out what cell the mouse clicked
		Local xCell:Int = TEditor.GetInstance().GetMouseCellX(x)
		Local yCell:Int = TEditor.GetInstance().GetMouseCellY(y)
	
		' Get the current colour of the cell and store it for unexecute purposes
		lastColour = TEditor.GetInstance().GetCell(xCell, yCell)

		' Only actually change the colour if the colour is different - no point
		' having useless commands on the undo stack
		If lastColour.Equals(colour)
			Return False
		Else
			TEditor.GetInstance().SetCell(xCell, yCell, colour)
			Return True
		End If
		
	End Method

	
	
	Rem
		bbdoc:Attempts to merge two commands
	End Rem
	Method Merge:Int(command:TCommand)
		' We can't merge this command
		Return False
	End Method

	
	
	Rem
		bbdoc:Undoes the command
	End Rem
	Method Unexecute()
		' Find out what cell the mouse clicked. We already know the mouse was inside
		' the grid, otherwise the command would have failed and wouldn't have been
		' added to the stack.
		Local xCell:Int = TEditor.GetInstance().GetMouseCellX(x)
		Local yCell:Int = TEditor.GetInstance().GetMouseCellY(y)

		' Set the cell to the previous colour
		TEditor.GetInstance().SetCell(xCell, yCell, lastColour)
	End Method

End Type
