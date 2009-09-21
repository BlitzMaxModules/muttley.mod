Rem
bbdoc: The primary interface for logging messages
about: All logging is handled by sending messages to this class. It then creates a new log message
and passes it to any log writers that are registered.
End Rem
Type TLogger

	Const LOG_EMERGENCY:Int = 0
	Const LOG_ALERT:Int = 1
	Const LOG_CRITICAL:Int = 2
	Const LOG_ERROR:Int = 3
	Const LOG_WARNING:Int = 4
	Const LOG_NOTICE:Int = 5
	Const LOG_INFO:Int = 6
	Const LOG_DEBUG:Int = 7
	
	Global instance:TLogger
	
	Global severityDescriptions:String[] = ["Emergency", "Alert", "Critical", "Error",  ..
		"Warning", "Notice", "Info", "Debug"]	

	Global messageCounts:Int[] = [0, 0, 0, 0, 0, 0, 0, 0]
	
	Field host:String
	Field logWriters:TList
	Field messageToSend:TLoggerMessage
	
	Field runningUnitTests:Int = False
	
		
	
	Method New()
		If instance Throw "Cannot create multiple instances of Singleton Type"
		logWriters = New TList
		messageToSend = New TLoggerMessage
		host = HostName(0)
	EndMethod

	
	
	Rem
	bbdoc: Registers a new log writer so it can receive log messages
	EndRem
	Method addWriter(writer:TLogWriter)
		logWriters.AddLast(writer)
	End Method
	
	
	
	Method createTimestamp:String()
		Local time:TTime = TTime.CreateLocal()
		Local date:TDate = TDate.fromString(time.toString())

		' TODO:
		' -----
		' This is a work-around for http://code.google.com/p/maxmods/issues/detail?id=10
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
		<tr>
			<th> Severity </th>
			<th> Description </th>
		</tr>
		<tr>
			<td> 0 </td>
			<td> Emergency: system is unusable </td>
		</tr>
		<tr>
			<td> 1 </td>
			<td> Alert: action must be taken immediately </td>
		</tr>
		<tr>
			<td> 2 </td>
			<td> Critical: critical conditions </td>
		</tr>
		<tr>
			<td> 3 </td>
			<td> Error: error conditions </td>
		</tr>
		<tr>
			<td> 4 </td>
			<td> Warning: warning conditions </td>
		</tr>
		<tr>
			<td> 5 </td>
			<td> Notice: normal but significant condition </td>
		</tr>
		<tr>
			<td> 6 </td>
			<td> Info: informational messages </td>
		</tr>
		<tr>
			<td> 7 </td>
			<td> Debug: debug-level messages </td>
		</tr>
	</table>
	EndRem
	Method logMessage(severity:Int, message:String)
		If (severity >= 0) And (severity <= 7)
		
			' TODO:
			' -----
			' Currently we use the same, pre-allocated message object
			' for each message we send. We may eventually want to
			' buffer and queue/batch messages.
			'
			messageToSend.timestamp = createTimestamp()
			messageToSend.severity = severity
			messageToSend.message = message
			messageToSend.host = host
			
			' Just to ensure when running unit tests that we always 
			' get the same timestamps and host name.
			If runningUnitTests
				messageToSend.timestamp = "Jan  1 00:00:00"
				messageToSend.host = "unitTest"
			End If
			
			For Local writer:TLogWriter = EachIn logWriters
				writer.write(messageToSend)
			Next
			
			messageCounts[severity]:+1
		EndIf
	End Method
	
	
	
	Rem
	bbdoc: Logs an Alert level message
	EndRem
	Method logAlert(message:String)
		LogMessage(LOG_ALERT, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Critical level message
	EndRem	
	Method logCritical(message:String)
		LogMessage(LOG_CRITICAL, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Debug level message
	EndRem	
	Method logDebug(message:String)
		LogMessage(LOG_DEBUG, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Emergency level message
	EndRem	
	Method logEmergency(message:String)
		LogMessage(LOG_EMERGENCY, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Error level message
	EndRem	
	Method logError(message:String)
		LogMessage(LOG_ERROR, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs an Info level message
	EndRem	
	Method logInfo(message:String)
		LogMessage(LOG_INFO, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Notice level message
	EndRem	
	Method logNotice(message:String)
		LogMessage(LOG_NOTICE, message)
	End Method
	
	
	
	Rem
	bbdoc: Logs a Warning level message
	EndRem	
	Method logWarning(message:String)
		LogMessage(LOG_WARNING, message)
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
	
	
	
	Method severityToString:String(severity:Int)
		If severity + 1 <= severityDescriptions.length
			Return severityDescriptions[severity]
		Else
			Return Null
		End If
	End Method
	
	
		
	Rem
	bbdoc: Closes and de-registers all currently registered log writers
	about: This method should be called right at the end of your program
	EndRem		
	Method close()
		Local statistics:String
		For Local i:Int = 0 To 7
			statistics:+severityDescriptions[i] + ":" + messageCounts[i]
			If i < 7
				statistics:+"  "
			End If
		Next
		LogInfo("[Logger] Statistics:  " + statistics)
		For Local writer:TLogWriter = EachIn logWriters
			writer.close()
			logWriters.Remove(writer)
		Next
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
