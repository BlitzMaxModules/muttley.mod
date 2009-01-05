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
ModuleInfo "Version: 1.0.7"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (C) 2007 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"

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
	
	Field Filename:String
	Field comment:String
	Field Lsections:TList = CreateList()
	Field createWhenMissing:Int = False

	Rem 
	bbdoc: Create a new INI File
	Returns: An INI File object
	About:
	Creates a new INI File object.
	If no filename is specified the default, config.ini, is used.
	EndRem
	Function Create:TINIFile( _filename:String = "config.ini" )
		Local _newTINIFile:TINIFile = New TINIFile
	
		If _newTINIFILE
			_newTINIFile.Filename = _filename
		EndIf	
		Return _newTINIFile
	EndFunction

	Rem
	bbdoc: Adds a new Parameter to a specified Section in the #TINIFILE Object
	Returns: True if the parameter as been added
	EndRem	
	Method AddParameter:Int( _section_name:String, _parameter:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.AddParameter( _parameter )
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Add a new section to the #TINIFile Object. Section names must be unique.
	Returns: True if the section has been added
	EndRem
	Method AddSection:Int( _name:String, _comment:String = "" )
		If SectionExists( _name )
			Return False
		Else
			Local _new_section:TINISection = New TINISection
			If _new_section
				_new_section.SetName( _name )
				_new_section.SetComment( _comment )
				ListAddLast( Lsections, _new_section )
				Return True
			Else
				Return False
			EndIf
		EndIf
	EndMethod

	Rem
	bbdoc: Tells the INI file whether to create missing parameters/settings when requested or not, this is off my default
	Returns:
	EndRem
	Method CreateMissingEntries( bool:Int = True )
		createWhenMissing = bool
	End Method

	Rem
	bbdoc: Deletes a Parameter
	Returns: True if the Parameter has been deleted
	EndRem		
	Method DeleteParameter:Int( _section_name:String, _parameter:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.DeleteParameter( _parameter )
			EndIf
		Next
		Return False		
	EndMethod

	Rem
	bbdoc: Delete a Section (and all contained parameters) if it exists in the #TINIFile Object
	Returns: True if the section has been deleted
	EndRem	
	Method DeleteSection:Int( _name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _name
				ListRemove( Lsections, _section )
				_section = Null
				Return True
			EndIf
		Next
		Return False
	EndMethod

	
	Rem
	bbdoc: Get a Boolean value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: int
	EndRem
	Method GetBoolValue:Int( _section_name:String, _parameter_name:String, defaultValue:String = Null )
		Local returnValue:String = GetStringValue( _section_name, _parameter_name, Null )
		If returnValue <> Null
			Select returnValue.ToLower()
				Case "true"
					Return True
				Case "false"
					Return False
				Default
					If defaultValue.ToLower() = "true" Then Return True
					If defaultValue.ToLower() = "false" Then Return False
			endselect
		Else
			If createWhenMissing and defaultValue <> Null
				If defaultValue.tolower() = "false" or defaultValue.tolower() = "true"
					AddSection( _section_name )
					AddParameter( _section_name, _parameter_name )
					SetStringValue( _section_name, _parameter_name, defaultValue.ToLower() )
				endif
			EndIf
			If defaultValue.ToLower() = "true" Then Return True
			If defaultValue.ToLower() = "false" Then Return False
		EndIf
	EndMethod

	
	Rem
	bbdoc: Get an Int array of all Boolean values from a parameter
	Returns: Byte[]
	EndRem
	Method GetBoolValues:Int[]( _section_name:String, _parameter_name:String, defaultValues:String[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name, Null )
		If values <> Null
			Local boolValues:Int[Values.length]
			For Local i:Int = 0 To values.length -1
				If Values[i].ToLower() = "true"
					boolValues[i] = True
				ElseIf Values[i].ToLower() = "false"
					boolValues[i] = False
				EndIf
			Next
			Return boolValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetBoolValues( _section_name, _parameter_name, defaultValues )
			EndIf
			Local boolValues:Int[ defaultValues.length]
			For Local i:Int = 0 To defaultValues.length -1
				If defaultValues[i].ToLower() = "true"
					boolValues[i] = True
				ElseIf defaultValues[i].ToLower() = "false"
					boolValues[i] = False
				EndIf
			Next
			Return boolValues
		EndIf
	EndMethod
		
	
	Rem
	bbdoc: Get a Byte value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Byte
	EndRem
	Method GetByteValue:Byte( _section_name:String, _parameter_name:String, defaultValue:Byte = Null )
		Local returnValue:Byte = Byte( GetStringValue( _section_name, _parameter_name, Null ) )
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetByteValue( _section_name, _parameter_name, defaultValue )
			EndIf
			Return defaultValue
		EndIf
	EndMethod
	
	Rem
	bbdoc: Get a Byte array of all values from a parameter
	Returns: Byte[]
	EndRem
	Method GetByteValues:Byte[]( _section_name:String, _parameter_name:String, defaultValues:Byte[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name, Null )
		If values <> Null
			Local byteValues:Byte[values.length]
			For Local i:Int = 0 To values.length -1
				byteValues[i] = Byte(values[i])
			Next
			Return byteValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetByteValues( _section_name, _parameter_name, defaultValues )
			EndIf
			Return defaultValues
		EndIf
	EndMethod

	Rem
	bbdoc: Get the INI file comment line
	Returns: String containing the comment
	About:
	EndRem
	Method GetComment:String()
		Return comment
	EndMethod

	Rem
	bbdoc: Get a Double value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Double
	EndRem
	Method GetDoubleValue:Double( _section_name:String, _parameter_name:String, defaultValue:Double = Null )
		Local returnValue:Double =  Double( GetStringValue( _section_name, _parameter_name, Null ) )
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetDoubleValue( _section_name, _parameter_name, defaultValue )
			EndIf
			Return defaultValue
		EndIf
	EndMethod

	Rem
	bbdoc: Get a Double array of all values from a parameter
	Returns: Double[]
	EndRem	
	Method GetDoubleValues:Double[]( _section_name:String, _parameter_name:String, defaultValues:Double[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name )
		If values <> Null
			Local doubleValues:Double[values.length]
			For Local i:Int = 0 To values.length -1
				doubleValues[i] = Double(values[i])
			Next
			Return doubleValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetDoubleValues( _section_name, _parameter_name, defaultValues )
			EndIf
			Return defaultValues
		EndIf
	EndMethod
		
	Rem
	bbdoc: Returns the filename of the INI File Object
	Returns: String containing the current filename
	EndRem
	Method GetFilename:String()
		Return Filename
	End Method

	Rem
	bbdoc: Get a Float value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Float
	EndRem
	Method GetFloatValue:Float( _section_name:String, _parameter_name:String, defaultValue:Float = Null )
		Local returnValue:Float = Float(GetStringValue( _section_name, _parameter_name ))
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetFloatValue( _section_name, _parameter_name, defaultValue )
			EndIf		
			Return defaultValue
		EndIf
	EndMethod

	Rem
	bbdoc: Get a Float array of all values from a parameter
	Returns: Float[]
	EndRem		
	Method GetFloatValues:Float[]( _section_name:String, _parameter_name:String, defaultValues:Float[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name )
		If values <> Null
			Local floatValues:Float[values.length]
			For Local i:Int = 0 To values.length -1
				floatValues[i] = Float(values[i])
			Next
			Return floatValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetFloatValues( _section_name, _parameter_name, defaultValues )
			EndIf		
			Return defaultValues
		EndIf
	EndMethod

	Rem
	bbdoc: Get an Int value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Int
	EndRem
	Method GetIntValue:Int( _section_name:String, _parameter_name:String, defaultValue:Int = Null )
		Local returnValue:Int = Int(GetStringValue( _section_name, _parameter_name ))
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetIntValue( _section_name, _parameter_name, defaultValue )
			EndIf		
			Return defaultValue
		End If
	EndMethod

	Rem
	bbdoc: Get an Int array of all values from a parameter
	Returns: Int[]
	EndRem		
	Method GetIntValues:Int[]( _section_name:String, _parameter_name:String, defaultValues:Int[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name )
		If values <> Null
			Local intValues:Int[values.length]
			For Local i:Int = 0 To values.length -1
				intValues[i] = Int(values[i])
			Next
			Return intValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetIntValues( _section_name, _parameter_name, defaultValues )
			EndIf		
			Return defaultValues
		EndIf
	EndMethod

	Rem
	bbdoc: Get a Long value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Long
	EndRem
	Method GetLongValue:Long( _section_name:String, _parameter_name:String, defaultValue:Long = Null )
		Local returnValue:Long = Long(GetStringValue( _section_name, _parameter_name ))
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetLongValue( _section_name, _parameter_name, defaultValue )
			EndIf		
			Return defaultValue
		End If
	EndMethod

	Rem
	bbdoc: Get a Long array of all values from a parameter
	Returns: Long[]
	EndRem		
	Method GetLongValues:Long[]( _section_name:String, _parameter_name:String, defaultValues:Long[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name )
		If values <> Null
			Local longValues:Long[values.length]
			For Local i:Int = 0 To values.length -1
				longValues[i] = Long(values[i])
			Next
			Return longValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetLongValues( _section_name, _parameter_name, defaultValues )
			EndIf		
			Return defaultValues
		EndIf
	EndMethod
	
	Rem
	bbdoc: Gets the comment field for a Parameter
	Returns: A string containing the comment
	EndRem		
	Method GetParameterComment:String( _section_name:String, _parameter:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.GetParameterComment( _parameter )
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Get a list of all Parameters in a Section of the #TINIFile Object
	Returns: An array of #String
	EndRem		
	Method GetParameters:String[]( _name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _name
				Return _section.GetParameters()
			EndIf
		Next
	EndMethod

	Rem
	bbdoc: Get the comment field associated with a Section in the #TINIFile Object
	Returns: #String
	EndRem	
	Method GetSectionComment:String( _section_name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.GetComment()
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
	Method GetSections:String[]()
		Local _number_of_sections:Int = Lsections.count()
		Local _all_sections:String[ _number_of_sections ]
		Local i:Int = 0
		For Local _Lsections:TINISection = EachIn Lsections
			_all_sections[ i ] = _Lsections.Name
			i :+ 1
		Next
		Return _all_sections
	EndMethod	

	Rem
	bbdoc: Get a Short value from a parameter.  If a parameter has multiple values only the first is returned.
	Returns: Short
	EndRem
	Method GetShortValue:Short( _section_name:String, _parameter_name:String, defaultValue:Short = Null )
		Local returnValue:Short = Short(GetStringValue( _section_name, _parameter_name ))
		If returnValue <> Null
			Return returnValue
		Else
			If createWhenMissing And defaultValue <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetShortValue( _section_name, _parameter_name, defaultValue )
			EndIf		
			Return defaultValue
		End If
	EndMethod

	Rem
	bbdoc: Get a Short array of all values from a parameter
	Returns: Short[]
	EndRem		
	Method GetShortValues:Short[]( _section_name:String, _parameter_name:String, defaultValues:Short[] = Null )
		Local values:String[] = GetStringValues( _section_name, _parameter_name )
		If values <> Null
			Local shortValues:Short[values.length]
			For Local i:Int = 0 To values.length -1
				shortValues[i] = Short(values[i])
			Next
			Return shortValues
		Else
			If createWhenMissing And defaultValues <> Null
				addsection( _section_name )
				addParameter( _section_name, _parameter_name )
				SetShortValues( _section_name, _parameter_name, defaultValues )
			EndIf		
			Return defaultValues
		EndIf
	EndMethod

	Rem
	bbdoc: Gets the value (or first value if there is more than one) belonging to a parameter
	Returns: String containing the value
	EndRem		
	Method GetStringValue:String( _section_name:String, _parameter_name:String, defaultValue:String = Null )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Local value:String = _section.GetStringValue( _parameter_name )
				If value <> Null
					Return value
				Else
					If createWhenMissing And defaultValue <> Null
						addsection( _section_name )
						addParameter( _section_name, _parameter_name )
						SetStringValue( _section_name, _parameter_name, defaultValue )
					EndIf				
					Return defaultValue
				End If
			EndIf
		Next
		If createWhenMissing And defaultValue <> Null
			addsection( _section_name )
			addParameter( _section_name, _parameter_name )
			SetStringValue( _section_name, _parameter_name, defaultValue )
		EndIf			
		Return defaultValue		
	EndMethod

	Rem
	bbdoc: Gets all the values belonging to a parameter
	Returns: String Array containing the values
	EndRem	
	Method GetStringValues:String[]( _section_name:String, _parameter_name:String, defaultValues:String[] = Null )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Local values:String[] = _section.GetStringValues( _parameter_name )
				If values <> Null
					Return values
				Else
					If createWhenMissing And defaultValues <> Null
						addsection( _section_name )
						addParameter( _section_name, _parameter_name )
						SetStringValues( _section_name, _parameter_name, defaultValues )
					EndIf					
					Return defaultValues
				End If
			EndIf
		Next
		If createWhenMissing And defaultValues <> Null
			addsection( _section_name )
			addParameter( _section_name, _parameter_name )
			SetStringValues( _section_name, _parameter_name, defaultValues )
		EndIf			
		Return defaultValues
	EndMethod

	Rem
	bbdoc: Loads data from a file into the #TINIFile Object
	Returns:
	About:
	Saves the INI file 
	EndRem	
	Method Load:Int()
		Local inSection:Int = False
		Local fileHandle:TStream = ReadFile( Filename )
		If Not fileHandle Then Return False
		Local blankLine:Int = False
		Local newSectionName:String
		
		While Not Eof( fileHandle )
			Local line:String = Trim( ReadLine( fileHandle ) )
			If line = "" Then blankLine = True Else blankLine = False

			If Not Blankline	'ignore blank lines in config file
			
				'Check to see if this is the beginning of a new section.
				'If so we're not still currently processing the previous section.
				If line[..1] = "[" Then inSection = False
				If Not inSection
					If line[..1] = ";"	'global comment?
						SetComment( line[1..] )
					ElseIf line[..1] = "["
						'extract new section name
						Local endOfHeader:Int = line.find("]")
						If endOfHeader <> -1
							newSectionName = line[1..endOfHeader]
							AddSection( newSectionName )
							
							'see if there is a comment field for this section
							Local commentStart:Int = line.find(";")
							If commentStart <> -1
								SetSectionComment( newSectionName, line[commentStart+1..] )
							EndIf
							inSection = True
						EndIf
					EndIf				
				Else ' We're loading parameters and values for a section section
					'first find the parameter name
					Local endOfParameter:Int = line.find("=")
					If endOfParameter <> -1
						Local parameterName:String = line[..endOfParameter]
						
						'Now find out how many values are in the current line
						Local numberOfValues:Int = 0
						Local current:Int = 0
						Local finished:Int = False
						Local _string:String = line
						While Not finished
							current = _string.find("~q")
							If current = -1
								finished=True
							Else
								numberOfValues :+ 1
								_string = _string[ current + 1.. ]
							EndIf
						Wend
						numberOfValues :/ 2
						

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
								Values[currentVal]=valueString[..valEnd]
								currentVal :+ 1
								If currentVal > NumberOfValues - 1 Then finished = True
								startGot = False
							EndIf
							valueString = valueString[current + 1..]
						Wend
						
						'Add new parameter and values to the ini Type 
						AddParameter( newSectionName, parameterName )
						SetStringValues( newSectionName, parameterName, Values )
						
						' Check for parameter comments and add them if necessary
						Local endOfLastValue:Int = line.findlast("~q")
						line = line[ endOfLastValue + 1 .. ]
						Local parameterCommentStart:Int = line.find(";")
						If parameterCommentStart <> -1 Then SetParameterComment( newSectionName, parameterName, line[parameterCommentStart+1..] )
					EndIf
					
				EndIf 
			EndIf	
		Wend
		CloseFile( fileHandle )
		Return True
	EndMethod

	Rem
	bbdoc: Check if a parameter exists in a specified Section in the #TINIFile Object
	Returns: True if the parameter exists
	EndRem		
	Method ParameterExists:Int( _section_name:String, _parameter_name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.ParameterExists( _parameter_name )
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
	Method Save:Int( sortBeforeSave:Int = True )
		If Filename
			Local out:TStream = WriteFile( Filename )
			If out
				If sortBeforeSave Then Sort()
				If comment <> "" Then WriteLine( out, ";" + comment )
				For Local _section:TINISection = EachIn Lsections
					_section.Save( out )
					WriteLine( out, "" )
				Next
				CloseFile( out )
				Return True
			EndIf
		EndIf
		Return False
	EndMethod

	Rem
	bbdoc: Check if a Section exists in the #TINIFile Object
	Returns: True if the section exists
	EndRem
	Method SectionExists:Int( _name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _name Then Return True
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Boolean value. 
	Returns: True if the value has been set
	EndRem
	Method SetBoolValue:Int( _section_name:String, _parameter:String, _value:String )
		If _value.ToLower() = "true" or _value.ToLower() = "false"
			Return SetStringValue( _section_name, _parameter, _value.ToLower() )
		Else
			Return False
		EndIf
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Boolean values
	Returns: True if the values have been set
	EndRem	
	Method SetBoolValues:Int( _section_name:String, _parameter:String, _values:String[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			If _values[i].ToLower() = "true"
				castValues[i] = "true"
			ElseIf _values[i].ToLower() = "false"
				castValues[i] = "false"
			EndIf
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod
	
		
	Rem
	bbdoc: Set a parameter's value to a Byte value. 
	Returns: True if the value has been set
	EndRem
	Method SetByteValue:Int( _section_name:String, _parameter:String, _value:Byte )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Bytes
	Returns: True if the values have been set
	EndRem	
	Method SetByteValues:Int( _section_name:String, _parameter:String, _values:Byte[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod	

	Rem
	bbdoc: Set the INI file comment line
	Returns:
	About:
	EndRem
	Method SetComment( _comment:String )
		comment = _comment
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Double value. 
	Returns: True if the value has been set
	EndRem
	Method SetDoubleValue:Int( _section_name:String, _parameter:String, _value:Double )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Doubles
	Returns: True if the values have been set
	EndRem		
	Method SetDoubleValues:Int( _section_name:String, _parameter:String, _values:Double[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod		
			
	Rem
	bbdoc: Sets the filename of the INI File Object
	Returns:
	About:
	Sets the filename of the INI File, this is used by both #LoadConfig and #Save
	EndRem
	Method SetFilename( _filename:String )
		Filename = _filename	
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Float value. 
	Returns: True if the value has been set
	EndRem
	Method SetFloatValue:Int( _section_name:String, _parameter:String, _value:Float )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Floats
	Returns: True if the values have been set
	EndRem		
	Method SetFloatValues:Int( _section_name:String, _parameter:String, _values:Float[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod	
	
	Rem
	bbdoc: Set a parameter's value to an Int value. 
	Returns: True if the value has been set
	EndRem
	Method SetIntValue:Int( _section_name:String, _parameter:String, _value:Int )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Ints
	Returns: True if the values have been set
	EndRem		
	Method SetIntValues:Int( _section_name:String, _parameter:String, _values:Int[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod	

	Rem
	bbdoc: Set a parameter's value to a Long value. 
	Returns: True if the value has been set
	EndRem
	Method SetLongValue:Int( _section_name:String, _parameter:String, _value:Long )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Longs
	Returns: True if the values have been set
	EndRem		
	Method SetLongValues:Int( _section_name:String, _parameter:String, _values:Long[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod	

	Rem
	bbdoc: Sets the comment field for a Parameter
	Returns: True if the comment as been added
	EndRem		
	Method SetParameterComment:Int( _section_name:String, _parameter:String, _value:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.SetParameterComment( _parameter, _value )
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set the comment field associated with a Section in the #TINIFile Object
	Returns: True if the comment has been added
	EndRem	
	Method SetSectionComment:Int( _section_name:String, _section_comment:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				_section.SetComment( _section_comment )
				Return True
			EndIf
		Next
		Return False		
	EndMethod

	Rem
	bbdoc: Set a parameter's value to a Short value. 
	Returns: True if the value has been set
	EndRem
	Method SetShortValue:Int( _section_name:String, _parameter:String, _value:Short )
		Return SetStringValue( _section_name, _parameter, String(_value) )
	EndMethod

	Rem
	bbdoc: Set a parameter's values to an array of Shorts
	Returns: True if the values have been set
	EndRem		
	Method SetShortValues:Int( _section_name:String, _parameter:String, _values:Short[] )
		Local castValues:String[_values.length]
		For Local i:Int = 0 To _values.length-1
			castValues[i] = String(_values[i])
		Next
		Return SetStringValues( _section_name, _parameter, castValues )
	EndMethod	

	Rem
	bbdoc: Set the value for a specific parameter.  This overwrites any values already assigned
	Return: True if the value has been set
	EndRem		
	Method SetStringValue:Int( _section_name:String, _parameter:String, _value:String )
		'make sure the section and parameters exist if createWhenMissing is set
		If createWhenMissing
			If Not SectionExists(_section_name) 
				AddSection(_section_name) 
			EndIf
			If Not ParameterExists(_section_name, _parameter) 
				AddParameter(_section_name, _parameter) 
			EndIf
		EndIf
		
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.SetStringValue(_parameter, _value) 
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Set the values for a specific parameter to the contents of a String array.  This overwrites any values already assigned
	Return: True if the values have been set
	EndRem	
	Method SetStringValues:Int( _section_name:String, _parameter:String, _values:String[] )
		'make sure the section and parameters exist if createWhenMissing is set
		If createWhenMissing
			If Not SectionExists(_section_name) 
				AddSection(_section_name) 
			EndIf
			If Not ParameterExists(_section_name, _parameter) 
				AddParameter(_section_name, _parameter) 
			EndIf
		EndIf
		
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				Return _section.SetStringValues(_parameter, _values) 
			EndIf
		Next
		Return False
	EndMethod

	Rem
	bbdoc: Sorts all sections and parameters alphabetically
	Returns:
	EndRem
	Method Sort()
		SortSections()
		For Local _section:TINISection = EachIn Lsections
			SortParameters( _section.GetName() )
		Next
	EndMethod

	Rem
	bbdoc: Sorts all parameters alphabetically
	Returns:
	EndRem		
	Method SortParameters( _section_name:String )
		For Local _section:TINISection = EachIn Lsections
			If _section.GetName() = _section_name
				_section.SortParameters()
				Exit
			EndIf
		Next
	EndMethod

	Rem
	bbdoc: Sorts all sections alphabetically
	Returns:
	EndRem	
	Method SortSections()
		Local _new_Lsections:TList = New TList
		Local _all_sections:String[] = GetSections()
		_all_sections.Sort
		For Local _section_name:String = EachIn _all_sections
			For Local _section_link:TINISection = EachIn Lsections
				If _section_link.GetName() = _section_name
					ListAddLast( _new_Lsections, _section_link )
					Exit
				EndIf
			Next
		Next
		Lsections = _new_Lsections
	EndMethod

EndType



