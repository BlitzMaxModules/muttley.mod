Rem

An example of how to create a custom log writer.
This one is for displaying messages on-screen while testing a game.

Press the Escape key to exit.

EndRem

SuperStrict

Import muttley.logger

Const SCREEN_WIDTH:Int = 800
Const SCREEN_HEIGHT:Int = 600

Graphics (SCREEN_WIDTH, SCREEN_HEIGHT)

SetBlend (ALPHABLEND)

Global font:TImageFont = LoadImageFont("data/VeraMoBd.ttf", 20)
Global statsFont:TImageFont = LoadImageFont("data/VeraMoBd.ttf", 14)
Global logger:TLogger = New TLogger

Local customWriter:CustomLogWriter = New CustomLogWriter
logger.addWriter(customWriter)

Local nextMessage:Int = MilliSecs() + Rand(10, 1000)

While Not KeyHit(KEY_ESCAPE)
	Cls
	
	If MilliSecs() >= nextMessage
		nextMessage = MilliSecs() + Rand(10, 1000)
		sendMessage()
	End If
	
	customWriter.update()
	
	customWriter.render()
	
	SetColor(255, 255, 255)
	SetAlpha(1.0)
	
	Local statistics:String
	For Local i:Int = 0 To 7
		statistics:+TLogWriter.severityDescriptions[i] + ":" + logger.messageCounts[i]
		If i < 7
			statistics:+"  "
		End If
	Next
	
	SetImageFont(statsFont)
	DrawText (statistics, (SCREEN_WIDTH - TextWidth(statistics)) / 2, 0)
	
	Flip
WEnd



Function sendMessage()
	Local severity:Int = Rand(0, 7)
	logger.LogMessage(severity, "This is a test message sent at severity level " + severity)
End Function



Type CustomLogWriter Extends TLogWriter

	Field severityR:Int[] = [255, 255, 255, 255, 255, 174, 89, 0]
	Field severityG:Int[] = [0, 128, 166, 208, 255, 255, 255, 255]
	Field severityB:Int[] = [0, 0, 0, 0, 0, 0, 0, 0]
	
	Const FADE_SPEED:Float = 0.005
	
	Field lineHeight:Int
	Field messages:TList = New TList
	
	Method close()
		' Nothing to do
	End Method
	
	Method New()
		SetImageFont(font)
		lineHeight = TextHeight("A")
	End Method

	Method render()
		SetImageFont(font)
		Local yPos:Int = SCREEN_HEIGHT - (lineHeight * messages.Count())
		For Local message:CustomMessage = EachIn messages
			SetAlpha(message.alpha)
			SetColor(severityR[message.severity], severityG[message.severity], severityB[message.severity])
			DrawText(message.message, message.xPos, yPos)
			yPos:+lineHeight
		Next
	End Method
	
	Method update()
		For Local message:CustomMessage = EachIn messages
			message.alpha:-FADE_SPEED
			If message.alpha <= 0.0 Then messages.Remove(message)
		Next
	End Method
	
	Method write(message:TLoggerMessage)
		Local newMessage:CustomMessage = New CustomMessage
		newMessage.message = severityToString(message.severity) + ": " + message.message
		newMessage.severity = message.severity
		SetImageFont(font)
		newMessage.xPos = (SCREEN_WIDTH - TextWidth(newMessage.message)) / 2
		messages.AddLast(newMessage)
	End Method
	
End Type



Type CustomMessage
	Field alpha:Float = 1.0
	Field message:String
	Field severity:Int
	Field xPos:Int
End Type


