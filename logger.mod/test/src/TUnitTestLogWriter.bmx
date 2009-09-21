
' Dummy log writer implementation for use with unit tests
'
Type TUnitTestLogWriter Extends TLogWriter

	Field nMessagesReceived:Int
	
	Method close()
		Return
	End Method

	Method New()
		nMessagesReceived = 0
	End Method
	
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		nMessagesReceived:+1
	End Method
	
End Type
