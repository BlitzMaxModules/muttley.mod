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
bbdoc: A log writer that outputs to a file
EndRem
Type TFileLogWriter Extends TLogWriter

	Const DEFAULT_FILENAME:String = "logfile.log"
?Debug
	Const DEFAULT_LEVEL:Int = LOGGER_INFO
?Not Debug
	Const DEFAULT_LEVEL:Int = LOGGER_ERROR
?
	Const DEFAULT_OVERWRITE:Int = True
		
			
	Field displaySeverity:Int
	Field filename:String
	Field overwrite:Int
	Field stream:TStream
	
	
	Method close()
		if stream
			stream.Flush()
			stream.Close()
		End If
	End Method
	
	
	
	Method New()
		displaySeverity = True
		filename = DEFAULT_FILENAME
		level = DEFAULT_LEVEL
		overwrite = DEFAULT_OVERWRITE
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
	
	
	
	Rem
	bbdoc: Sets the path/filename that will be written to
	EndRem
	Method setFilename(value:String)
		filename = value
	End Method
	
	
	
	Rem
	bbdoc: Sets whether to overwrite an existing file or not
	EndRem
	Method setOverwrite(value:Int)
		overwrite = value
	End Method

	
	
	Rem
	bbdoc: Specify whether to show the severity level in the log file or not
	EndRem
	Method showSeverity(value:Int)
		displaySeverity = value
	End Method
		
	
	
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		If Not stream Then openLogFile()
		
		Local line:String = message.timestamp + " "
		line:+message.host + " "
		
		If displaySeverity
			line:+severityToString(message.severity) + ": "
		End If
		
		line:+message.message
		
		stream.WriteLine(line)
		stream.Flush()
	End Method

End Type
