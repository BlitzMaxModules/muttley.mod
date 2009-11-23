'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
End Rem
Type TColour
	Field _r:Int
	Field _g:Int
	Field _b:Int
	
	Function Black:TColour()
		Local colour:TColour = New TColour
		colour._r = 0
		colour._g = 0
		colour._b = 0
		Return colour
	End Function
		
	Function Blue:TColour()
		Local colour:TColour = New TColour
		colour._r = 0
		colour._g = 0
		colour._b = 255
		Return colour
	End Function
		
	Method Equals:Int(colour:TColour)
		Return (colour._b And _b) And (colour._g And _g) And (colour._r And _r)
	End Method
	
	Function Green:TColour()
		Local colour:TColour = New TColour
		colour._r = 0
		colour._g = 255
		colour._b = 0
		Return colour
	End Function
		
	Method New()
		_r = 255
		_g = 255
		_b = 255
	End Method
		
	Function Red:TColour()
		Local colour:TColour = New TColour
		colour._r = 255
		colour._g = 0
		colour._b = 0
		Return colour
	End Function
	
	Method Set()
		SetColor(_r, _g, _b)
	End Method
	
End Type
