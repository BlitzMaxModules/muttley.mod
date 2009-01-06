'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TIniNoCreateMissingTests Extends TTest
	Field iniFile_:TINIFile
	Field section_:String = "Missing Section"
	
	Method SetUp() {before}
		CopyFile(INI_READ_FILE, INI_WRITE_FILE)
		iniFile_ = TINIFile.Create(INI_WRITE_FILE)
		iniFile_.Load()
		iniFile_.CreateMissingEntries(False)
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
	
	Method TestIniReadFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method
	
	Method TestIniFileExists() {test}
		assertTrue(FileType(INI_WRITE_FILE) = 1, "Test file ~q" + INI_WRITE_FILE + "~q does not exist")
	End Method

	Method TestNoCreateMissingBoolValue() {test}
		Local parameter:String = section_ + "-Bool"
		Local expected:Int = True
		iniFile_.GetBoolValue(section_, parameter, "true")
		SaveAndReload()
		assertFalse(iniFile_.GetBoolValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingBoolValues() {test}
		Local parameter:String = section_ + "-Bool"
		Local defaultValues:String[] = ["True", "True", "False", "True", "True", "False", "True", "False", "True"]
		iniFile_.GetBoolValues(section_, parameter, defaultValues)
		SaveAndReload()
		assertFalse(iniFile_.GetBoolValues(section_, parameter).Length > 0)
	End Method	
		
	Method TestNoCreateMissingByteValue() {test}
		Local parameter:String = section_ + "-Byte"
		Local expected:Byte = 239:Byte
		iniFile_.GetByteValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetByteValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingByteValues() {test}
		Local parameter:String = section_ + "-Bytes"
		Local expected:Byte[] = [10:Byte, 247:Byte, 127:Byte, 232:Byte, 52:Byte, 141:Byte]
		iniFile_.GetByteValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetByteValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingDoubleValue() {test}
		Local parameter:String = section_ + "-Double"
		Local expected:Double = 0.79262287690402766:Double
		iniFile_.GetDoubleValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetDoubleValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingDoubleValues() {test}
		Local parameter:String = section_ + "-Doubles"
		Local expected:Double[] = [0.66838540607535757:Double, 0.22676989741525078:Double,  ..
									0.73988173776230703:Double, 0.37740347268439434:Double,  ..
									0.71044799711992468:Double, 0.81224240923952995:Double,  ..
									0.20916371450992632:Double, 0.78518314343206441:Double]
		iniFile_.GetDoubleValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetDoubleValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingFloatValue() {test}
		Local parameter:String = section_ + "-Float"
		Local expected:Float = 0.749703646:Float
		iniFile_.GetFloatValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetFloatValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingFloatValues() {test}
		Local parameter:String = section_ + "-Floats"
		Local expected:Float[] = [0.365954638:Float, 0.999058604:Float]
		iniFile_.GetFloatValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetFloatValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingIntValue() {test}
		Local parameter:String = section_ + "-Int"
		Local expected:Int = -736213825:Int
		iniFile_.GetIntValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetIntValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingIntValues() {test}
		Local parameter:String = section_ + "-Ints"
		Local expected:Int[] = [- 900559619:Int, - 201698820:Int, 406441207:Int, 0:Int]
		iniFile_.GetIntValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetIntValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingLongValue() {test}
		Local parameter:String = section_ + "-Long"
		Local expected:Long = -400966326:Long
		iniFile_.GetLongValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetLongValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingLongValues() {test}
		Local parameter:String = section_ + "-Longs"
		Local expected:Long[] = [- 604666866:Long, - 890225166:Long, 834013734:Long,  ..
									652774232:Long, 1035802483:Long, - 523964866:Long,  ..
									- 459476265:Long, 689839146:Long, 282939222:Long]
		iniFile_.GetLongValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetLongValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingShortValue() {test}
		Local parameter:String = section_ + "-Short"
		Local expected:Short = 30657:Short
		iniFile_.GetShortValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetShortValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingShortValues() {test}
		Local parameter:String = section_ + "-Shorts"
		Local expected:Short[] = [24327:Short, 16161:Short, 3319:Short, 36423:Short,  ..
									56156:Short, 42010:Short, 44939:Short, 8977:Short]
		iniFile_.GetShortValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetShortValues(section_, parameter).Length > 0)
	End Method
	
	Method TestNoCreateMissingStringValue() {test}
		Local parameter:String = section_ + "-String"
		Local expected:String = "This should be the missing string"
		iniFile_.GetStringValue(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetStringValue(section_, parameter) = expected)
	End Method

	Method TestNoCreateMissingStringValues() {test}
		Local parameter:String = section_ + "-Strings"
		Local expected:String[] = ["This should be the missing string 1",  ..
									"This should be the missing string 2",  ..
									"This should be the missing string 3",  ..
									"This should be the missing string 4"]
		iniFile_.GetStringValues(section_, parameter, expected)
		SaveAndReload()
		assertFalse(iniFile_.GetStringValues(section_, parameter).Length > 0)
	End Method
End Type
