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

Type TINIParameter
	Field Name:String
	Field Lvalues:TList = CreateList()
	Field comment:String
	
	Function CheckValue:String(_value:String) 
		If _value.find( "," ) = 0 And _value.find( " " ) = 0
			Return _value
		Else
			Return "~q" + _value + "~q"
		EndIf
	End Function
		
	Function Create:TINIParameter( _name:String )
		Local _new_parameter:TINIParameter = New TINIParameter
		If _new_parameter
			_new_parameter.SetName( _name )
			Return _new_parameter
		EndIf
	EndFunction

	Method GetComment:String()
		Return comment
	EndMethod
	
	Method GetName:String()
		Return Name
	EndMethod

	Method GetStringValue:String()
		Local _value:String
		For Local _values:TINIValue = EachIn Lvalues
			Return _values.GetStringValue()
		Next
	EndMethod
	
	Method GetStringValues:String[]()
		Local _values:String[CountList(Lvalues)]
		Local i:Int = 0
		For Local _value:TINIValue = EachIn Lvalues
			_values[i] = _value.GetStringValue()
			i :+ 1
		Next
		Return _values
	EndMethod
	
	Method Save( out:TStream )
		If out
			Local _all_values:String = ""
			Local _values_array:String[] = GetStringValues()
			Local i:Int = 0
			For Local _value:String = EachIn _values_array
				_all_values :+ CheckValue ( _values_array[i] )
				If i < _values_array.length - 1
					_all_values :+ ", "
				EndIf
				i :+ 1
			Next
			If comment <> ""
				WriteLine( out, Name + "=" + _all_values + "~t;" + comment )
			Else
				WriteLine( out, Name + "=" + _all_values )
			EndIf
		EndIf
	EndMethod

	Method SetComment( _comment:String )
		comment = _comment
	EndMethod
		
	Method SetName( _name:String )
		Name = _name
	EndMethod

	Method SetStringValue( _value:String )
		ClearList(Lvalues)
		Local _new_value:TINIValue = New TINIValue
		_new_value.SetStringValue( _value )
		ListAddLast( Lvalues, _new_value )
		Return		
	EndMethod
		
	Method SetStringValues( _values:String[] )
		ClearList(Lvalues)
		For Local _value:String = EachIn _values
			Local _new_value:TINIValue = New TINIValue
			_new_value.SetStringValue( _value )
			ListAddLast( Lvalues, _new_value )
		Next 
		Return		
	EndMethod

EndType


