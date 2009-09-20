Rem
bbdoc: The base class of all log writers
End Rem
Type TLogWriter

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
	bbdoc: Close the log writer
	about: This abstract Method needs to be implemented by all
	log writers and should handle the output of the specified
	message in a way appropriate for the type of output being
	written to
	EndRem
	Method write(message:TLoggerMessage) Abstract

End Type
