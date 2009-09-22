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
bbdoc: The base class of all log writers
End Rem
Type TLogWriter

	Global severityDescriptions:String[] = ["Emergency", "Alert", "Critical", "Error",  ..
		"Warning", "Notice", "Info", "Debug"]

	Rem
	bbdoc: The current log level
	about: Writers should only display/output messages that have a severity
	that is equal or lower than the level set for the writer	
	EndRem
	Field level:Int
	
	
	
	Rem
	bbdoc: Close the log writer
	about: This abstract Method needs to be implemented by all
	log writers and should be used for tidying up before shutdown,
	for example flushing and closing streams/files, etc.
	EndRem
	Method close() Abstract
	
	
	
	Rem
	bbdoc: The current log level of this writer
	EndRem
	Method getLevel:Int()
		return level
	End Method

	
	
	Rem
	bbdoc: Set the log level of this writer
	about: Writers should only display/output messages that have a severity
	that is equal or lower than the level set for the writer	
	EndRem	
	Method setLevel(severity:Int)
		If (severity >= 0) and (severity <= 7)
			level = severity
		EndIf
	End Method
	
	
	
	Rem
	bbdoc: Returns a string representation of the specified severity level	
	EndRem
	Method severityToString:String(severity:Int)
		If severity + 1 <= severityDescriptions.length
			Return severityDescriptions[severity]
		Else
			Return Null
		End If
	End Method
	
	
		
	Rem
	bbdoc: Writer a message to the log writer's output
	about: This abstract Method needs to be implemented by all
	log writers and should handle the output of the specified
	message in a way appropriate for the type of output being
	written to
	EndRem
	Method write(message:TLoggerMessage) Abstract

End Type
