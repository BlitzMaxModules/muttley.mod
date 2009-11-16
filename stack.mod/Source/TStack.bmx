Rem
	bbdoc: Array based Stack implementation
End Rem
Type TStack
	
	' The objects in the stack
	Field _array:Object[]
	
	' How much the stack should grow by if it needs to expand
	' to accomodate more objects
	Field _growSize:Int
	
	' The index of the top entry on the stack
	Field _top:Int

	
	
	rem
		bbdoc: Clears the stack
	endrem
	Method Clear()
		For Local i:Int = 0 To _array.Length - 1
			_array[i] = Null
		Next
		_top = -1
	End Method
	
	
	
	rem
		bbdoc: Create a Stack with the specified initial and grow sizes
		about: If more objects are pushed to the stack than it can hold, it will
		automatically grow by the size you specify
	endrem
	Function Create:TStack(size:Int, growSize:Int = 1)
		If size < 0 Or growSize < 0 Then Return Null
		
		Local stack:TStack = New TStack
		stack._array = New Object[size]
		stack._growSize = growSize
		
		Return stack
	End Function
	
	
	
	rem
		bbdoc: Returns the current size of the stack
	endrem
	Method GetSize:Int()
		Return _array.Length
	End Method
	
	
	
	rem
		bbdoc: Grows the stack by the amount specified when the stack was created
	endrem
	Method Grow()
		_array = _array[.._array.Length + _growSize]
	End Method
	
	
	
	rem
		bbdoc: Default constructor
	endrem
	Method New()
		_growSize = 1
		_top = -1
	End Method

	
	
	rem
		bbdoc: Get the top object from the stack without removing it
	endrem
	Method Peek:Object()
		Local o:Object = Null
		If _top >= 0
			o = _array[_top]
		End If
		Return o
	End Method
	
	
	
	rem
		bbdoc: Remove the top object from the stack and return it
	endrem
	Method Pop:Object()
		Local o:Object = Null
		If _top >= 0
			o = _array[_top]
			_array[_top] = Null
			_top:-1
		End If
		Return o
	End Method
	
	
	
	rem
		bbdoc: Add the specified object to the top of the stack
	endrem
	Method Push(o:Object)
		_top:+1
		If _top + 1 > _array.Length
			Grow()
		End If
		_array[_top] = o
	End Method

End Type
