'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TIniAddTests Extends TTest

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
		
	Method TestAddSection() {test}
		iniFile.AddSection("Test Section", "This is a test section")
		SaveAndReload()
		assertTrue(iniFile.SectionExists("Test Section"), "Failed to create Section")
		Local sectionComment:String = iniFile.GetSectionComment("Test Section")
		assertTrue(sectionComment = "This is a test section", "Failed to add Section Comment")
	End Method	

	Method TestAddDuplicateSection() {test}
		assertFalse(iniFile.AddSection("Section-01", "This is a duplicate Section"))
		SaveAndReload()
		Local sectionComment:String = iniFile.GetSectionComment("Section-01")
		assertFalse(sectionComment = "This is a duplicate Section", "Duplicate Section has overwritten original")
	End Method	
		
	Method TestAddParameter() {test}
		iniFile.AddSection("Test Section", "This is a test section")
		iniFile.AddParameter("Test Section", "Test Parameter")
		SaveAndReload()
		assertTrue(iniFile.ParameterExists("Test Section", "Test Parameter"), "Failed to create Parameter")
	End Method
	
	Method TestAddDuplicateParameter() {test}
		assertFalse(iniFile.AddParameter("Section-01", "Section-01-Bool"))
	End Method	
End Type
