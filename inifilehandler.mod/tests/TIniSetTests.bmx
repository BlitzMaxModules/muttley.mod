Type TIniSetTests Extends TTest

	Field iniFile:TINIFile
	
	Method SetUp() {before}
		CopyFile(INI_READ_FILE, INI_WRITE_FILE)
		iniFile = TINIFile.Create(INI_WRITE_FILE)
		iniFile.Load()
	End Method
	
	Method TearDown() {after}
		DeleteFile(INI_WRITE_FILE)
	End Method
	
	Method SaveAndReload()
		iniFile.Save()
		iniFile = Null
		iniFile = TINIFile.Create(INI_WRITE_FILE)
		iniFile.Load()
	End Method	
	
	Method TestIniReadFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method
	
	Method TestIniFileExists() {test}
		assertTrue(FileType(INI_WRITE_FILE) = 1, "Test file ~q" + INI_WRITE_FILE + "~q does not exist")
	End Method
	
End Type