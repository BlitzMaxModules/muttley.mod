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
bbdoc: Severity level 0: Emergency
EndRem
Const LOGGER_EMERGENCY:Int = 0
Rem
bbdoc: Severity level 1: Alert
EndRem
Const LOGGER_ALERT:Int = 1
Rem
bbdoc: Severity level 2: Critical
EndRem
Const LOGGER_CRITICAL:Int = 2
Rem
bbdoc: Severity level 3: Error
EndRem
Const LOGGER_ERROR:Int = 3
Rem
bbdoc: Severity level 4: Warning
EndRem
Const LOGGER_WARNING:Int = 4
Rem
bbdoc: Severity level 5: Notice
EndRem
Const LOGGER_NOTICE:Int = 5
Rem
bbdoc: Severity level 6: Info
EndRem
Const LOGGER_INFO:Int = 6
Rem
bbdoc: Severity level 7: Debug
EndRem
Const LOGGER_DEBUG:Int = 7
	


Rem
bbdoc: The primary interface for logging messages
about: All logging is handled by sending messages to this class. It then creates a new log message
and passes it to any log writers that are registered.
End Rem
Type TLogger

	Global instance:TLogger
	
	Field host:String
	Field logWriters:TList
	Field messageCounts:Int[] = [0, 0, 0, 0, 0, 0, 0, 0]
	Field runningUnitTests:Int = False
	
	
	Method New()
		If instance Throw "Cannot create multiple instances of Singleton Type"
		logWriters = New TList
		host = HostName(0)
	EndMethod

	
	
	Rem
	bbdoc: Registers a new log writer so it can receive log messages
	EndRem
	Method addWriter(writer:TLogWriter)
		logWriters.AddLast(writer)
	End Method
	
	
	
	
	' Creates a timestamp in a format suitable For Syslog as defined in
	' RFC 3164
	Method createTimestamp:String()
		Local time:TTime = TTime.CreateLocal()
		Local date:TDate = TDate.fromString(time.toString())

		' TODO:
		' -----
		' Work-around for http://code.google.com/p/maxmods/issues/detail?id=10
		' Once resolved, the format used in the timestamp
		' assignation can changed back to "$b %e" and all
		' reference to dayOfMonth removed.
		'
		Local dayOfMonth:String = date.format("%d")
		If dayOfMonth[0] = "0" Then dayOfMonth = " " + dayOfMonth[1]
		
		Return date.format("%b") + " " + dayOfMonth + " " + time.toString().Split(" ")[1]
	End Method
	
	
		
	Rem
	bbdoc: return the current host identifier used in log messages
	EndRem
	Method getHost:String()
		Return host
	End Method
	
	
	
	Rem
	bbdoc: Returns an instance of the logger
	about: The logger class is singleton type
	EndRem
	Function getInstance:TLogger()
		If Not instance
			instance = New TLogger
			Return instance
		Else
			Return instance
		EndIf
	EndFunction	

	
	
	Rem
	bbdoc: Log a message at the specified severity level
	about: Severity levels are based on those defined in RFC 3164 for the BSD Syslog protocol.
	Valid severity levels are in the range 0 to 7 and are defined as being for the following message
	types:
	<table>
		<tr> <th> Severity </th> <th> Description </th> </tr>
		<tr> <td> 0 </td> <td> Emergency: system is unusable </td> </tr>
		<tr> <td> 1 </td> <td> Alert: action must be taken immediately </td> </tr>
		<tr> <td> 2 </td> <td> Critical: critical conditions </td> </tr>
		<tr> <td> 3 </td> <td> Error: error conditions </td> </tr>
		<tr> <td> 4 </td> <td> Warning: warning conditions </td> </tr>
		<tr> <td> 5 </td> <td> Notice: normal but significant condition </td> </tr>
		<tr> <td> 6 </td> <td> Info: informational messages </td> </tr>
		<tr> <td> 7 </td> <td> Debug: debug-level messages </td> </tr>
	</table>
	EndRem
	Method logMessage(severity:Int, message:String)
		If (severity >= 0) And (severity <= 7)
			Local newMessage:TLoggerMessage = New TLoggerMessage
	
			newMessage.timestamp = createTimestamp()
			newMessage.severity = severity
			newMessage.message = message
			newMessage.host = host
			
			' Just to ensure when running unit tests that we always 
			' get the same timestamps and host name.
			If runningUnitTests
				newMessage.timestamp = "Jan  1 00:00:00"
				newMessage.host = "unitTest"
			End If
			
			For Local writer:TLogWriter = EachIn logWriters
				writer.write(newMessage)
			Next
			
			messageCounts[severity]:+1
		EndIf
	End Method
	
	
	
	Rem
	bbdoc: Logs an Alert level message
	EndRem
	Method logAlert(message:String)
		LogMessage(LOGGER_ALERT, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Critical level message
	EndRem	
	Method logCritical(message:String)
		LogMessage(LOGGER_CRITICAL, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Debug level message
	EndRem	
	Method logDebug(message:String)
		LogMessage(LOGGER_DEBUG, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Emergency level message
	EndRem	
	Method logEmergency(message:String)
		LogMessage(LOGGER_EMERGENCY, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Error level message
	EndRem	
	Method logError(message:String)
		LogMessage(LOGGER_ERROR, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Info level message
	EndRem	
	Method logInfo(message:String)
		LogMessage(LOGGER_INFO, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Notice level message
	EndRem	
	Method logNotice(message:String)
		LogMessage(LOGGER_NOTICE, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Warning level message
	EndRem	
	Method logWarning(message:String)
		LogMessage(LOGGER_WARNING, message)
	End Method

	
	
	Rem
	bbdoc: Reset the statistics count
	about: The logger keeps a count of how many of each severity of message
	it has handled, you can use this method to reset that cound to zero
	EndRem
	Method resetStatistics()
		messageCounts = [0, 0, 0, 0, 0, 0, 0, 0]
	End Method
	
	
	
	Rem
	bbdoc: set the host identifier used in log messages
	about: When the logger is instantiated it attempts to get the hostname
	of the local machine, however you can override the identifier it uses
	by setting it manually
	End Rem
	Method setHost(value:String)
		host = value
	End Method
	
	
	
	Rem
	bbdoc: Closes and de-registers all currently registered log writers
	about: This method should be called right at the end of your program
	EndRem		
	Method close()
		Local statistics:String
		For Local i:Int = 0 To 7
			statistics:+TLogWriter.severityDescriptions[i] + ":" + messageCounts[i]
			If i < 7
				statistics:+"  "
			End If
		Next
		LogInfo("[Logger] Statistics:  " + statistics)
		For Local writer:TLogWriter = EachIn logWriters
			writer.close()
			logWriters.Remove(writer)
		Next
		resetStatistics()
	End Method

EndType



Rem
bbdoc: Logs an Alert level message
EndRem
Function LogAlert(message:String)
	TLogger.getInstance().LogAlert(message)
End Function



Rem
bbdoc: Logs a Critical level message
EndRem
Function LogCritical(message:String)
	TLogger.getInstance().LogCritical(message)
End Function



Rem
bbdoc: Logs a Debug level message
EndRem
Function LogDebug(message:String)
	TLogger.getInstance().LogDebug(message)
End Function



Rem
bbdoc: Logs an Emergency level message
EndRem
Function LogEmergency(message:String)
	TLogger.getInstance().LogEmergency(message)
End Function



Rem
bbdoc: Logs an Error level message
EndRem
Function LogError(message:String)
	TLogger.getInstance().LogError(message)
End Function



Rem
bbdoc: Logs an Info level message
EndRem
Function LogInfo(message:String)
	TLogger.getInstance().LogInfo(message)
End Function



Rem
bbdoc: Logs a Notice level message
EndRem
Function LogNotice(message:String)
	TLogger.getInstance().LogNotice(message)
End Function



Rem
bbdoc: Logs a Warning level message
EndRem
Function LogWarning(message:String)
	TLogger.getInstance().LogWarning(message)
End Function
