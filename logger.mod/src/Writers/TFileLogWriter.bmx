'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TFileLogWriter Extends TLogWriter

	Const DEFAULT_DESCRIPTION:String = "Log File"
	Const DEFAULT_FILENAME:String = "logfile.log"
	
	?Debug
		Const DEFAULT_LEVEL:Int = TLogger.LOG_INFO
	?Not Debug
		Const DEFAULT_LEVEL:Int = TLogger.LOG_ERROR
	?
	
	Const DEFAULT_MAX_FILESIZE:Int = 104857600
	Const DEFAULT_OVERWRITE:Int = True

	Global severityDescriptions:String[] = [" emerg", " alert", "  crit", " error",  ..
		"  warn", "notice", "  info", " debug"]
			
	Field description:String
	Field filename:String
	Field maxFileSize:Int
	Field overwrite:Int
	Field stream:TStream
	Field displaySeverity:Int = true
	
	Function Create:TFileLogWriter(filename:String = DEFAULT_FILENAME, description:String = DEFAULT_DESCRIPTION,  ..
		level:Int = DEFAULT_LEVEL, overwrite:Int = DEFAULT_OVERWRITE, maxFileSize:Int = DEFAULT_MAX_FILESIZE)
		
		Local newLogfile:TFileLogWriter = New TFileLogWriter

		newLogfile.description = description
		newLogfile.filename = filename
		newLogfile.level = level
		newLogfile.overwrite = overwrite
		newLogfile.maxFileSize = maxFileSize
		
		Return newLogFile
	End Function

	Method close()
		if stream
			stream.Flush()
			stream.Close()
		End If
	End Method
	
	Method New()
		description = DEFAULT_DESCRIPTION
		filename = DEFAULT_FILENAME
		level = DEFAULT_LEVEL
		overwrite = DEFAULT_OVERWRITE
		maxFileSize = DEFAULT_MAX_FILESIZE
	End Method
	
	Method openLogFile()
		Assert filename <> "", "No filename specified for log file."
		Assert FileType(filename) <> 2, "Requested log file ~q" + filename + "~q is a directory."
		
		If (FileSize(filename) = -1) Or (overwrite = True)
			' log file doesn't exist already are we want to overwrite it
			stream = WriteStream(filename)
			Assert stream, "Unable to create new log file: " + filename
		Else
			stream = OpenStream(filename)
			Assert stream, "Unable to open existing log file: " + filename
			SeekStream(stream, stream.Size())
		End If
	End Method
	
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		If Not stream Then openLogFile()
		
		Local line:String = message.timestamp + " "
		line:+message.host + " "
		
		If displaySeverity
			Local severityDisplay:String
		
			If message.severity + 1 <= severityDescriptions.Length
				severityDisplay = severityDescriptions[message.severity]
				line:+severityDisplay + ": "
			endif
		End If
		
		line:+message.message
		
		stream.WriteLine(line)
		stream.Flush()
	End Method

End Type
