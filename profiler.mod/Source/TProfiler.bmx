Rem
'
' Copyright (c) 2011 Paul Maskelyne <muttley@muttleyville.org>.
'
' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
EndRem

Type TProfiler

	Global _instance:TProfiler
	
	' True if the profiler is enabled
	Field _enabled:Int
	
	' The current sample depth
	Field _currentDepth:Int
	
	Field _sampleMap:TMap

	Rem
		bbdoc: Get the Singleton instance of the profiler
	EndRem	
	Function GetInstance:TProfiler()
		If _instance
			Return _instance
		Else
			Return New TProfiler
		EndIf
	EndFunction

	Method IsEnabled:Int()
		Return _enabled
	End Method
			
	Method New()
		If _instance Then
			Throw "Cannot create multiple instances of this Singleton Type"
		EndIf
		
		_instance = Self
		_sampleMap = New TMap
	EndMethod

	Method SetEnabled(value:Int)
		_enabled = value
	End Method
	
	
EndType
