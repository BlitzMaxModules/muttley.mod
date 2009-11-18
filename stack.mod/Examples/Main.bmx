rem
'
' Create a new stack with an initial size of 2 elements, and a grow size of 3 elements.
' This means that the third object to be pushed to the stack will cause it to grow to 5
' elements in length; once a sixth object is pushed it will grow to 8 elements, etc.
'	
endrem
Local stack:TStack = TStack.Create(2, 3)

DisplayStackSize(stack)

RestoreData ExampleData

For Local i:Int = 1 To 6
	' Create objects from our test data
	Local person:TPerson = New TPerson
	ReadData person._name, person._age
	
	Print "Pushing ~q" + person.ToString() + "~q on to stack."

	' Push the new object onto the stack	
	stack.Push(person)
	
	DisplayStackSize(stack)
Next

' While there are still objects on the stack, we'll pop them off one by one
While stack.Peek()
	' You need to cast the returned object back to it's original Type
	Local person:TPerson = TPerson(stack.Pop())
	
	Print "Popped ~q" + person.ToString() + "~q off stack."
WEnd

' The stack does not automatically shrink
DisplayStackSize(stack)

End


Function DisplayStackSize(stack:TStack)
	Print "Stack size: " + stack.GetSize()
End Function



rem
'
' A simple example Type
'
endrem
Type TPerson
	Field _name:String
	Field _age:Int
	
	Method ToString:String()
		Return _name + " (" + _age + ")"
	End Method
End Type



rem
'
' Test Data
'
endrem
#ExampleData
DefData "John", 37
DefData "Susan", 42
DefData "Dave", 23
DefData "Ingrid", 21
DefData "Roger", 18
DefData "Mary", 33
