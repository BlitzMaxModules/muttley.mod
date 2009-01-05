Type TIniWriteTests Extends TTest

	Field iniWriteFile:TINIFile
	
	Method SetUp() {before}
		CopyFile(INI_READ_FILE, INI_WRITE_FILE)
		iniWriteFile = TINIFile.Create(INI_WRITE_FILE)
		iniWriteFile.Load()
	End Method
	
	Method TearDown() {after}
		DeleteFile(INI_WRITE_FILE)
	End Method
	
	Method SaveAndReload()
		iniWriteFile.Save()
		iniWriteFile = Null
		iniWriteFile = TINIFile.Create(INI_WRITE_FILE)
		iniWriteFile.Load()
	End Method	
	
	Method TestIniReadFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method
	
	Method TestIniWriteFileExists() {test}
		assertTrue(FileType(INI_WRITE_FILE) = 1, "Test file ~q" + INI_WRITE_FILE + "~q does not exist")
	End Method
	
	Method TestAddSection() {test}
		iniWriteFile.AddSection("Test Section", "This is a test section")
		SaveAndReload()
		assertTrue(iniWriteFile.SectionExists("Test Section"), "Failed to create Section")
	End Method
	
	Method TestAddSectionComment() {test}
		iniWriteFile.AddSection("Test Section", "This is a test section")
		SaveAndReload()
		Local sectionComment:String = iniWriteFile.GetSectionComment("Test Section")
		assertTrue(sectionComment = "This is a test section", "Failed to add Section Comment")
	End Method
End Type