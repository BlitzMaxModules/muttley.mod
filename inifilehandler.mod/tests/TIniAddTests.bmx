'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TIniAddTests Extends TTest

	Field iniFile_:TINIFile
	Field section_:String = "Test Section"
	Field sectionComment_:String = "This is a test section"
	
	Method SetUp() {before}
		CopyFile(INI_READ_FILE, INI_WRITE_FILE)
		iniFile_ = TINIFile.Create(INI_WRITE_FILE)
		iniFile_.Load()
	End Method
	
	Method TearDown() {after}
		DeleteFile(INI_WRITE_FILE)
	End Method
	
	Method SaveAndReload()
		iniFile_.Save()
		iniFile_ = Null
		iniFile_ = TINIFile.Create(INI_WRITE_FILE)
		iniFile_.Load()
	End Method
	
	Method AddTestSection()
		iniFile_.AddSection(section_, sectionComment_)
	End Method

	Method TestIniReadFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method
	
	Method TestiniFile_Exists() {test}
		assertTrue(FileType(INI_WRITE_FILE) = 1, "Test file ~q" + INI_WRITE_FILE + "~q does not exist")
	End Method
		
	Method TestAddSection() {test}
		assertTrue(iniFile_.AddSection(section_, sectionComment_))
		SaveAndReload()
		assertTrue(iniFile_.SectionExists(section_), "Failed to create Section")
		Local sectionComment:String = iniFile_.GetSectionComment(section_)
		assertTrue(sectionComment = sectionComment_, "Failed to add Section Comment")
	End Method	

	Method TestAddDuplicateSection() {test}
		assertFalse(iniFile_.AddSection("Section-01", "This is a duplicate Section"))
		SaveAndReload()
		Local sectionComment:String = iniFile_.GetSectionComment("Section-01")
		assertFalse(sectionComment = "This is a duplicate Section", "Duplicate Section has overwritten original")
	End Method	
		
	Method TestAddParameter() {test}
		assertTrue(iniFile_.AddSection(section_, sectionComment_))
		assertTrue(iniFile_.AddParameter(section_, "Test Parameter", "This is a test parameter"))
		SaveAndReload()
		assertTrue(iniFile_.ParameterExists(section_, "Test Parameter"), "Failed to create Parameter")
		assertTrue(iniFile_.GetParameterComment(section_, "Test Parameter") = "This is a test parameter")
	End Method
	
	Method TestAddDuplicateParameter() {test}
		assertFalse(iniFile_.AddParameter("Section-01", "Section-01-Bool", "Duplicate parameter"))
		SaveAndReload()
		assertFalse(iniFile_.GetParameterComment("Section-01", "Section-01-Bool") = "Duplicate parameter")
	End Method
	
End Type
