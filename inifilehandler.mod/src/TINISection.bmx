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

Type TINISection
	Field name_:String
	Field comment_:String
	Field LParameters_:TList = New TList

	Function Create:TINISection(name:String, comment:String = Null)
		Local this:TINISection = New TINISection
		this.SetName(name)
		this.SetComment(comment)
		Return this		
	End Function
	
	Method AddParameter:Int(name:String, comment:String = Null)
		If ParameterExists(name) Then Return False
		Local newParameter:TINIParameter = TINIParameter.Create(name, comment)
		If newParameter
			ListAddLast(LParameters_, newParameter)
			Return True
		Else
			Return False
		EndIf
	EndMethod

	Method DeleteParameter:Int(name:String)
		If Not ParameterExists(name) Then Return False
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				ListRemove(LParameters_, parameter)
				parameter = Null
				Return True
			EndIf
		Next
		Return False
	EndMethod
		
	Method GetComment:String()
		Return comment_
	EndMethod

	Method GetName:String()
		Return name_
	EndMethod

	Method GetParameterComment:String(name:String)
		If Not ParameterExists(name) Then Return Null
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				Return parameter.GetComment()
			EndIf
		Next
		Return Null
	EndMethod
		
	Method GetParameterNames:String[] ()
		Local nParameters:Int = LParameters_.count()
		Local parameters:String[nParameters]
		Local i:Int = 0
		For Local parameter:TINIParameter = EachIn LParameters_
			parameters[i] = parameter.GetName()
			i:+1
		Next
		Return parameters
	EndMethod
	
	Method GetParameterValue:TINIValue(name:String)
		Local value:TINIValue
		If Not ParameterExists(name) Then Return Null
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				value = parameter.GetValue()
			EndIf
		Next
		Return value
	EndMethod
	
	Method GetParameterValues:TINIValue[] (name:String)
		If Not ParameterExists(name) Then Return Null
		Local values:TINIValue[]
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				values = parameter.GetValues()
			EndIf
		Next
		Return values
	EndMethod
	
	Method ParameterExists:Int(name:String)
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				Return True
			EndIf
		Next
		Return False
	EndMethod
	
	Method Save(out:TStream)
		If out
			If comment_ <> ""
				WriteLine(out, "[" + name_ + "]~t;" + comment_)
			Else
				WriteLine(out, "[" + name_ + "]" + comment_)
			EndIf
			For Local parameter:TINIParameter = EachIn LParameters_
				parameter.Save(out)
			Next
		EndIf
	EndMethod

	Method SetComment(comment:String)
		comment_ = comment
	EndMethod
			
	Method SetName(name:String)
		name_ = name
	EndMethod

	Method SetParameterComment:Int(name:String, comment:String)
		If Not ParameterExists(name) Then Return False
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				parameter.SetComment(comment)
				Return True
			EndIf
		Next
		Return False
	EndMethod

	Method SetParameterStringValue:Int(name:String, value:String)
		If Not ParameterExists(name) Then Return False
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				Return parameter.SetStringValue(value)
			EndIf
		Next
		Return False
	EndMethod
	
	Method SetParameterStringValues:Int(name:String, values:String[])
		If Not ParameterExists(name) Then Return False
		For Local parameter:TINIParameter = EachIn LParameters_
			If parameter.GetName() = name
				Return parameter.SetStringValues(values)
			EndIf
		Next
		Return False
	EndMethod

	Method SortParameters()
		Local LSortedParameters:TList = New TList
		Local parameters:String[] = GetParameterNames()
		parameters.Sort
		For Local parameterName:String = EachIn parameters
			For Local parameter:TINIParameter = EachIn LParameters_
				If parameter.GetName() = parameterName
					ListAddLast(LSortedParameters, parameter)
					Exit
				EndIf
			Next
		Next
		LParameters_ = LSortedParameters
	EndMethod
		
EndType
