'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TIniCreateMissingTests Extends TTest
	Field iniFile_:TINIFile
	Field section_:String = "Missing Section"
	
	Method SetUp() {before}
		CopyFile(INI_READ_FILE, INI_WRITE_FILE)
		iniFile_ = TINIFile.Create(INI_WRITE_FILE)
		iniFile_.Load()
		iniFile_.CreateMissingEntries(True)
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

	Method TestCreateMissingBoolValue() {test}
		Local parameter:String = section_ + "-Bool"
		Local expected:Int = True
		iniFile_.GetBoolValue(section_, parameter, "true")
		SaveAndReload()
		Local actual:Int = iniFile_.GetBoolValue(section_, parameter)
		assertEqualsI(expected, actual)
	End Method

	Method TestCreateMissingBoolValues() {test}
		Local parameter:String = section_ + "-Bool"
		Local defaultValues:String[] = ["True", "True", "False", "True", "True", "False", "True", "False", "True"]
		Local expected:Int[] = [True, True, False, True, True, False, True, False, True]
		iniFile_.GetBoolValues(section_, parameter, defaultValues)
		SaveAndReload()
		Local actual:Int[] = iniFile_.GetBoolValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Bool values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method	
		
	Method TestCreateMissingByteValue() {test}
		Local parameter:String = section_ + "-Byte"
		Local expected:Byte = 239:Byte
		iniFile_.GetByteValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Byte = iniFile_.GetByteValue(section_, parameter)
		assertEqualsB(expected, actual)
	End Method

	Method TestCreateMissingByteValues() {test}
		Local parameter:String = section_ + "-Bytes"
		Local expected:Byte[] = [10:Byte, 247:Byte, 127:Byte, 232:Byte, 52:Byte, 141:Byte]
		iniFile_.GetByteValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Byte[] = iniFile_.GetByteValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Byte values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsB(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestCreateMissingDoubleValue() {test}
		Local parameter:String = section_ + "-Double"
		Local expected:Double = 0.79262287690402766:Double
		iniFile_.GetDoubleValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Double = iniFile_.GetDoubleValue(section_, parameter)
		assertEqualsD(expected, actual)
	End Method	

	Method TestCreateMissingDoubleValues() {test}
		Local parameter:String = section_ + "-Doubles"
		Local expected:Double[] = [0.66838540607535757:Double, 0.22676989741525078:Double,  ..
									0.73988173776230703:Double, 0.37740347268439434:Double,  ..
									0.71044799711992468:Double, 0.81224240923952995:Double,  ..
									0.20916371450992632:Double, 0.78518314343206441:Double]
		iniFile_.GetDoubleValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Double[] = iniFile_.GetDoubleValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Double values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestCreateMissingFloatValue() {test}
		Local parameter:String = section_ + "-Float"
		Local expected:Float = 0.749703646:Float
		iniFile_.GetFloatValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Float = iniFile_.GetFloatValue(section_, parameter)
		assertEqualsD(expected, actual)
	End Method	

	Method TestCreateMissingFloatValues() {test}
		Local parameter:String = section_ + "-Floats"
		Local expected:Float[] = [0.365954638:Float, 0.999058604:Float]
		iniFile_.GetFloatValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Float[] = iniFile_.GetFloatValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Float values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestCreateMissingIntValue() {test}
		Local parameter:String = section_ + "-Int"
		Local expected:Int = -736213825:Int
		iniFile_.GetIntValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Int = iniFile_.GetIntValue(section_, parameter)
		assertEqualsI(expected, actual)
	End Method	

	Method TestCreateMissingIntValues() {test}
		Local parameter:String = section_ + "-Ints"
		Local expected:Int[] = [- 900559619:Int, - 201698820:Int, 406441207:Int, 0:Int]
		iniFile_.GetIntValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Int[] = iniFile_.GetIntValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Int values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestCreateMissingLongValue() {test}
		Local parameter:String = section_ + "-Long"
		Local expected:Long = -400966326:Long
		iniFile_.GetLongValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Long = iniFile_.GetLongValue(section_, parameter)
		assertEqualsL(expected, actual)
	End Method	

	Method TestCreateMissingLongValues() {test}
		Local parameter:String = section_ + "-Longs"
		Local expected:Long[] = [- 604666866:Long, - 890225166:Long, 834013734:Long,  ..
									652774232:Long, 1035802483:Long, - 523964866:Long,  ..
									- 459476265:Long, 689839146:Long, 282939222:Long]
		iniFile_.GetLongValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Long[] = iniFile_.GetLongValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Long values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsL(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestCreateMissingShortValue() {test}
		Local parameter:String = section_ + "-Short"
		Local expected:Short = 30657:Short
		iniFile_.GetShortValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:Short = iniFile_.GetShortValue(section_, parameter)
		assertEqualsS(expected, actual)
	End Method	

	Method TestCreateMissingShortValues() {test}
		Local parameter:String = section_ + "-Shorts"
		Local expected:Short[] = [24327:Short, 16161:Short, 3319:Short, 36423:Short,  ..
									56156:Short, 42010:Short, 44939:Short, 8977:Short]
		iniFile_.GetShortValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:Short[] = iniFile_.GetShortValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Short values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsS(expected[i], actual[i])
			Next
		End If
	End Method

	Method TestCreateMissingStringValue() {test}
		Local parameter:String = section_ + "-String"
		Local expected:String = "This should be the missing string"
		iniFile_.GetStringValue(section_, parameter, expected)
		SaveAndReload()
		Local actual:String = iniFile_.GetStringValue(section_, parameter)
		assertEquals(expected, actual)
	End Method	

	Method TestCreateMissingStringValues() {test}
		Local parameter:String = section_ + "-Strings"
		Local expected:String[] = ["This should be the missing string 1",  ..
									"This should be the missing string 2",  ..
									"This should be the missing string 3",  ..
									"This should be the missing string 4"]
		iniFile_.GetStringValues(section_, parameter, expected)
		SaveAndReload()
		Local actual:String[] = iniFile_.GetStringValues(section_, parameter)
		assertTrue(expected.length = actual.length, actual.length + " String values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEquals(expected[i], actual[i])
			Next
		End If
	End Method
End Type
