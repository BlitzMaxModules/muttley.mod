Const COLOUR_1_R:Int = 0
Const COLOUR_1_G:Int = 0
Const COLOUR_1_B:Int = 0

Const COLOUR_2_R:Int = 255
Const COLOUR_2_G:Int = 0
Const COLOUR_2_B:Int = 0

Const COLOUR_3_R:Int = 0
Const COLOUR_3_G:Int = 255
Const COLOUR_3_B:Int = 0

Const COLOUR_4_R:Int = 0
Const COLOUR_4_G:Int = 0
Const COLOUR_4_B:Int = 255

Global colours:Int[16, 16]

ClearGrid()

Graphics(800, 600, 0, 60)

Global g_commandStack:TCommandStack = New TCommandStack

Global currentColour:Int = 1

While Not KeyHit(KEY_ESCAPE)
	Cls
	
	If KeyHit(KEY_1) Then currentColour = 1
	If KeyHit(KEY_2) Then currentColour = 2
	If KeyHit(KEY_3) Then currentColour = 3
	
	If KeyHit(KEY_U) Then g_commandStack.Undo()
	If KeyHit(KEY_R) Then g_commandStack.Redo()
	
	If KeyHit(KEY_C) Then g_commandStack.AddCommand(New TClearGridCommand)
	
	If MouseHit(1) Then g_commandStack.AddCommand(TPlotColourCommand.Create(MouseX(), MouseY(), currentColour))
	If MouseHit(2) Then g_commandStack.AddCommand(TPlotColourCommand.Create(MouseX(), MouseY(), 0))
	
	DrawBlocks()
	
	DrawGrid()
	
	DrawControls()
	
	DrawInfo()
	
	Flip
Wend

Function ClearGrid()
	For Local x:Int = 0 To 15
		For Local y:Int = 0 To 15
			colours[x, y] = 0
		Next
	Next
End Function

Function DrawBlocks()
	For Local x:Int = 0 To 15
		For Local y:Int = 0 To 15
			SetPenColour(colours[x, y])
			DrawRect(200 + (x * 25), 100 + (y * 25), 25, 25)
		Next
	Next	
End Function

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

Function DrawGrid()
	For Local i:Int = 0 To 16
		SetColor(255, 255, 255)
		DrawLine(200, 100 + (i * 25), 600, 100 + (i * 25))
		DrawLine(200 + (i * 25), 100, 200 + (i * 25), 500)
	Next
End Function

Function DrawInfo()
	SetPenColour(currentColour)
	DrawText("Current Pen Colour", 0, 555)
	SetColor(255, 255, 255)
	DrawText("Commands on Undo Stack: " + g_commandStack.UndoCount(), 0, 570)
	DrawText("Commands on Redo Stack: " + g_commandStack.RedoCount(), 0, 585)
End Function

Function PlotColour(x:Int, y:Int)
	If x < 200 Or x > 600 Then Return
	If y < 100 Or y > 500 Then Return
	
	Local xCell:Int = (x - 200) / 25
	Local yCell:Int = (y - 100) / 25
	
	colours[xCell, yCell] = currentColour
End Function


Function EraseColour(x:Int, y:Int)
	If x < 200 Or x > 600 Then Return
	If y < 100 Or y > 500 Then Return
	
	Local xCell:Int = (x - 200) / 25
	Local yCell:Int = (y - 100) / 25
	
	colours[xCell, yCell] = 0
End Function

Function SetPenColour(colourId:Int)
	Select colourId
		Case 0
			SetColor (COLOUR_1_R, COLOUR_1_G, COLOUR_1_B)
		Case 1
			SetColor (COLOUR_2_R, COLOUR_2_G, COLOUR_2_B)
		Case 2
			SetColor (COLOUR_3_R, COLOUR_3_G, COLOUR_3_B)
		Case 3
			SetColor (COLOUR_4_R, COLOUR_4_G, COLOUR_4_B)
	End Select
End Function