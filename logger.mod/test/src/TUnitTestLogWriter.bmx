'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TUnitTestLogWriter Extends TLogWriter

	Field received:TList
	
	Method close()
		Return
	End Method

	Method New()
		received = New TList
	End Method
	
	Method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		received.AddLast(message)
	End Method
	
End Type
