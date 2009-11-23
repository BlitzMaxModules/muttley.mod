Local colourRed:TColour = TColour.Red()
Local colourGreen:TColour = TColour.Green()
Local colourBlue:TColour = TColour.Blue()
Local colourBlack:TColour = TColour.Black()

Local currentColour:TColour = colourRed

Local commandStack:TCommandStack = New TCommandStack

Graphics(800, 600, 0, 60)

While Not KeyHit(KEY_ESCAPE)
	Cls
	
	If KeyHit(KEY_1) Then currentColour = colourRed
	If KeyHit(KEY_2) Then currentColour = colourGreen
	If KeyHit(KEY_3) Then currentColour = colourBlue
	
	If KeyHit(KEY_U) Then commandStack.Undo()
	If KeyHit(KEY_R) Then commandStack.Redo()
	
	If KeyHit(KEY_C) Then commandStack.AddCommand(New TClearGridCommand)
	
	If MouseHit(1) Then commandStack.AddCommand(TPlotColourCommand.Create(MouseX(), MouseY(), currentColour))
	If MouseHit(2) Then commandStack.AddCommand(TPlotColourCommand.Create(MouseX(), MouseY(), colourBlack))
	
	TEditor.GetInstance().Render()

	DrawControls()
	
	DrawInfo(currentColour, commandStack.UndoCount(), commandStack.RedoCount())
	
	Flip
Wend


Function DrawControls()
	SetColor(255, 255, 255)
	DrawText("LMB - Plot Colour in Grid", 0, 0)
	DrawText("RMB - Erase Colour in Grid", 0, 15)
	DrawText("1 - Red Pen", 0, 30)
	DrawText("2 - Green Pen", 0, 45)
	DrawText("3 - Blue Pen", 0, 60)
	DrawText("U - Undo", 0, 75)
	DrawText("R - Redo", 0, 90)
	DrawText("C - Clear Grid", 0, 105)
End Function



Function DrawInfo(currentColour:TColour, undoCount:Int, redoCount:Int)
	currentColour.Set()
	DrawText("Current Pen Colour", 0, 555)
	SetColor(255, 255, 255)
	DrawText("Commands on Undo Stack: " + undoCount, 0, 570)
	DrawText("Commands on Redo Stack: " + redoCount, 0, 585)
End Function
