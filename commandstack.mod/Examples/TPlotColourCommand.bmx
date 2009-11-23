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
		
		If Not TEditor.GetInstance().MouseInCell(x, y) Then Return False
		
		Local xCell:Int = TEditor.GetInstance().GetMouseCellX(x)
		Local yCell:Int = TEditor.GetInstance().GetMouseCellY(y)
	
		lastColour = TEditor.GetInstance().GetCell(xCell, yCell)

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
		Return False
	End Method

	Rem
		bbdoc:Undoes the command
	End Rem
	Method Unexecute()
		Local xCell:Int = TEditor.GetInstance().GetMouseCellX(x)
		Local yCell:Int = TEditor.GetInstance().GetMouseCellY(y)

		TEditor.GetInstance().SetCell(xCell, yCell, lastColour)

	End Method

End Type
