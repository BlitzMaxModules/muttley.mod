Type TIniGetTests Extends TTest
	
	Field iniFile_:TINIFile
	
	Method SetUp() {before}
		iniFile_ = TINIFile.Create(INI_READ_FILE)
	End Method
	
	Method TearDown() {after}
	End Method
	
	Method TestIniFileExists() {test}
		assertTrue(FileType(INI_READ_FILE) = 1, "Test file ~q" + INI_READ_FILE + "~q does not exist")
	End Method

	Method TestIniFileLoad() {test}
		assertTrue(iniFile_.Load() = True, "Failed to load INI file ~q" + INI_READ_FILE + "~q")
	End Method
	
	Method TestGetBoolValue() {test}
		Local section:String = "Section-01"
		Local parameter:String = "Section-01-Bool"
		Local expected:Int = True
		iniFile_.Load()
		Local actual:Int = iniFile_.GetBoolValue(section, parameter)
		assertEqualsI(expected, actual)
	End Method

	Method TestGetBoolValues() {test}
		Local section:String = "Section-02"
		Local parameter:String = "Section-02-Bools"
		Local expected:Int[] = [True, True, False, True, True, False, True, False, True]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetBoolValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Bool values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetByteValue() {test}
		Local section:String = "Section-03"
		Local parameter:String = "Section-03-Byte"
		Local expected:Byte = 239:Byte
		iniFile_.Load()
		Local actual:Byte = iniFile_.GetByteValue(section, parameter)
		assertEqualsB(expected, actual)
	End Method

	Method TestGetByteValues() {test}
		Local section:String = "Section-04"
		Local parameter:String = "Section-04-Bytes"
		Local expected:Byte[] = [10:Byte, 247:Byte, 127:Byte, 232:Byte, 52:Byte, 141:Byte]
		iniFile_.Load()
		Local actual:Byte[] = iniFile_.GetByteValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Byte values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsB(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDoubleValue() {test}
		Local section:String = "Section-05"
		Local parameter:String = "Section-05-Double"
		Local expected:Double = 0.79262287690402766:Double
		iniFile_.Load()
		Local actual:Double = iniFile_.GetDoubleValue(section, parameter)
		assertEqualsD(expected, actual)
	End Method	

	Method TestGetDoubleValues() {test}
		Local section:String = "Section-06"
		Local parameter:String = "Section-06-Doubles"
		Local expected:Double[] = [0.66838540607535757:Double, 0.22676989741525078:Double,  ..
									0.73988173776230703:Double, 0.37740347268439434:Double,  ..
									0.71044799711992468:Double, 0.81224240923952995:Double,  ..
									0.20916371450992632:Double, 0.78518314343206441:Double]
		iniFile_.Load()
		Local actual:Double[] = iniFile_.GetDoubleValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Double values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetFloatValue() {test}
		Local section:String = "Section-07"
		Local parameter:String = "Section-07-Float"
		Local expected:Float = 0.749703646:Float
		iniFile_.Load()
		Local actual:Float = iniFile_.GetFloatValue(section, parameter)
		assertEqualsD(expected, actual)
	End Method	

	Method TestGetFloatValues() {test}
		Local section:String = "Section-08"
		Local parameter:String = "Section-08-Floats"
		Local expected:Float[] = [0.365954638:Float, 0.999058604:Float]
		iniFile_.Load()
		Local actual:Float[] = iniFile_.GetFloatValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Float values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetIntValue() {test}
		Local section:String = "Section-09"
		Local parameter:String = "Section-09-Int"
		Local expected:Int = -736213825:Int
		iniFile_.Load()
		Local actual:Int = iniFile_.GetIntValue(section, parameter)
		assertEqualsI(expected, actual)
	End Method	

	Method TestGetIntValues() {test}
		Local section:String = "Section-10"
		Local parameter:String = "Section-10-Ints"
		Local expected:Int[] = [- 900559619:Int, - 201698820:Int, 406441207:Int]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetIntValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Int values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetLongValue() {test}
		Local section:String = "Section-11"
		Local parameter:String = "Section-11-Long"
		Local expected:Long = -400966326:Long
		iniFile_.Load()
		Local actual:Long = iniFile_.GetLongValue(section, parameter)
		assertEqualsL(expected, actual)
	End Method	

	Method TestGetLongValues() {test}
		Local section:String = "Section-12"
		Local parameter:String = "Section-12-Longs"
		Local expected:Long[] = [- 604666866:Long, - 890225166:Long, 834013734:Long,  ..
									652774232:Long, 1035802483:Long, - 523964866:Long,  ..
									- 459476265:Long, 689839146:Long, 282939222:Long]
		iniFile_.Load()
		Local actual:Long[] = iniFile_.GetLongValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Long values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsL(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetShortValue() {test}
		Local section:String = "Section-13"
		Local parameter:String = "Section-13-Short"
		Local expected:Short = 30657:Short
		iniFile_.Load()
		Local actual:Short = iniFile_.GetShortValue(section, parameter)
		assertEqualsS(expected, actual)
	End Method	

	Method TestGetShortValues() {test}
		Local section:String = "Section-14"
		Local parameter:String = "Section-14-Shorts"
		Local expected:Short[] = [24327:Short, 16161:Short, 3319:Short, 36423:Short,  ..
									56156:Short, 42010:Short, 44939:Short, 8977:Short]
		iniFile_.Load()
		Local actual:Short[] = iniFile_.GetShortValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " Short values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsS(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetStringValue() {test}
		Local section:String = "Section-15"
		Local parameter:String = "Section-15-String"
		Local expected:String = "TSL AQGJAHNM CZAAMNH RGPHYLSI GOOMY"
		iniFile_.Load()
		Local actual:String = iniFile_.GetStringValue(section, parameter)
		assertEquals(expected, actual)
	End Method	

	Method TestGetStringValues() {test}
		Local section:String = "Section-16"
		Local parameter:String = "Section-16-Strings"
		Local expected:String[] = ["RXGT O YBTZIL WMSYRSNV NQOHS", "DAEM L WMKOAHN KZST H",  ..
									"HIS DSIUBDUN B GBRFB E", "GOH GCB DEX IANABGBH XE",  ..
									"K RT TCATMC BEXQC XA"]
		iniFile_.Load()
		Local actual:String[] = iniFile_.GetStringValues(section, parameter)
		assertTrue(expected.length = actual.length, actual.length + " String values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEquals(expected[i], actual[i])
			Next
		End If
	End Method	

	Method TestGetDefaultBoolValue() {test}
		Local section:String = "Missing-Section-01"
		Local parameter:String = "Missing-Section-01-Bool"
		Local expected:Int = True
		iniFile_.Load()
		Local actual:Int = iniFile_.GetBoolValue(section, parameter, "True")
		assertEqualsI(expected, actual)
	End Method

	Method TestGetDefaultBoolValues() {test}
		Local section:String = "Missing-Section-02"
		Local parameter:String = "Missing-Section-02-Bools"
		Local expected:Int[] = [True, True, False, True, True, False, True, False, True]
		Local expectedString:String[] = ["True", "True", "False", "True", "True", "False", "True", "False", "True"]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetBoolValues(section, parameter, expectedString)
		assertTrue(expected.length = actual.length, actual.length + " Bool values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultByteValue() {test}
		Local section:String = "Missing-Section-03"
		Local parameter:String = "Missing-Section-03-Byte"
		Local expected:Byte = 239:Byte
		iniFile_.Load()
		Local actual:Byte = iniFile_.GetByteValue(section, parameter, expected)
		assertEqualsB(expected, actual)
	End Method

	Method TestGetDefaultByteValues() {test}
		Local section:String = "Missing-Section-04"
		Local parameter:String = "Missing-Section-04-Bytes"
		Local expected:Byte[] = [10:Byte, 247:Byte, 127:Byte, 232:Byte, 52:Byte, 141:Byte]
		iniFile_.Load()
		Local actual:Byte[] = iniFile_.GetByteValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Byte values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsB(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultDoubleValue() {test}
		Local section:String = "Missing-Section-05"
		Local parameter:String = "Missing-Section-05-Double"
		Local expected:Double = 0.79262287690402766:Double
		iniFile_.Load()
		Local actual:Double = iniFile_.GetDoubleValue(section, parameter, expected)
		assertEqualsD(expected, actual)
	End Method	

	Method TestGetDefaultDoubleValues() {test}
		Local section:String = "Missing-Section-06"
		Local parameter:String = "Missing-Section-06-Doubles"
		Local expected:Double[] = [0.66838540607535757:Double, 0.22676989741525078:Double,  ..
									0.73988173776230703:Double, 0.37740347268439434:Double,  ..
									0.71044799711992468:Double, 0.81224240923952995:Double,  ..
									0.20916371450992632:Double, 0.78518314343206441:Double]
		iniFile_.Load()
		Local actual:Double[] = iniFile_.GetDoubleValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Double values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultFloatValue() {test}
		Local section:String = "Missing-Section-07"
		Local parameter:String = "Missing-Section-07-Float"
		Local expected:Float = 0.749703646:Float
		iniFile_.Load()
		Local actual:Float = iniFile_.GetFloatValue(section, parameter, expected)
		assertEqualsD(expected, actual)
	End Method	

	Method TestGetDefaultFloatValues() {test}
		Local section:String = "Missing-Section-08"
		Local parameter:String = "Missing-Section-08-Floats"
		Local expected:Float[] = [0.365954638:Float, 0.999058604:Float]
		iniFile_.Load()
		Local actual:Float[] = iniFile_.GetFloatValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Float values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultIntValue() {test}
		Local section:String = "Missing-Section-09"
		Local parameter:String = "Missing-Section-09-Int"
		Local expected:Int = -736213825:Int
		iniFile_.Load()
		Local actual:Int = iniFile_.GetIntValue(section, parameter, expected)
		assertEqualsI(expected, actual)
	End Method	

	Method TestGetDefaultIntValues() {test}
		Local section:String = "Missing-Section-10"
		Local parameter:String = "Missing-Section-10-Ints"
		Local expected:Int[] = [- 900559619:Int, - 201698820:Int, 406441207:Int]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetIntValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Int values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultLongValue() {test}
		Local section:String = "Missing-Section-11"
		Local parameter:String = "Missing-Section-11-Long"
		Local expected:Long = -400966326:Long
		iniFile_.Load()
		Local actual:Long = iniFile_.GetLongValue(section, parameter, expected)
		assertEqualsL(expected, actual)
	End Method	

	Method TestGetDefaultLongValues() {test}
		Local section:String = "Missing-Section-12"
		Local parameter:String = "Missing-Section-12-Longs"
		Local expected:Long[] = [- 604666866:Long, - 890225166:Long, 834013734:Long,  ..
									652774232:Long, 1035802483:Long, - 523964866:Long,  ..
									- 459476265:Long, 689839146:Long, 282939222:Long]
		iniFile_.Load()
		Local actual:Long[] = iniFile_.GetLongValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Long values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsL(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetDefaultShortValue() {test}
		Local section:String = "Missing-Section-13"
		Local parameter:String = "Missing-Section-13-Short"
		Local expected:Short = 30657:Short
		iniFile_.Load()
		Local actual:Short = iniFile_.GetShortValue(section, parameter, expected)
		assertEqualsS(expected, actual)
	End Method	

	Method TestGetDefaultShortValues() {test}
		Local section:String = "Missing-Section-14"
		Local parameter:String = "Missing-Section-14-Shorts"
		Local expected:Short[] = [24327:Short, 16161:Short, 3319:Short, 36423:Short,  ..
									56156:Short, 42010:Short, 44939:Short, 8977:Short]
		iniFile_.Load()
		Local actual:Short[] = iniFile_.GetShortValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " Short values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsS(expected[i], actual[i])
			Next
		End If
	End Method

	Method TestGetDefaultStringValue() {test}
		Local section:String = "Missing-Section-13"
		Local parameter:String = "Missing-Section-13-String"
		Local expected:String = "This should be the missing string"
		iniFile_.Load()
		Local actual:String = iniFile_.GetStringValue(section, parameter, expected)
		assertEquals(expected, actual)
	End Method	

	Method TestGetDefaultStringValues() {test}
		Local section:String = "Missing-Section-14"
		Local parameter:String = "Missing-Section-14-Strings"
		Local expected:String[] = ["This should be the missing string 1",  ..
									"This should be the missing string 2",  ..
									"This should be the missing string 3",  ..
									"This should be the missing string 4"]
		iniFile_.Load()
		Local actual:String[] = iniFile_.GetStringValues(section, parameter, expected)
		assertTrue(expected.length = actual.length, actual.length + " String values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEquals(expected[i], actual[i])
			Next
		End If
	End Method		
	
	Method TestGetNoDefaultBoolValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Bool"
		Local expected:Int = True
		iniFile_.Load()
		Local actual:Int = iniFile_.GetBoolValue(section, parameter, "true")
		assertEqualsI(expected, actual)
	End Method

	Method TestGetNoDefaultBoolValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Bools"
		Local expected:Int[] = [True, True, False, True, True, False, True, False, True]
		Local defaultValues:String[] = ["True", "True", "False", "True", "True", "False", "True", "False", "True"]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetBoolValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Bool values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultByteValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Byte"
		Local expected:Byte = 0:Byte
		iniFile_.Load()
		Local actual:Byte = iniFile_.GetByteValue(section, parameter, 239:Byte)
		assertEqualsB(expected, actual)
	End Method

	Method TestGetNoDefaultByteValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Bytes"
		Local defaultValues:Byte[] = [10:Byte, 247:Byte, 127:Byte, 232:Byte, 52:Byte, 141:Byte]
		Local expected:Byte[] = [0:Byte, 0:Byte]
		iniFile_.Load()
		Local actual:Byte[] = iniFile_.GetByteValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Byte values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsB(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultDoubleValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Double"
		Local expected:Double = 0.0:Double
		iniFile_.Load()
		Local actual:Double = iniFile_.GetDoubleValue(section, parameter, 0.79262287690402766:Double)
		assertEqualsD(expected, actual)
	End Method

	Method TestGetNoDefaultDoubleValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Doubles"
		Local defaultValues:Double[] = [0.66838540607535757:Double, 0.22676989741525078:Double,  ..
									0.73988173776230703:Double, 0.37740347268439434:Double,  ..
									0.71044799711992468:Double, 0.81224240923952995:Double,  ..
									0.20916371450992632:Double, 0.78518314343206441:Double]
		Local expected:Double[] = [0.0:Double, 0.0:Double, 0.0:Double, 0.0:Double, 0.0:Double, 0.0:Double, 0.0:Double]
		iniFile_.Load()
		Local actual:Double[] = iniFile_.GetDoubleValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Double values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultFloatValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Float"
		Local expected:Float = 0.0:Float
		iniFile_.Load()
		Local actual:Float = iniFile_.GetFloatValue(section, parameter, 0.749703646:Float)
		assertEqualsD(expected, actual)
	End Method	

	Method TestGetNoDefaultFloatValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Floats"
		Local defaultValues:Float[] = [0.365954638:Float, 0.999058604:Float]
		Local expected:Float[] = [0.0:Float, 0.0:Float, 0.0:Float, 0.0:Float, 0.0:Float, 0.0:Float]
		iniFile_.Load()
		Local actual:Float[] = iniFile_.GetFloatValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Float values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsD(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultIntValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Int"
		Local expected:Int = 0:Int
		iniFile_.Load()
		Local actual:Int = iniFile_.GetIntValue(section, parameter, - 736213825:Int)
		assertEqualsI(expected, actual)
	End Method	

	Method TestGetNoDefaultIntValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Ints"
		Local defaultValues:Int[] = [- 900559619:Int, - 201698820:Int, 406441207:Int]
		Local expected:Int[] = [0:Int, 0:Int]
		iniFile_.Load()
		Local actual:Int[] = iniFile_.GetIntValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Int values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsI(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultLongValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Long"
		Local expected:Long = 0:Long
		iniFile_.Load()
		Local actual:Long = iniFile_.GetLongValue(section, parameter, - 400966326:Long)
		assertEqualsL(expected, actual)
	End Method	

	Method TestGetNoDefaultLongValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Longs"
		Local defaultValues:Long[] = [- 604666866:Long, - 890225166:Long, 834013734:Long,  ..
									652774232:Long, 1035802483:Long, - 523964866:Long,  ..
									- 459476265:Long, 689839146:Long, 282939222:Long]
		Local expected:Long[] = [0:Long, 0:Long, 0:Long, 0:Long, 0:Long, 0:Long, 0:Long]
		iniFile_.Load()
		Local actual:Long[] = iniFile_.GetLongValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Long values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsL(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultShortValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Short"
		Local expected:Short = 0:Short
		iniFile_.Load()
		Local actual:Short = iniFile_.GetShortValue(section, parameter, 30657:Short)
		assertEqualsS(expected, actual)
	End Method	

	Method TestGetNoDefaultShortValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Shorts"
		Local defaultValues:Short[] = [24327:Short, 16161:Short, 3319:Short, 36423:Short,  ..
									56156:Short, 42010:Short, 44939:Short, 8977:Short]
		Local expected:Short[] = [0:Short, 0:Short, 0:Short]
		iniFile_.Load()
		Local actual:Short[] = iniFile_.GetShortValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " Short values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEqualsS(expected[i], actual[i])
			Next
		End If
	End Method
	
	Method TestGetNoDefaultStringValue() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-String"
		Local expected:String = ""
		iniFile_.Load()
		Local actual:String = iniFile_.GetStringValue(section, parameter, "No Default Please")
		assertEquals(expected, actual)
	End Method	

	Method TestGetNoDefaultStringValues() {test}
		Local section:String = "Section-17"
		Local parameter:String = "Section-17-Strings"
		Local defaultValues:String[] = ["No Default Please 1", "No Default Please 2",  ..
										"No Default Please 3"]
		Local expected:String[] = ["", "", "", ""]
		iniFile_.Load()
		Local actual:String[] = iniFile_.GetStringValues(section, parameter, defaultValues)
		assertTrue(expected.length = actual.length, actual.length + " String values returned, should be " + expected.length)
		If expected.length = actual.length
			For Local i:Int = 0 To expected.length - 1
				assertEquals(expected[i], actual[i])
			Next
		End If
	End Method	
End Type


