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
	Field Name:String
	Field comment:String
	Field Lparameters:TList = CreateList()

	Method AddParameter:Int( _name:String )
		If ParameterExists( _name ) Then Return False
		Local _new_parameter:TINIParameter = TINIParameter.Create( _name )
		If _new_parameter
			ListAddLast( Lparameters, _new_parameter )
			Return True
		Else
			Return False
		EndIf
	EndMethod

	Method DeleteParameter:Int( _name:String )
		If Not ParameterExists( _name ) Then Return False
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				ListRemove( Lparameters, _parameter )
				_parameter = Null
				Return True
			EndIf
		Next
		Return False
	EndMethod	
		
	Method GetComment:String()
		Return comment
	EndMethod

	Method GetName:String()
		Return Name
	EndMethod

	Method GetParameterComment:String( _name:String )
		If Not ParameterExists( _name ) Then Return Null
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				Return _parameter.GetComment()
			EndIf
		Next		
		Return Null
	EndMethod
		
	Method GetParameters:String[]()
		Local _number_of_parameters:Int = Lparameters.count()
		Local _all_parameters:String[ _number_of_parameters ]
		Local i:Int = 0
			For Local _Lparameters:TINIParameter = EachIn Lparameters
				_all_parameters[ i ] = _Lparameters.Name
				i :+ 1
			Next
		Return _all_parameters		
	EndMethod

	Method GetStringValue:String( _name:String )
		If Not ParameterExists( _name ) Then Return Null
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				Return _parameter.GetStringValue()
			EndIf
		Next		
		Return Null
	EndMethod
	
	Method GetStringValues:String[]( _name:String )
		If Not ParameterExists( _name ) Then Return Null
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				Return _parameter.GetStringValues()
			EndIf
		Next		
		Return Null
	EndMethod
	
	Method ParameterExists:Int( _parameter_name:String )
		For Local _parameters:TINIParameter = EachIn Lparameters
			If _parameters.GetName() = _parameter_name Then Return True
		Next
		Return False
	EndMethod
	
	Method Save( out:TStream )
		If out
			If comment <> ""
				WriteLine( out, "[" + Name + "]~t;" + comment )
			Else
				WriteLine( out, "[" + Name + "]" + comment )
			EndIf
			For Local _parameter:TINIParameter = EachIn LParameters
				_parameter.Save( out )
			Next
		EndIf
	EndMethod	

	Method SetComment( _comment:String )
		comment = _comment
	EndMethod
			
	Method SetName( _name:String )
		Name = _name
	EndMethod

	Method SetParameterComment( _name:String, _comment:String )
		If Not ParameterExists( _name ) Then Return
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				_parameter.SetComment( _comment )
				Return
			EndIf
		Next		
		Return
	EndMethod

	Method SetStringValue:Int( _name:String, _value:String )
		If Not ParameterExists( _name ) Then Return False
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				Return _parameter.SetStringValue( _value )
			EndIf
		Next
		Return False
	EndMethod	
	
	Method SetStringValues:Int( _name:String, _values:String[] )
		If Not ParameterExists( _name ) Then Return False
		For Local _parameter:TINIParameter = EachIn Lparameters
			If _parameter.GetName() = _name
				Return _parameter.SetStringValues( _values )
			EndIf
		Next
		Return False
	EndMethod	

	Method SortParameters()
		Local _new_Lparameters:TList = New TList
		Local _all_parameters:String[] = GetParameters()
		_all_parameters.Sort
		For Local _parameter_name:String = EachIn _all_parameters
			For Local _parameter_link:TINIParameter = EachIn Lparameters
				If _parameter_link.GetName() = _parameter_name
					ListAddLast( _new_Lparameters, _parameter_link )
					Exit
				EndIf
			Next
		Next
		Lparameters = _new_Lparameters
	EndMethod
		
EndType
