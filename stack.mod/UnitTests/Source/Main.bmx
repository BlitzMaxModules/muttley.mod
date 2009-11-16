rem
'
' This is the main launch point for our unit tests
'
endrem

New TTestSuite.run()

Type TStackTests Extends TTest

	Const INITIAL_STACK_SIZE:Int = 10
	Const INITIAL_GROW_SIZE:Int = 5
	
	Field _stack:TStack
	
	
	Method Setup() {before}
		_stack = TStack.Create(INITIAL_STACK_SIZE, INITIAL_GROW_SIZE)
	End Method
	
	
	
	Method CanInstantiateStack() {test}
		assertNotNull(New TStack)
	End Method
	
	
	
	Method CanCreateStackWithPositiveSize() {test}
		assertNotNull(TStack.Create(1))
	End Method
	
	
	
	Method StackIsCreatedWithCorrectSize() {test}
		assertEqualsI(_stack.GetSize(), INITIAL_STACK_SIZE)
	End Method
	
	
	
	Method StackIsCreatedWithCorrectGrowSize() {test}
		assertEqualsI(_stack._growSize, 5)
	End Method
	
	
	
	Method CannotCreateStackWithNegativeSize() {test}
		assertNull(TStack.Create(-10))
	End Method
	
	
	
	Method CannotCreateStackWithNegativeGrowSize() {test}
		assertNull(TStack.Create(INITIAL_STACK_SIZE, -5))
	End Method
	
	
	
	Method CanPushObject() {test}
		_stack.Push(New TStack)
	End Method
	
	
	
	Method CanPopObject() {test}
		_stack.Push(New TStack)
		assertNotNull(_stack.Pop())
	End Method
	
	
	
	Method CannotPopEmptyStack() {test}
		assertNull(_stack.Pop())
	End Method
	
	
	
	Method CorrectObjectIsPopped() {test}
		Local o:Object
		For Local i:Int = 0 To INITIAL_STACK_SIZE - 1
			o = New TStack
			_stack.Push(o)
		Next
		assertEquals(o, _stack.Pop())
	End Method
	
	
	
	Method CannotOverfillStack() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize() + 10
			o = New TStack
			_stack.Push(o)
		Next
		assertEquals(o, _stack.Pop())
	End Method
	
	
	
	Method StackGrowsWhenNeeded() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize() + 1
			o = New TStack
			_stack.Push(o)
		Next
		assertTrue(INITIAL_STACK_SIZE < _stack.GetSize())
	End Method
	
	
	
	Method StackGrowsByTheCorrectAmount() {test}
		Local o:Object
		For Local i:Int = 0 To _stack.GetSize() + 1
			o = New TStack
			_stack.Push(o)
		Next
		assertEqualsI(INITIAL_STACK_SIZE + INITIAL_GROW_SIZE, _stack.GetSize())
	End Method
	
	
	
	Method CanPeekFromStack() {test}
		Local o:Object = New TStack
		_stack.Push(o)
		assertEquals(o, _stack.Peek())
	End Method
	
	
	
	Method CannotPeekFromEmptyStack() {test}
		assertNull(_stack.Peek())
	End Method
	
	
	
	Method ObjectsAreCorrectlyPopped() {test}
		Local objects:TStack[] = New TStack[INITIAL_STACK_SIZE]
		For Local i:Int = 0 To INITIAL_STACK_SIZE - 1
			objects[i] = New TStack
			_stack.Push(objects[i])
		Next
		For Local i:Int = INITIAL_STACK_SIZE - 1 To 0 Step - 1
			assertEquals(objects[i], _stack.Pop())
		Next
	End Method
	
	
	
	Method CanPushToStackCreatedWithNew() {test}
		Local myStack:TStack = New TStack
		Local o:Object = New TStack
		myStack.Push(o)
		assertEquals(o, myStack.Pop())
	End Method
	
	
	
	Method CanClearStack() {test}
		For Local i:Int = 0 To INITIAL_STACK_SIZE - 1
			_stack.Push(New TStack)
		Next
		_stack.Clear()
		For Local i:Int = 0 To INITIAL_STACK_SIZE - 1
			assertNull(_stack._array[i])
		Next			
	End Method
	
End Type