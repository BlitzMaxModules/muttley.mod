Type TIniReadTests Extends TTest
	
	Field iniReadFile:TINIFile
	
	Method SetUp() {before}
		iniReadFile = TINIFile.Create(INI_READ_FILE)
		iniReadFile.Load()
	End Method
	
	Method TearDown() {after}
	End Method
	
	Method TestIniReadFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method

End Type


