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
	Field name_:String
	Field LValues_:TList = New TList
	Field comment_:String
	
	Method CheckValue:String(value:String)
		If value.find(",") = 0 And value.find(" ") = 0
			Return value
		Else
			Return "~q" + value + "~q"
		EndIf
	EndMethod
		
	Function Create:TINIParameter(name:String, comment:String = Null)
		Local this:TINIParameter = New TINIParameter
		this.SetName(name)
		this.SetComment(comment)
		Return this
	EndFunction

	Method GetComment:String()
		Return comment_
	EndMethod
	
	Method GetName:String()
		Return name_
	EndMethod
	
	Method GetValue:TINIValue()
		If LValues_.Count() = 0 Then Return Null
		Return TINIValue(LValues_.First())
	EndMethod
	
	Method GetValues:TINIValue[] ()
		If LValues_.Count() = 0 Then Return Null
		Local values:TINIValue[LValues_.Count()]
		Local i:Int = 0
		For Local value:TINIValue = EachIn LValues_
			values[i] = value
			i:+1
		Next
		Return values
	End Method
	
	Method ValuesToString:String[] ()
		Local values:String[CountList(LValues_)]
		Local i:Int = 0
		For Local value:TINIValue = EachIn LValues_
			values[i] = value.GetValue()
			i:+1
		Next
		Return values
	EndMethod
	
	Method Save(out:TStream)
		If out
			Local output:String = ""
			Local values:String[] = ValuesToString()
			Local i:Int = 0
			For Local value:String = EachIn values
				output:+CheckValue (value)
				If i < values.length - 1
					output:+", "
				EndIf
				i:+1
			Next
			If comment_ <> ""
				WriteLine(out, name_ + "=" + output + "~t;" + comment_)
			Else
				WriteLine(out, name_ + "=" + output)
			EndIf
		EndIf
	EndMethod

	Method SetComment(comment:String)
		comment_ = comment
	EndMethod
		
	Method SetName(name:String)
		name_ = name
	EndMethod

	Method SetStringValue:Int(value:String)
		ClearList(LValues_)
		Local newValue:TINIValue = New TINIValue
		newValue.SetValue(value)
		ListAddLast(LValues_, newValue)
		Return True
	EndMethod
		
	Method SetStringValues:Int(values:String[])
		ClearList(LValues_)
		For Local value:String = EachIn values
			Local newValue:TINIValue = New TINIValue
			newValue.SetValue(value)
			ListAddLast(LValues_, newValue)
		Next 
		Return True
	EndMethod

EndType


