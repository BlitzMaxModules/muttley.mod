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

SuperStrict

Import muttley.logfilehandler

'This is an example of standard usage of a log file
Local myLogFile:TLogFile = TLogFile.Create( "myLogFile.log", "My Test LogFile", LOG_ERROR, LOG_DATETIME )

myLogFile.SetLevel( LOG_ERROR )

myLogFile.WriteEntry( "This is a LOG_GLOBAL message.  These are seen regardless of the logging level.", LOG_GLOBAL )
myLogFile.WriteEntry( "This is a LOG_ERROR message.  These are seen in LOG_ERROR, LOG_WARN and LOG_INFO levels." )  'LOG_ERROR is default message class
myLogFile.WriteEntry( "This is a LOG_WARN message.  These are seen in LOG_WARN and LOG_INFO levels.", LOG_WARN )
myLogFile.WriteEntry( "This is a LOG_INFO message.  These are seen in LOG_INFO levels.", LOG_INFO )

myLogFile.SetLevel( LOG_WARN )

myLogFile.WriteEntry( "This is a LOG_GLOBAL message.  These are seen regardless of the logging level.", LOG_GLOBAL )
myLogFile.WriteEntry( "This is a LOG_ERROR message.  These are seen in LOG_ERROR, LOG_WARN and LOG_INFO levels." )
myLogFile.WriteEntry( "This is a LOG_WARN message.  These are seen in LOG_WARN and LOG_INFO levels.", LOG_WARN )
myLogFile.WriteEntry( "This is a LOG_INFO message.  These are seen in LOG_INFO levels.", LOG_INFO )

myLogFile.SetLevel( LOG_INFO )

myLogFile.WriteEntry( "This is a LOG_GLOBAL message.  These are seen regardless of the logging level.", LOG_GLOBAL )
myLogFile.WriteEntry( "This is a LOG_ERROR message.  These are seen in LOG_ERROR, LOG_WARN and LOG_INFO levels." )
myLogFile.WriteEntry( "This is a LOG_WARN message.  These are seen in LOG_WARN and LOG_INFO levels.", LOG_WARN )
myLogFile.WriteEntry( "This is a LOG_INFO message.  These are seen in LOG_INFO levels.", LOG_INFO )

myLogFile.Close

myLogFile = Null

'An example of a log file using log rotation
Global myRotatingLogFile:TLogFile = TLogFile.Create( "myRotatingLogFile.log", "My Rotating Test LogFile", LOG_ERROR, LOG_TIME, True, 10240 )

Local imageArray:TImage[200]

For Local i:Int = 0 To 199
	Local file:String = "myImage" + i + ".png"
	imageArray[i] = LoadImage( file )
	If not imageArray[i] Then myRotatingLogfile.WriteEntry( "Unable to load image file: "+ file )
Next

myRotatingLogFile.Close

myRotatingLogFile = Null
