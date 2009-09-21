'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type FileLogWriterTests Extends TTest

	Field logger:TLogger
	Field logWriter:TFileLogWriter


	Method breakDown() {after}
		logger.close()
		logger = Null
	End Method
	


	' Test that the specified files are identical
	Method filesIdentical:Int(file1:String, file2:String)
		Local testFile:TStream = ReadFile(file1)
		Local compareFile:TStream = ReadFile(file2)
		
		' Unable to open one of the files
		If (Not testFile) Or (Not compareFile) Then Return False
		
		' Files are not the same size
		If compareFile.Size() <> testFile.Size() Then Return False
		
		While Not testFile.Eof()
			Local line1:String = testFile.ReadLine()
			
			' make sure the compare file still has data left as well
			If compareFile.Eof()
				Return False
			Else
				' make sure the lines are identical
				If line1 <> compareFile.ReadLine() Then Return False
			End If
		Wend

		' make sure the compare file doesn't have any data left
		If Not compareFile.Eof() Then Return False
				
		Return True
	End Method
	
	
	
	' Send test messages at all possible severity levels
	Method sendTestMessages()
		For Local i:Int = 0 To 7
			For Local j:Int = 1 To 10
				logger.logMessage(i, "Severity " + i + " level message " + j + "/10")
			Next
		Next
	End Method
	
	
	
	Method setup() {before}
		logger = TLogger.getInstance()
		logger.runningUnitTests = True
		
		logWriter = New TFileLogWriter
		logger.addWriter(logWriter)
	End Method

	
	
	' Check that two known different files test correctly as non-identical
	Method testFilesIdenticalFalse() {test}
		AssertFalse(filesIdentical("data/test-log0.log", "data/test-log1.log"))
	End Method
	
	

	' Check that two know identical test correctly as identical
	Method testFilesIdenticalTrue() {test}
		AssertTrue(filesIdentical("data/test-log7.log", "data/test-log7.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel0() {test}
		Local filename:String = "data/test-log0-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(0)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log0.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel1() {test}
		Local filename:String = "data/test-log1-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(1)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log1.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel2() {test}
		Local filename:String = "data/test-log2-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(2)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log2.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel3() {test}
		Local filename:String = "data/test-log3-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(3)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log3.log"))
	End Method
	
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel4() {test}
		Local filename:String = "data/test-log4-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(4)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log4.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel5() {test}
		Local filename:String = "data/test-log5-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(5)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log5.log"))
	End Method
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel6() {test}
		Local filename:String = "data/test-log6-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(6)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log6.log"))
	End Method
	
	
	
	
	' Test that a written log file contains the expected data
	Method testLogWriterLevel7() {test}
		Local filename:String = "data/test-log7-results.log"
		logWriter.setFilename(filename)
		logWriter.showSeverity(True)
		logWriter.setOverwrite(True)
		logWriter.setLevel(7)
		
		sendTestMessages()
		logger.close()
		
		AssertTrue(filesIdentical(filename, "data/test-log7.log"))
	End Method
	
End Type
