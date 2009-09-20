'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type LogWriterTests Extends TTest

	Field logger:TLogger
	Field logWriter:TUnitTestLogWriter

	Method setup() {before}
		logger = TLogger.getInstance()
		logger.runningUnitTests = True
		
		logWriter = new TUnitTestLogWriter
		logWriter.setLevel(7)
		logger.addWriter(logWriter)
		
		logger.addWriter(New TConsoleLogWriter)
		
		logger.addWriter(New TSyslogLogWriter)
		
		logger.addWriter(new TFileLogWriter)
	End Method
	
	Method breakDown() {after}
		logger.close()
		logger = Null
	End Method

	Method sendTestMessages()
		for local i:Int = 0 to 7
			for local k:Int = 1 to 10
				logger.logMessage(i, "severity " + i + " test message " + k)
			Next
		Next
	End Method
	
	Method testValidSetLevel() {test}
		for local i:Int = 0 to 7
			logWriter.setLevel(i)
			assertEqualsI(i, logWriter.getLevel())
		next
	End Method
	
	Method testInvalidSetLevel() {test}
		local currentLevel:Int = logWriter.getLevel()
		
		logWriter.setLevel(-1)
		assertEqualsI(currentLevel, logWriter.getLevel())
		
		logWriter.setLevel(8)
		assertEqualsI(currentLevel, logWriter.getLevel())
	End Method
	
	Method testReceivedMessagesLevel0() {test}
		logWriter.setLevel(0)
		sendTestMessages()
		assertEqualsI(10, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel1() {test}
		logWriter.setLevel(1)
		sendTestMessages()
		assertEqualsI(20, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel2() {test}
		logWriter.setLevel(2)
		sendTestMessages()
		assertEqualsI(30, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel3() {test}
		logWriter.setLevel(3)
		sendTestMessages()
		assertEqualsI(40, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel4() {test}
		logWriter.setLevel(4)
		sendTestMessages()
		assertEqualsI(50, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel5() {test}
		logWriter.setLevel(5)
		sendTestMessages()
		assertEqualsI(60, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel6() {test}
		logWriter.setLevel(6)
		sendTestMessages()
		assertEqualsI(70, logWriter.received.Count())
	End Method
	
	Method testReceivedMessagesLevel7() {test}
		logWriter.setLevel(7)
		sendTestMessages()
		assertEqualsI(80, logWriter.received.Count())
	End Method
End Type
