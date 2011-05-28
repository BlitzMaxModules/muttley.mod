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

Type TProfilerSample
	
	Field _firstSample:Int
	
	Field _maxTime:Double
	
	Field _minTime:Double
	
	Field _name:String
	
	Field _totalTime:Double
	
	Field _runCount:Int
	
	Field _running:Int

	Method GetName:String()
		Return _name
	End Method
		
	Method New()
		_firstSample = True
		_running = False
		_totalTime = 0.0
		_runCount = 0
	End Method
	
	Method SetName(value:String)
		_name = value
	End Method
	
End Type
