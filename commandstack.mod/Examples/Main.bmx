Local colourRed:TColour = TColour.Red()
Local colourGreen:TColour = TColour.Green()
Local colourBlue:TColour = TColour.Blue()
Local colourBlack:TColour = TColour.Black()

Local currentColour:TColour = colourRed

Global commandStack:TCommandStack = New TCommandStack

Local macroCommand:TMacroCommand
Local recordingMacro:Int = False

AppTitle = "Command Stack Example"

Graphics(800, 600, 0, 60)

While Not KeyHit(KEY_ESCAPE) And Not AppTerminate()
	Cls
	
	If KeyHit(KEY_1) Then currentColour = colourRed
	If KeyHit(KEY_2) Then currentColour = colourGreen
	If KeyHit(KEY_3) Then currentColour = colourBlue
	
	If (KeyDown(KEY_LCONTROL) Or KeyDown(KEY_RCONTROL)) And KeyHit(KEY_Z)
		commandStack.Undo()
	EndIf
	
	If (KeyDown(KEY_LCONTROL) Or KeyDown(KEY_RCONTROL)) And KeyHit(KEY_Y)
		commandStack.Redo()
	EndIf
	
	If KeyHit(KEY_C) Then SubmitCommand(New TClearGridCommand, recordingMacro, macroCommand)
	
	If KeyHit(KEY_S) Then commandStack.ProgressSaved()
	
	If KeyHit(KEY_R) And Not (KeyDown(KEY_LCONTROL) Or KeyDown(KEY_RCONTROL))
		recordingMacro:~True
		If recordingMacro
			macroCommand = New TMacroCommand
		End If
	End If
	
	If KeyHit(KEY_P)
		If Not recordingMacro And macroCommand
			SubmitCommand(macroCommand, recordingMacro, macroCommand)
		End If
	End If
	
	If MouseHit(1) Then SubmitCommand(TPlotColourCommand.Create(MouseX(), MouseY(), currentColour), recordingMacro, macroCommand)
	If MouseHit(2) Then SubmitCommand(TPlotColourCommand.Create(MouseX(), MouseY(), colourBlack), recordingMacro, macroCommand)
	
	TEditor.GetInstance().Render()

	DrawControls()
	
	DrawInfo(currentColour, commandStack.UndoCount(), commandStack.RedoCount(), commandStack.IsDirty(), recordingMacro)
	
	Flip
Wend



Function DrawControls()
	SetColor(255, 255, 255)
	DrawText("Escape - Exit", 0, 0)
	DrawText("LMB - Plot Colour in Grid", 0, 25)
	DrawText("RMB - Erase Colour in Grid", 0, 40)
	DrawText("1 - Red Pen", 0, 65)
	DrawText("2 - Green Pen", 0, 80)
	DrawText("3 - Blue Pen", 0, 95)
	DrawText("C - Clear Grid", 0, 120)
	DrawText("Ctrl+Z - Undo", 0, 145)
	DrawText("Ctrl+Y - Redo", 0, 160)
	DrawText("R - Record Macro", 0, 185)
	DrawText("P - Playback Macro", 0, 210)
	DrawText("S - Pretend to Save", 0, 235)
End Function



Function DrawInfo(currentColour:TColour, undoCount:Int, redoCount:Int, dirty:Int, recording:Int)
	currentColour.Set()
	DrawText("Current Pen Colour", 0, 525)
	SetColor(255, 255, 255)

	Local dirtyStatus:String
	If dirty
		dirtyStatus = "True"
	Else
		dirtyStatus = "False"
	EndIf

	Local recordingStatus:String
	If recording
		recordingStatus = "True"
	Else
		recordingStatus = "False"
	EndIf
	
	DrawText("Recording Macro: " + recordingStatus, 0, 540)
	DrawText("Need to Save: " + dirtyStatus, 0, 555)
	DrawText("Commands on Undo Stack: " + undoCount, 0, 570)
	DrawText("Commands on Redo Stack: " + redoCount, 0, 585)
End Function



Function SubmitCommand(command:TCommand, recording:Int, macroCommand:TMacroCommand = Null)
	If recording And macroCommand
		macroCommand.AddCommand(command)
	End If
	commandStack.AddCommand(command)
End Function