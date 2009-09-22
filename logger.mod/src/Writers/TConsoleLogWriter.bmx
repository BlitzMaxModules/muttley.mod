Rem
'
' muttley.logger - BlitzMax Logging Module
' Copyright (C) 2009 Paul Maskelyne
'
' This software is licensed under the terms of the Artistic
' License version 2.0.
'
' For full license details, please read the file 'artistic-2_0.txt' 
' included with this distribution, or see
' http://www.perlfoundation.org/legal/licenses/artistic-2_0.html
'	
EndRem

Rem
bbdoc: A log writer that outputs to the console
EndRem
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
	
	
	
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		Local line:String
		
		If displayTimestamp
			line:+message.timestamp + " "
		EndIf
		
		If displaySeverity
			line:+"" + severityToString(message.severity) + ": "
		End If
		
		line:+message.message
		
		Print line
				
	End Method

End Type
