Rem
	License Details
	---------------
	muttley.LogFileHandler - BlitzMax Log File Handler Module
	Copyright (C) 2007 Paul Maskelyne

 	This software is licensed under the terms of the Artistic
 	License version 2.0.

	For full license details, please read the file 'artistic-2_0.txt' 
	included with this distribution, or see
	http://www.perlfoundation.org/legal/licenses/artistic-2_0.html
	
EndRem

'ModuleInfo "Name: muttley.LogFileHandler"
'ModuleInfo "Version: 1.0.2"
'ModuleInfo "License: Artistic License 2.0"
'ModuleInfo "Author: Paul Maskelyne (Muttley)"
'ModuleInfo "Copyright: (c) 2007 Paul Maskelyne"
'ModuleInfo "E-Mail: muttley@muttleyville.org"
'ModuleInfo "Website: http://www.muttleyville.org"
'
'ModuleInfo "History: 1.0.2"
'ModuleInfo "History: Fixed module documentation and added a few methods to streamline writing messages"
'ModuleInfo "History: 1.0.1"
'ModuleInfo "History: Re-released under the Artistic License 2.0"
'ModuleInfo "History: 1.0.0"
'ModuleInfo "History: Initial Release"

Const LOG_GLOBAL:Int = 0	'Global message are seen no matter what log level is set
Const LOG_ERROR:Int = 1		'Error messages are seen in Error, Warn and Info log levels
Const LOG_WARN:Int = 2		'Warn messages are seen in Warn and Info log levels
Const LOG_INFO:Int = 3		'Info messages are only seen in Info log levels

Const LOG_DATE:Int = 0		'Show only Date in messages
Const LOG_TIME:Int = 1		'Show only Time in messages
Const LOG_DATETIME:Int = 2	'Show Date & Time in messages

Rem
	bbdoc: TLogFile
	about: The TLogFile Type
EndRem
Type TLogFile

	Field Handle:TStream			'Handle to the log file stream
	Field filename:String		'Logfile filename
	Field description:String	'description for log file header/footer
	Field overwrite:Int			'overwrite existing log? False = Append
	Field maxLogFileSize:Int	'Max log size allowed, if exceeded log is rotated to a .bak file
	Field logLevel:Int			'Current log level of the logfile
										'LOG_ERROR = Error messages only.  Lowest Log setting
										'LOG_WARN = Error And Warning messages
										'LOG_INFO = Error, Warning And Info.  Highest Log level setting
	Field timeStampFormat:Int	'Date/Timestamping format for messages



	Rem
		bbdoc: Create a new log file.
		returns: #TLogFile
		about: Creates, Opens and Initialises a new TLogFile object.
	EndRem
	Function Create:TLogFile(	filename:String = "logfile.log",..
										description:String = "Log File",  ..
										logLevel:Int = LOG_ERROR,  ..
										timeStampFormat:Int = LOG_TIME,  ..
										overwrite:Int = True,  ..
										maxLogFileSize:Int = 104857600)
	
		Local newlogfile:TLogFile = New TLogFile
	
		newlogfile.filename = filename
		newlogfile.description = description
		newlogfile.overwrite = overwrite
		newlogfile.maxLogFileSize = maxLogFileSize
		newlogfile.logLevel = logLevel
		
		newlogfile.SetTimeStampFormat(timeStampFormat)
			
		'Initialise the new log file now it's created
		newlogfile.Init()
			
		Return newlogfile
			
	End Function	

	
	
	Rem
		bbdoc: Sets the timestamp format used when writing entries to the log file
		returns:
		about: The timestamp formats available are as follows:
		<table>
		<tr><th>Format</th><th>Description</th></tr>
		<tr><td>LOG_DATE</td><td>Log the date in <em>DD MMM YYYY</em> format</td></tr>
		<tr><td>LOG_TIME</td><td>Log the time in <en>HH:MM:SS</em> format</td></tr>
		<tr><td>LOG_DATETIME</td><td>Log both the date and time in <em>DD MMM YYYY, HH:MM:SS</em> format</td></tr>				
		</table>
	EndRem
	Method SetTimeStampFormat(format:Int)
		timeStampFormat = format
		Return
	End Method

		
	
	Method CreateTimeStamp:String()
		
		Select timeStampFormat
			Case LOG_DATE
				Return CurrentDate()
			Case LOG_TIME
				Return CurrentTime()
			Case LOG_DATETIME
				Return CurrentDate() + ", " + CurrentTime()
			Default
				Return CurrentTime()
		EndSelect
		
	End Method

		
	'Initialise the log file.  NOTE: This is an internal Method And should Not be called manually
	Method Init()
		'Check if log filename is valid
		Assert Filename <> "", "No filename specified for log file"
		Assert FileType( Filename ) <> 2, "Requested log file, "+Filename+", is a directory"

		If FileSize( Filename ) = -1
			'Log file doesn't already exist so start a new one
			handle = WriteStream( Filename )
		Else
			If overwrite = True
				'Just open file and overwrite it
				handle = WriteStream( Filename )
			Else
				'Append to existing log file
				If FileSize( Filename ) >= maxLogFileSize
					'Backup existing log file and start a new one
					Self.Rotate()
				Else
					'Open existing file and seek the current EOF to start appending
					handle = OpenStream( Filename )
					Assert handle, "Unable to Open Log File: "+Filename
					SeekStream( handle, handle.Size() )
				EndIf
			EndIf
		EndIf
	
		'Catch any failures to open the log file
		Assert handle, "Unable to Open Log File: "+Filename
		
		'File successfully opened so write the header
		Self.WriteHeader()
	End Method

	

	'Write log file header. NOTE: This is an internal Method And should Not be called manually
	Method WriteHeader()
		Local header:String="", divider:String=""
		Local i:Int		
		
		'Create and write header information to log file
		If description <> ""
			header = description+": Started - "+CurrentDate()+", "+CurrentTime()
		Else
			header = "Log Started - "+CurrentDate()+", "+CurrentTime()
		EndIf
		For i = 1 To header.length
			divider = divider+"-"
		Next
		WriteLine( handle, divider )
		WriteLine( handle, header )
		WriteLine( handle, divider )
	End Method

	

	'Write log file footer. NOTE: This is an internal Method And should Not be called manually
	Method WriteFooter()
		Local footer:String="", divider:String=""
		Local i:Int		
		
		'Create and write footer information to log file
		If description <> ""
			footer = description+": Finished - "+CurrentDate()+", "+CurrentTime()
		Else
			footer = "Log Finished - "+CurrentDate()+", "+CurrentTime()
		EndIf
		For i = 1 To footer.length
			divider = divider+"-"
		Next
		WriteLine( handle, divider )
		WriteLine( handle, footer )
		WriteLine( handle, divider )
	End Method

	

	'Rotate Log File if required.  NOTE: This is an internal Method And should NOT be called manually
	Method Rotate()
		'TODO: Maybe add the ability to have a specified number of backup
		'      log files (file.1, file.2, etc.)
		Local backupfilename:String = Filename + ".bak"
	
		'Write size exceeded message and a footer to the file
		If handle
			WriteLine( handle, "GLOBAL: " + CreateTimestamp() + " - maxLogFileSize Exceeded" )
			Self.WriteFooter()
			CloseStream( handle )
		EndIf
	
		'Delete any existing backup file
		If FileType( backupfilename ) = 1
			Assert DeleteFile( backupfilename ), "Unable to delete old log file: "+backupfilename
		EndIf
		
		Assert RenameFile( Filename, backupfilename ), "Unable to rename log file: "+Filename
		
		handle =  WriteStream( Filename )
		Assert handle, "Unable to open log file: "+Filename
		Self.WriteHeader()
		WriteLine( handle, "  INFO: " + CurrentTime() + " - Log Rotated to " + backupfilename )
	End Method


	
	Rem
		bbdoc: Close the Log File
		returns:
		about: Writes a footer message and then closes the #TLogFile
	EndRem
	'Close Log File.  This Method writes a footer To the Log file, And Then closes it
	Method Close()
		Self.WriteFooter()
		CloseStream( handle )
	End Method

	
		
	' TODO: Deprecated.  Remove this method for the next major version
	Method WriteEntry(entry:String, level:Int = LOG_ERROR)
		LogEntry(entry, level)
	EndMethod

	
		
	rem
		bbdoc: Write a LOG_GLOBAL message to the log file
		returns:
	endrem
	Method LogGlobal(entry:String)
		LogEntry(entry, LOG_GLOBAL)
	End Method

	
	
	rem
		bbdoc: Write a LOG_INFO message to the log file
		returns:
	endrem		
	Method LogInfo(entry:String)
		LogEntry(entry, LOG_INFO)
	End Method

	
	
	rem
		bbdoc: Write a LOG_WARN message to the log file
		returns:
	endrem		
	Method LogWarn(entry:String)
		LogEntry(entry, LOG_WARN)
	End Method

	
	
	rem
		bbdoc: Write a LOG_ERROR message to the log file
		returns:
	endrem		
	Method LogError(entry:String)
		LogEntry(entry, LOG_ERROR)
	End Method	

	
		
	Rem
		bbdoc: Write an entry to the Log file
		returns:
		about: Write an entry string with a specified log level to the log file.
		If the entry's log level is outside the scope of the log file's level, the entry is not written.
		<br>
		Valid log levels are as follows:
		<table>
		<tr><th>Log Level</th><th>Description</th></tr>
		<tr><td>LOG_GLOBAL</td><td>Written to the #TLogFile no matter what log level is set</td></tr>
		<tr><td>LOG_ERROR</td><td>Written to the #TLogFile when it is set to LOG_ERROR, LOG_WARN or LOG_INFO levels</td></tr>
		<tr><td>LOG_WARN</td><td>Written to the #TLogFile when it is set to LOG_WARN or LOG_INFO levels</td></tr>				
		<tr><td>LOG_INFO</td><td>Written to the #TLogFile when it is set to LOG_INFO level only</td></tr>	
		</table>
	EndRem
	Method LogEntry(entry:String, level:Int = LOG_ERROR)

		If level > logLevel Then Return
		
		Local output:String = ""
		
		Select level
			Case LOG_GLOBAL
				output = "GLOBAL: "
			Case LOG_INFO
				output = "  INFO: "
			Case LOG_WARN
				output = "  WARN: "
			Case LOG_ERROR
				output = " ERROR: "
		End Select
		
		WriteLine( handle, output + CreateTimeStamp() + " - " + entry )
		
		FlushStream(handle)
		
		If handle.Size() >= maxLogFileSize
			Self.Rotate()
		EndIf
		
	End Method

	
		
	Rem
		bbdoc: Change the log file level of the log file
		returns:
		about: Valid log levels are as follows:
		<table>
		<tr><th>Log Level</th><th>Description</th></tr>
		<tr><td>LOG_ERROR</td><td>Lowest log level.  Only LOG_GLOBAL and LOG_ERROR messages are written to the log file</td></tr>
		<tr><td>LOG_WARN</td><td>Medium log level.  LOG_GLOBAL, LOG_WARN and LOG_ERROR messages are written to the log file</td></tr>				
		<tr><td>LOG_INFO</td><td>Highest log level.  LOG_GLOBAL, LOG_INFO, LOG_WARN and LOG_ERROR are written to the log file.</td></tr>	
		</table>	
	EndRem
	Method SetLevel( level:Byte = LOG_INFO )
		If level < LOG_ERROR Or level > LOG_INFO
			Return
		Else
			Select level
				Case LOG_ERROR
					Self.WriteEntry( "Log Level Changed to LOG_ERROR", LOG_GLOBAL )
				Case LOG_WARN
					Self.WriteEntry( "Log Level Changed to LOG_WARN", LOG_GLOBAL )
				Case LOG_INFO
					Self.WriteEntry( "Log Level Changed to LOG_INFO", LOG_GLOBAL )
			End Select
			Self.logLevel = level
			Return
		EndIf
	End Method
			
End Type

rem
	bbdoc:
	keyword: LOG_INFO
endrem

rem
	bbdoc:
	keyword: LOG_GLOBAL
endrem

rem
	bbdoc:
	keyword: LOG_WARN
endrem

rem
	bbdoc:
	keyword: LOG_ERROR
endrem

