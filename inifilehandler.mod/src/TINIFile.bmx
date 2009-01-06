Rem
	License Details
	---------------
	muttley.INIFileHandler - BlitzMax INI File Handler Module
	Copyright (C) 2007 Paul Maskelyne

 	This software is licensed under the terms of the Artistic
 	License version 2.0.

	For full license details, please read the file 'artistic-2_0.txt' 
	included with this distribution, or see
	http://www.perlfoundation.org/legal/licenses/artistic-2_0.html
	
EndRem

rem
ModuleInfo "Name: muttley.INIFileHandler"
ModuleInfo "Version: 1.1.0"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (C) 2007 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"

ModuleInfo "History: 1.1.0"
ModuleInfo "History: Code overhauled to correct issues with incorrectly returning default values.  Also added Unit Tests using bah.maxunit"
ModuleInfo "History: 1.0.7"
ModuleInfo "History: Fixed problem with docmods not generating documentation correctly"
ModuleInfo "History: 1.0.6"
ModuleInfo "History: Re-released under the Artistic License 2.0"
ModuleInfo "History: 1.0.5"
ModuleInfo "History: Missing sections and parameters are now created correcty when trying to set them and CreateMissingEntries() is set to True"
ModuleInfo "History: 1.0.4"
ModuleInfo "History: Added support for string based Booleans as BlitzMax doesn't have a proper bool datatype"
ModuleInfo "History: 1.0.3"
ModuleInfo "History: Missing parameters that are requested can now be automatically added to ini file by using CreateMissingEntries()"
ModuleInfo "History: 1.0.2"
ModuleInfo "History: Get* methods can now take default values which are returned if the requested parameter doesn't exist"
ModuleInfo "History: 1.0.1"
ModuleInfo "History: No longer writing Global and Section comments to INI file when comment is blank"
ModuleInfo "History: 1.0.0"
ModuleInfo "History: Initial Release"
endrem


Rem
bbdoc: INI File Type
EndRem
Type TINIFile
	
	Field filename_:String
	Field comment_:String
	Field LSections_:TList = CreateList()
	Field createMissingEntries_:Int = False

	Rem
	bbdoc: Create a new INI File
	Returns: An INI File object
	About:
	Creates a new INI File object.
	If no filename is specified the default, config.ini, is used.
	EndRem
	Function Create:TINIFile(filename:String = "config.ini")
		Local this:TINIFile = New TINIFile
		this.filename_ = filename
		Return this
	EndFunction

	Rem
	bbdoc: Adds a new Parameter to a specified Section in the #TINIFILE Object
	Returns: True if the parameter as been added
	EndRem	
	Method AddParameter:Int(sectionName:String, paramaterName:String, comment:String = Null)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.AddParameter(paramaterName, comment)
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Add a new section to the #TINIFile Object. Section names must be unique.
	Returns: True if the section has been added
	EndRem
	Method AddSection:Int(name:String, comment:String = "")
		If SectionExists(name)
			Return False
		Else
			Local newSection:TINISection = TINISection.Create(name, comment)
			If newSection
				ListAddLast(LSections_, newSection)
				Return True
			Else
				Return False
			EndIf
		EndIf
	EndMethod

	Rem
	bbdoc: Tells the INI file whether to create missing parameters/settings when requested or not, this is off by default
	Returns:
	EndRem
	Method CreateMissingEntries(bool:Int = True)
		createMissingEntries_ = bool
	End Method

	Rem
	bbdoc: Deletes a Parameter
	Returns: True if the Parameter has been deleted
	EndRem		
	Method DeleteParameter:Int(sectionName:String, parameterName:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.DeleteParameter(parameterName)
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Delete a Section (and all contained parameters) if it exists in the #TINIFile Object
	Returns: True if the section has been deleted
	EndRem	
	Method DeleteSection:Int(name:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = name
				ListRemove(LSections_, section)
				section = Null
				Return True
			EndIf
		Next
		Return False
	EndMethod

	
	Rem
	bbdoc: Get a Boolean value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: int
	EndRem
	Method GetBoolValue:Int(sectionName:String, parameterName:String, defaultValue:String = Null)
		Local boolValue:Int = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			Select value.GetValue().ToLower()
				Case "true"
					boolValue = True
				Case "false"
					boolValue = False
					Default ' Return the default if there are unknown (ie. garbage) strings in the value field
					If defaultValue.ToLower() = "true" Then boolValue = True
					If defaultValue.ToLower() = "false" Then boolValue = False
			EndSelect
		Else
			If createMissingEntries_ And defaultValue <> Null
				If defaultValue.tolower() = "false" Or defaultValue.tolower() = "true"
					AddSection(sectionName)
					AddParameter(sectionName, parameterName)
					SetStringValue(sectionName, parameterName, defaultValue.ToLower())
				EndIf
			EndIf
			If defaultValue.ToLower() = "true" Then boolValue = True
			If defaultValue.ToLower() = "false" Then boolValue = False
		EndIf
		Return boolValue
	EndMethod

	
	Rem
	bbdoc: Get an Int array of all Boolean values from a parameter
	Returns: Byte[]
	EndRem
	Method GetBoolValues:Int[] (sectionName:String, parameterName:String, defaultValues:String[] = Null)
		Local boolValues:Int[] = Null
		Local useDefaultValues:Int = False
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			Local nValidValues:Int = 0
			For Local i:Int = 0 To values.length - 1
				Select values[i].GetValue().toLower()
					Case "true"
						nValidValues:+1
						boolValues = boolValues[..nValidValues]
						boolValues[nValidValues - 1] = True
					Case "false"
						nValidValues:+1
						boolValues = boolValues[..nValidValues]
						boolValues[nValidValues - 1] = False
						Default
						useDefaultValues = True	' We found garbage so will abort and use defaults if provided
				EndSelect
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetBoolValues(sectionName, parameterName, defaultValues)
			EndIf
			useDefaultValues = True
		EndIf
		If useDefaultValues
			boolValues = New Int[defaultValues.length]
			For Local i:Int = 0 To defaultValues.length - 1
				Select defaultValues[i].toLower()
					Case "true"
						boolValues[i] = True
					Case "false"
						boolValues[i] = False
						Default
						RuntimeError "Garbage default values in default Boolean values."
				EndSelect
			Next
		End If
		Return boolValues
	EndMethod
		
	
	Rem
	bbdoc: Get a Byte value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Byte
	EndRem
	Method GetByteValue:Byte(sectionName:String, parameterName:String, defaultValue:Byte = Null)
		Local byteValue:Byte = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			byteValue = Byte(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetByteValue(sectionName, parameterName, defaultValue)
			EndIf
			byteValue = defaultValue
		EndIf
		Return byteValue
	EndMethod
	
	Rem
	bbdoc: Get a Byte array of all values from a parameter
	Returns: Byte[]
	EndRem
	Method GetByteValues:Byte[] (sectionName:String, parameterName:String, defaultValues:Byte[] = Null)
		Local byteValues:Byte[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			byteValues = New Byte[values.length]
			For Local i:Int = 0 To values.length - 1
				byteValues[i] = Byte(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetByteValues(sectionName, parameterName, defaultValues)
			EndIf
			byteValues = defaultValues
		EndIf
		Return byteValues
	EndMethod

	Rem
	bbdoc: Get the INI file comment line
	Returns: String containing the comment
	About:
	EndRem
	Method GetComment:String()
		Return comment_
	EndMethod

	Rem
	bbdoc: Get a Double value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Double
	EndRem
	Method GetDoubleValue:Double(sectionName:String, parameterName:String, defaultValue:Double = Null)
		Local doubleValue:Double = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			doubleValue = Double(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetDoubleValue(sectionName, parameterName, defaultValue)
			EndIf
			doubleValue = defaultValue
		EndIf
		Return doubleValue
	EndMethod

	Rem
	bbdoc: Get a Double array of all values from a parameter
	Returns: Double[]
	EndRem	
	Method GetDoubleValues:Double[] (sectionName:String, parameterName:String, defaultValues:Double[] = Null)
		Local doubleValues:Double[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			doubleValues = New Double[values.length]
			For Local i:Int = 0 To values.length - 1
				doubleValues[i] = Double(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetDoubleValues(sectionName, parameterName, defaultValues)
			EndIf
			doubleValues = defaultValues
		EndIf
		Return doubleValues
	EndMethod
		
	Rem
	bbdoc: Returns the filename of the INI File Object
	Returns: String containing the current filename
	EndRem
	Method GetFilename:String()
		Return filename_
	End Method

	Rem
	bbdoc: Get a Float value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Float
	EndRem
	Method GetFloatValue:Float(sectionName:String, parameterName:String, defaultValue:Float = Null)
		Local floatValue:Float = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			floatValue = Float(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetFloatValue(sectionName, parameterName, defaultValue)
			EndIf
			floatValue = defaultValue
		EndIf
		Return floatValue
	EndMethod

	Rem
	bbdoc: Get a Float array of all values from a parameter
	Returns: Float[]
	EndRem		
	Method GetFloatValues:Float[] (sectionName:String, parameterName:String, defaultValues:Float[] = Null)
		Local floatValues:Float[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			floatValues = New Float[values.length]
			For Local i:Int = 0 To values.length - 1
				floatValues[i] = Float(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetFloatValues(sectionName, parameterName, defaultValues)
			EndIf
			floatValues = defaultValues
		EndIf
		Return floatValues
	EndMethod

	Rem
	bbdoc: Get an Int value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Int
	EndRem
	Method GetIntValue:Int(sectionName:String, parameterName:String, defaultValue:Int = Null)
		Local intValue:Int = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			intValue = Int(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				addsection(sectionName)
				addParameter(sectionName, parameterName)
				SetIntValue(sectionName, parameterName, defaultValue)
			EndIf
			intValue = defaultValue
		End If
		Return intValue
	EndMethod

	Rem
	bbdoc: Get an Int array of all values from a parameter
	Returns: Int[]
	EndRem		
	Method GetIntValues:Int[] (sectionName:String, parameterName:String, defaultValues:Int[] = Null)
		Local intValues:Int[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			intValues = New Int[values.length]
			For Local i:Int = 0 To values.length - 1
				intValues[i] = Int(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				addsection(sectionName)
				addParameter(sectionName, parameterName)
				SetIntValues(sectionName, parameterName, defaultValues)
			EndIf
			intValues = defaultValues
		EndIf
		Return intValues
	EndMethod

	Rem
	bbdoc: Get a Long value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Long
	EndRem
	Method GetLongValue:Long(sectionName:String, parameterName:String, defaultValue:Long = Null)
		Local longValue:Long = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			longValue = Long(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetLongValue(sectionName, parameterName, defaultValue)
			EndIf
			longValue = defaultValue
		EndIf
		Return longValue
	EndMethod

	Rem
	bbdoc: Get a Long array of all values from a parameter
	Returns: Long[]
	EndRem		
	Method GetLongValues:Long[] (sectionName:String, parameterName:String, defaultValues:Long[] = Null)
		Local longValues:Long[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			longValues = New Long[values.length]
			For Local i:Int = 0 To values.length - 1
				longValues[i] = Long(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetLongValues(sectionName, parameterName, defaultValues)
			EndIf
			longValues = defaultValues
		EndIf
		Return longValues
	EndMethod
	
	Rem
	bbdoc: Gets the comment field for a Parameter
	Returns: A string containing the comment
	EndRem		
	Method GetParameterComment:String(sectionName:String, parameterName:String)
		Local parameterComment:String = Null
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				parameterComment = section.GetParameterComment(parameterName)
			EndIf
		Next
		Return parameterComment
	EndMethod

	Rem
	bbdoc: Get a list of all Parameters in a Section of the #TINIFile Object
	Returns: An array of #String
	EndRem		
	Method GetSectionParameters:String[] (name:String)
		Local sectionParameters:String[] = Null
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = name
				sectionParameters = section.GetParameterNames()
			EndIf
		Next
		Return sectionParameters
	EndMethod

	Rem
	bbdoc: Get the comment field associated with a Section in the #TINIFile Object
	Returns: #String
	EndRem	
	Method GetSectionComment:String(name:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = name
				Return section.GetComment()
			EndIf
		Next
		Return Null
	EndMethod

	Rem
	bbdoc: Get the names of all sections in the #TINIFile Object
	Returns: An Array of Strings
	About:
	Returns an Array containing the names of all sections in the #TINIFile Object
	EndRem
	Method GetSections:String[] ()
		Local nSections:Int = LSections_.Count()
		Local sections:String[nSections]
		Local i:Int = 0
		For Local section:TINISection = EachIn LSections_
			sections[i] = section.GetName()
			i:+1
		Next
		Return sections
	EndMethod

	Rem
	bbdoc: Get a Short value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Short
	EndRem
	Method GetShortValue:Short(sectionName:String, parameterName:String, defaultValue:Short = Null)
		Local shortValue:Short = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			shortValue = Short(value.GetValue())
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetShortValue(sectionName, parameterName, defaultValue)
			EndIf
			shortValue = defaultValue
		EndIf
		Return shortValue
	EndMethod

	Rem
	bbdoc: Get a Short array of all values from a parameter
	Returns: Short[]
	EndRem		
	Method GetShortValues:Short[] (sectionName:String, parameterName:String, defaultValues:Short[] = Null)
		Local shortValues:Short[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			shortValues = New Short[values.length]
			For Local i:Int = 0 To values.length - 1
				shortValues[i] = Short(values[i].GetValue())
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetShortValues(sectionName, parameterName, defaultValues)
			EndIf
			shortValues = defaultValues
		EndIf
		Return shortValues
	EndMethod

	Rem
	bbdoc: Gets the value (or first value if there is more than one) belonging to a parameter
	Returns: String containing the value
	EndRem		
	Method GetStringValue:String(sectionName:String, parameterName:String, defaultValue:String = Null)
		Local stringValue:String = Null
		Local value:TINIValue = GetValue(sectionName, parameterName)
		If value <> Null
			stringValue = value.GetValue()
		Else
			If createMissingEntries_ And defaultValue <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetStringValue(sectionName, parameterName, defaultValue)
			EndIf
			stringValue = defaultValue
		End If
		Return stringValue
	EndMethod

	Rem
	bbdoc: Gets all the values belonging to a parameter
	Returns: String Array containing the values
	EndRem	
	Method GetStringValues:String[] (sectionName:String, parameterName:String, defaultValues:String[] = Null)
		Local stringValues:String[] = Null
		Local values:TINIValue[] = GetValues(sectionName, parameterName)
		If values <> Null
			stringValues = New String[values.Length]
			For Local i:Int = 0 To values.Length - 1
				stringValues[i] = values[i].GetValue()
			Next
		Else
			If createMissingEntries_ And defaultValues <> Null
				AddSection(sectionName)
				AddParameter(sectionName, parameterName)
				SetStringValues(sectionName, parameterName, defaultValues)
			EndIf
			stringValues = defaultValues
		EndIf
		Return stringValues
	EndMethod

	Method GetValue:TINIValue(sectionName:String, parameterName:String)
		Local value:TINIValue
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				value = section.GetParameterValue(parameterName)
			EndIf
		Next
		Return value
	End Method

	Method GetValues:TINIValue[] (sectionName:String, parameterName:String)
		Local values:TINIValue[]
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				values = section.GetParameterValues(parameterName)
			EndIf
		Next
		Return values
	EndMethod
			
	Rem
	bbdoc: Loads data from a file into the #TINIFile Object
	Returns:
	About:
	Saves the INI file 
	EndRem	
	Method Load:Int()
		Local inSection:Int = False
		Local fileHandle:TStream = ReadFile(filename_)
		If Not fileHandle Then Return False
		Local blankLine:Int = False
		Local newSectionName:String
		
		While Not Eof(fileHandle)
			Local line:String = Trim(ReadLine(fileHandle))
			If line = "" Then blankLine = True Else blankLine = False

			If Not Blankline	'ignore blank lines in config file
			
				'Check to see if this is the beginning of a new section.
				'If so we're not still currently processing the previous section.
				If line[..1] = "[" Then inSection = False
				If Not inSection
					If line[..1] = ";"	'global comment?
						SetComment(line[1..])
					ElseIf line[..1] = "["
						'extract new section name
						Local endOfHeader:Int = line.find("]")
						If endOfHeader <> - 1
							newSectionName = line[1..endOfHeader]
							AddSection(newSectionName)
							
							'see if there is a comment field for this section
							Local commentStart:Int = line.find(";")
							If commentStart <> - 1
								SetSectionComment(newSectionName, line[commentStart + 1..])
							EndIf
							inSection = True
						EndIf
					EndIf
				Else ' We're loading parameters and values for a section section
					'first find the parameter name
					Local endOfParameter:Int = line.find("=")
					If endOfParameter <> - 1
						Local parameterName:String = line[..endOfParameter]
						
						'Now find out how many values are in the current line
						Local numberOfValues:Int = 0
						Local current:Int = 0
						Local finished:Int = False
						Local _string:String = line
						While Not finished
							current = _string.find("~q")
							If current = -1
								finished = True
							Else
								numberOfValues:+1
								_string = _string[current + 1..]
							EndIf
						Wend
						numberOfValues:/2
						

						Local Values:String[NumberOfValues]
						current:Int = 0
						Local valueString:String = line[endOfParameter..]
						finished:Int = False
						Local startGot:Int = False
						Local valEnd:Int = 0
						Local currentVal:Int = 0

						'extract all values from parameter
						While Not finished
						
							current = valueString.find("~q")
							If current = -1
								finished = True
							EndIf
							If Not startGot
								startGot = True
							Else
								valEnd = current
								Values[currentVal] = valueString[..valEnd]
								currentVal:+1
								If currentVal > NumberOfValues - 1 Then finished = True
								startGot = False
							EndIf
							valueString = valueString[current + 1..]
						Wend
						
						'Add new parameter and values to the ini Type 
						AddParameter(newSectionName, parameterName)
						SetStringValues(newSectionName, parameterName, Values)
						
						' Check for parameter comments and add them if necessary
						Local endOfLastValue:Int = line.findlast("~q")
						line = line[endOfLastValue + 1..]
						Local parameterCommentStart:Int = line.find(";")
						If parameterCommentStart <> - 1
							SetParameterComment(newSectionName, parameterName, line[parameterCommentStart + 1..])
						EndIf
					EndIf
					
				EndIf
			EndIf
		Wend
		CloseFile(fileHandle)
		Return True
	EndMethod

	Rem
	bbdoc: Check if a parameter exists in a specified Section in the #TINIFile Object
	Returns: True if the parameter exists
	EndRem		
	Method ParameterExists:Int(sectionName:String, parameterName:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.ParameterExists(parameterName)
			EndIf
		Next
		Return False
	EndMethod
	
	Rem
	bbdoc: Saves the #TINIFile object to a file
	Returns: True if the INI file has been saved correctly
	About:
	Saves the #TINIFile object to the filename configured by either the #SetFilename Method
	or at Object creation time by the #Create Function.  By default the sections and parameters
	are sorted before being saved, if this is not wanted then call the Save() method with a
	False parameter.
	EndRem
	Method Save:Int(sortBeforeSave:Int = True)
		If filename_
			Local out:TStream = WriteFile(filename_)
			If out
				If sortBeforeSave Then Sort()
				If comment_ <> "" Then WriteLine(out, ";" + comment_)
				For Local section:TINISection = EachIn LSections_
					section.Save(out)
					WriteLine(out, "")
				Next
				CloseFile(out)
				Return True
			EndIf
		EndIf
		Return False
	EndMethod

	Rem
	bbdoc: Check if a Section exists in the #TINIFile Object
	Returns: True if the section exists
	EndRem
	Method SectionExists:Int(name:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = name
				Return True
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Boolean value. 
	Returns: True if the value has been set
	EndRem
	Method SetBoolValue:Int(sectionName:String, parameterName:String, value:String)
		If value.ToLower() = "true" Or value.ToLower() = "false"
			Return SetStringValue(sectionName, parameterName, value.ToLower())
		Else
			RuntimeError "Attempting to set bad bool value: ~q" + value + "~q.  Valid values are TRUE and FALSE"
		EndIf
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Boolean values
	Returns: True if the values have been set
	EndRem	
	Method SetBoolValues:Int(sectionName:String, parameterName:String, values:String[])
		Local castValues:String[] = New String[values.Length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = values[i].ToLower()
			If castValues[i] <> "true" And castValues[i] <> "false"
				RuntimeError "Attempting to set bad bool value: ~q" + castValues[i] + "~q.  Valid values are TRUE and FALSE"
			End If
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod
	
		
	Rem
	bbdoc: Set a parameter's value to a Byte value. 
	Returns: True if the value has been set
	EndRem
	Method SetByteValue:Int(sectionName:String, parameterName:String, value:Byte)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Bytes
	Returns: True if the values have been set
	EndRem	
	Method SetByteValues:Int(sectionName:String, parameterName:String, values:Byte[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod

	Rem
	bbdoc: Set the INI file comment line
	Returns:
	About:
	EndRem
	Method SetComment(comment:String)
		comment_ = comment
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Double value. 
	Returns: True if the value has been set
	EndRem
	Method SetDoubleValue:Int(sectionName:String, parameterName:String, value:Double)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Doubles
	Returns: True if the values have been set
	EndRem		
	Method SetDoubleValues:Int(sectionName:String, parameterName:String, values:Double[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod
			
	Rem
	bbdoc: Sets the filename of the INI File Object
	Returns:
	About:
	Sets the filename of the INI File, this is used by both #LoadConfig and #Save
	EndRem
	Method SetFilename(filename:String)
		filename_ = filename
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Float value. 
	Returns: True if the value has been set
	EndRem
	Method SetFloatValue:Int(sectionName:String, parameterName:String, value:Float)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Floats
	Returns: True if the values have been set
	EndRem		
	Method SetFloatValues:Int(sectionName:String, parameterName:String, values:Float[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod
	
	Rem
	bbdoc: Set a parameter's value to an Int value. 
	Returns: True if the value has been set
	EndRem
	Method SetIntValue:Int(sectionName:String, parameterName:String, value:Int)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Ints
	Returns: True if the values have been set
	EndRem		
	Method SetIntValues:Int(sectionName:String, parameterName:String, values:Int[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Long value. 
	Returns: True if the value has been set
	EndRem
	Method SetLongValue:Int(sectionName:String, parameterName:String, value:Long)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Longs
	Returns: True if the values have been set
	EndRem		
	Method SetLongValues:Int(sectionName:String, parameterName:String, values:Long[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod

	Rem
	bbdoc: Sets the comment field for a Parameter
	Returns: True if the comment as been added
	EndRem		
	Method SetParameterComment:Int(sectionName:String, parameterName:String, comment:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.SetParameterComment(parameterName, comment)
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set the comment field associated with a Section in the #TINIFile Object
	Returns: True if the comment has been added
	EndRem	
	Method SetSectionComment:Int(name:String, comment:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = name
				section.SetComment(comment)
				Return True
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Short value. 
	Returns: True if the value has been set
	EndRem
	Method SetShortValue:Int(sectionName:String, parameterName:String, value:Short)
		Return SetStringValue(sectionName, parameterName, String(value))
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Shorts
	Returns: True if the values have been set
	EndRem		
	Method SetShortValues:Int(sectionName:String, parameterName:String, values:Short[])
		Local castValues:String[values.length]
		For Local i:Int = 0 To values.length - 1
			castValues[i] = String(values[i])
		Next
		Return SetStringValues(sectionName, parameterName, castValues)
	EndMethod

	Rem
	bbdoc: Set the value for a specific parameter.  This overwrites any values already assigned
	Return: True if the value has been set
	EndRem		
	Method SetStringValue:Int(sectionName:String, parameterName:String, value:String)
		'make sure the section and parameters exist if createWhenMissing is set
		If createMissingEntries_
			If Not SectionExists(sectionName)
				AddSection(sectionName)
			EndIf
			If Not ParameterExists(sectionName, parameterName)
				AddParameter(sectionName, parameterName)
			EndIf
		EndIf
		
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.SetParameterStringValue(parameterName, value)
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set the values for a specific parameter to the contents of a String array.  This overwrites any values already assigned
	Return: True if the values have been set
	EndRem	
	Method SetStringValues:Int(sectionName:String, parameterName:String, values:String[])
		'make sure the section and parameters exist if createWhenMissing is set
		If createMissingEntries_
			If Not SectionExists(sectionName)
				AddSection(sectionName)
			EndIf
			If Not ParameterExists(sectionName, parameterName)
				AddParameter(sectionName, parameterName)
			EndIf
		EndIf
		
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				Return section.SetParameterStringValues(parameterName, values)
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Sorts all Sections and Parameters alphabetically
	Returns:
	EndRem
	Method Sort()
		SortSections()
		For Local section:TINISection = EachIn LSections_
			SortParameters(section.GetName())
		Next
	EndMethod

	Rem
	bbdoc: Sorts all Parameters in a Section alphabetically
	Returns:
	EndRem		
	Method SortParameters(sectionName:String)
		For Local section:TINISection = EachIn LSections_
			If section.GetName() = sectionName
				section.SortParameters()
				Exit
			EndIf
		Next
	EndMethod

	Rem
	bbdoc: Sorts all Sections alphabetically
	Returns:
	EndRem	
	Method SortSections()
		Local LSortedSections:TList = New TList
		Local sectionNames:String[] = GetSections()
		sectionNames.Sort
		For Local sectionName:String = EachIn sectionNames
			For Local section:TINISection = EachIn LSections_
				If section.GetName() = sectionName
					ListAddLast(LSortedSections, section)
					Exit
				EndIf
			Next
		Next
		LSections_ = LSortedSections
	EndMethod

EndType



