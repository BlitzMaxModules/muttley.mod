'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type LoggerTests Extends TTest

	Field logger:TLogger

	Method setup() {before}
		logger = TLogger.getInstance()
		logger.runningUnitTests = True
	End Method
	
	Method breakDown() {after}
		logger.close()
		logger = Null
	End Method
	
	Method testGetInstance() {test}
		assertNotNull(logger)
	End Method
	
	Method testAddWriter() {test}
		Local nWriters:Int = logger.logWriters.Count()
		assertEqualsI(0, nWriters)
		
		logger.addWriter(New TUnitTestLogWriter)
		assertEqualsI(1, logger.logWriters.Count())
	End Method
	
	Method testClose() {test}
		logger.addWriter(New TUnitTestLogWriter)
		logger.addWriter(New TUnitTestLogWriter)
		logger.addWriter(New TUnitTestLogWriter)
		logger.addWriter(New TUnitTestLogWriter)

		Local nWriters:Int = logger.logWriters.Count()
		assertEqualsI(4, logger.logWriters.Count())
		
		logger.close()
		assertEqualsI(0, logger.logWriters.Count())
	End Method
End Type
