rem
	bbdoc: A simple class for storing and retrieving objects
endrem
Type TRegistry

	' This holds the singleton instance of this Type
	Global _instance:TRegistry
	
	' The map used by the registry for storing objects
	Field _registry:TMap

	
	
	rem
		bbdoc: Adds an object to the registry indexed by the provided string
		about: An index string can only be used once, any subsequent attempts to
		add objects to the registry using the same index value will be silently
		ignored
	endrem
	Method Add(index:String, value:Object)
		If Not IsRegistered(index)
			_registry.Insert(index, value)
		End If
	End Method
	
	
	
	rem
		bbdoc: Gets the object referenced by the specified index string
	endrem
	Method Get:Object(index:String)
		Local value:Object = Null
		
		If IsRegistered(index)
			value = _registry.ValueForKey(index)
		EndIf
		
		Return value
	End Method
	
	
			
	rem
		bbdoc: Get the instance of the registry
		returns: The Singleton instance TRegistry
		about: The registry is a singleton class and this function should be used
		to access it
	endrem
	Function GetInstance:TRegistry()
		If Not _instance
			_instance = New TRegistry
		EndIf

		Return _instance
	End Function
	
		
	
	rem
		bbdoc: Returns whether an object is registered with the specified index string
	endrem
	Method IsRegistered:Int(index:String)
		Return _registry.Contains(index)
	End Method



	rem
		bbdoc: Default constructor
	endrem		
	Method New()
		If _instance Throw "Cannot create multiple instances of Singleton Type"
		_registry = New TMap
	End Method



	rem
		bbdoc: Removes the object referenced by the specified index string
	endrem
	Method Remove(index:String)
		If IsRegistered(index)
			_registry.Remove(index)
		End If
	End Method

EndType
