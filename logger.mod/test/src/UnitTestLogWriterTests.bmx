
' Unit tests for a generic log writer
'
Type UnitTestLogWriterTests Extends TTest

	Field logger:TLogger
	Field logWriter:TUnitTestLogWriter


	Method breakDown() {after}
		logger.close()
		logger = Null
	End Method
	
	
			
	Method setup() {before}
		logger = TLogger.getInstance()
		logger.runningUnitTests = True
		
		logWriter = new TUnitTestLogWriter
		logger.addWriter(logWriter)
	End Method


	
	' Send test messages at all possible severity levels
	Method sendTestMessages()
		For Local i:Int = 0 To 7
			For Local j:Int = 1 To 10
				logger.logMessage(i, "Severity " + i + " level message " + j + "/10")
			Next
		Next
	End Method
	
	
	' Check we can set valid log levels
	Method testValidSetLevel() {test}
		for local i:Int = 0 to 7
			logWriter.setLevel(i)
			assertEqualsI(i, logWriter.getLevel())
		next
	End Method
	
	
	
	' Check we can't set invalid log levels
	Method testInvalidSetLevel() {test}
		local currentLevel:Int = logWriter.getLevel()
		
		logWriter.setLevel(-1)
		assertEqualsI(currentLevel, logWriter.getLevel())
		
		logWriter.setLevel(8)
		assertEqualsI(currentLevel, logWriter.getLevel())
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel0() {test}
		logWriter.setLevel(0)
		sendTestMessages()
		assertEqualsI(10, logWriter.nMessagesReceived)
	End Method
	

		
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel1() {test}
		logWriter.setLevel(1)
		sendTestMessages()
		assertEqualsI(20, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel2() {test}
		logWriter.setLevel(2)
		sendTestMessages()
		assertEqualsI(30, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel3() {test}
		logWriter.setLevel(3)
		sendTestMessages()
		assertEqualsI(40, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel4() {test}
		logWriter.setLevel(4)
		sendTestMessages()
		assertEqualsI(50, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel5() {test}
		logWriter.setLevel(5)
		sendTestMessages()
		assertEqualsI(60, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel6() {test}
		logWriter.setLevel(6)
		sendTestMessages()
		assertEqualsI(70, logWriter.nMessagesReceived)
	End Method
	
	
	
	' Check the writer receives the correct amount of messages at
	' this log level
	Method testReceivedMessagesLevel7() {test}
		logWriter.setLevel(7)
		sendTestMessages()
		assertEqualsI(80, logWriter.nMessagesReceived)
	End Method
	
End Type
