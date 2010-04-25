New TTestSuite.run()

Type RegistryTestSuite Extends TTest


	Method CanInstantiateRegistry() {test}
		AssertNotNull(TRegistry.GetInstance())
	End Method

	
	
	Method CannotCreateTwoInstancesOfRegistry() {test}
		TRegistry.GetInstance()
		
		Local errorThrown:Int = False
		
		Try
			New TRegistry
		Catch o:Object
			errorThrown = True
		End Try
		
		assertTrue(errorThrown, "Exception not thrown when trying to create more than one instance.")
	End Method
	
	
	
	Method CanAddObject() {test}
		TRegistry.GetInstance().Add("entry1", New TTestObject)
		AssertTrue(TRegistry.GetInstance().IsRegistered("entry1"))
	End Method
	
	
	
	Method CanRetrieveObject() {test}
		TRegistry.GetInstance().Add("entry2", New TTestObject)
		AssertNotNull(TRegistry.GetInstance().Get("entry2"))
	End Method
	
	
	
	Method CorrectObjectRetrieved() {test}
		Local newObject:TTestObject = New TTestObject
		TRegistry.GetInstance().Add("entry3", newObject)
		AssertSame(newObject, TRegistry.GetInstance().Get("entry3"))
	End Method
	
	
	
	Method CanRemoveObject() {test}
		TRegistry.GetInstance().Remove("entry3")
		AssertFalse(TRegistry.GetInstance().IsRegistered("entry3"))
	End Method
	
	
End Type
