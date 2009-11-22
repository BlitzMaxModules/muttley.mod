'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TPlotColourCommand Extends TCommand

	Field colour:Int
	Field lastColour:Int
	Field x:Int
	Field y:Int
		
	Rem
		bbdoc:Returns whether the command can be undone or not
	End Rem
	Method CanBeUndone:Int()
		Return True
	End Method

	Function Create:TCommand(plotX:Int, plotY:Int, colour:Int)
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
		Local xCell:Int = (x - 200) / 25
		Local yCell:Int = (y - 100) / 25
	
		If colours[xCell, yCell] = colour
			' Nothing to do, cell is already the correct colour
			Return False
		Else
			' Save the current value so we can undo
			lastColour = colours[xCell, yCell]
			colours[xCell, yCell] = colour
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
		Local xCell:Int = (x - 200) / 25
		Local yCell:Int = (y - 100) / 25
		
		colours[xCell, yCell] = lastColour
	End Method

End Type
