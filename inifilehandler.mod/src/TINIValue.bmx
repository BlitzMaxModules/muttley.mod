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

Type TINIValue
	Field value:String

	Method GetStringValue:String()
		Return value
	EndMethod
		
	Method SetStringValue( _value:String )
		value = _value
	EndMethod
	
EndType