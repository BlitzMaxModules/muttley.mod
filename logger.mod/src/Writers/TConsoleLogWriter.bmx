'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TConsoleLogWriter Extends TLogWriter

	Field displayTimestamp:Int
	Field displaySeverity:Int
	
	
	
	Method close()
		'Nothing to do here
	End Method
	
	
	
	Method New()
		displayTimestamp = False
		displaySeverity = False
	End Method
	
	
	
	Rem
	bbdoc: Show the severity level of the message
	EndRem
	Method showSeverity(value:Int)
		displaySeverity = value
	End Method
	
	
	
	Rem
	bbdoc: Show the timestamp of the message
	EndRem	
	Method showTimestamp(value:Int)
		displayTimestamp = value
	End Method
	
	
	
	Rem
	bbdoc: Writes the received messages to STDOUT
	EndRem
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		Local line:String
		
		If displayTimestamp
			line:+message.timestamp + " "
		EndIf
		
		If displaySeverity
			line:+"" + TLogger.getInstance().severityToString(message.severity) + ": "
		End If
		
		line:+message.message
		
		Print line
	End Method

End Type
