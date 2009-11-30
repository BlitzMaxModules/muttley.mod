
New TTestSuite.run()

Type TCommandsStackTests Extends TTest
	
	Field _commandStack:TCommandStack
	
	Method Setup() {before}
		_commandStack = New TCommandStack
		TUndoableUnitTestCommand.g_executeCount = 0
		TUndoableUnitTestCommand.g_mergeCount = 0
		TUndoableUnitTestCommand.g_unexecuteCount = 0
	End Method
	
	Method CanInstantiateCommandStack() {test}
		AssertNotNull(_commandStack)
	End Method
	
	Method CanAddCommandToStack() {test}
		Local command:TUndoableUnitTestCommand = New TUndoableUnitTestCommand
		_commandStack.AddCommand(command)
		AssertEqualsI(1, command.g_executeCount)
		AssertEqualsI(0, command.g_mergeCount)
		AssertEqualsI(0, command.g_unexecuteCount)
	End Method
	
	Method CorrectlyReportIsDirty() {test}
		AssertFalse(_commandStack.IsDirty())
		_commandStack.AddCommand(New TUndoableUnitTestCommand)
		AssertTrue(_commandStack.IsDirty())
	End Method
	
	Method CorrectAmountOfCommandsRun() {test}
		For Local i:Int = 1 To 10
			_commandStack.AddCommand(New TUndoableUnitTestCommand)
		Next
		AssertEqualsI(10, TUndoableUnitTestCommand.g_executeCount)
	End Method
	
	Method CommandsMergedWherePossible() {test}
		For Local i:Int = 1 To 10
			_commandStack.AddCommand(New TMergeableUnitTestCommand)
		Next
		AssertEqualsI(1, _commandStack.UndoCount())
		AssertEqualsI(9, TUndoableUnitTestCommand.g_mergeCount)
		AssertEqualsI(10, TUndoableUnitTestCommand.g_executeCount)
		_commandStack.AddCommand(New TUndoableUnitTestCommand)
		AssertEqualsI(2, _commandStack.UndoCount())
		AssertEqualsI(9, TUndoableUnitTestCommand.g_mergeCount)
		AssertEqualsI(11, TUndoableUnitTestCommand.g_executeCount)
	End Method
	
	Method CorrectlyDetermineSameCommandType() {test}
		Local command:TUndoableUnitTestCommand = New TUndoableUnitTestCommand
		AssertTrue(command.SameCommandType(New TUndoableUnitTestCommand))
		AssertFalse(command.SameCommandType(New TMergeableUnitTestCommand))
		AssertFalse(command.SameCommandType(New TUnitTestCommand))
	End Method
	
	Method CanUndoCommands() {test}
		For Local i:Int = 1 To 10
			_commandStack.AddCommand(New TUndoableUnitTestCommand)
			_commandStack.Undo()
		Next
		AssertEqualsI(10, TUndoableUnitTestCommand.g_executeCount)
		AssertEqualsI(10, TUndoableUnitTestCommand.g_unexecuteCount)
	End Method
	
	Method CanRecordMacroCommand() {test}
		_commandStack.StartRecordingMacro()
		For Local i:Int = 1 To 10
			_commandStack.AddCommand(New TUndoableUnitTestCommand)
		Next
		Local macro:TMacroCommand = _commandStack.StopRecordingMacro()
		AssertNotNull(macro)
	End Method

	Method MacroMadeFromCopyOfCommands() {test}
		Local commands:TUndoableUnitTestCommand[10]
		
		_commandStack.StartRecordingMacro()
		
		For Local i:Int = 0 To 9
			commands[i] = New TUndoableUnitTestCommand
			_commandStack.AddCommand(commands[i])
		Next
		
		Local macro:TMacroCommand = _commandStack.StopRecordingMacro()
		
		Local i:Int = 0
		For Local macroCommand:TUndoableUnitTestCommand = EachIn macro._commands
			AssertNotSame(macroCommand, commands[i])
			AssertEqualsI(commands[i]._id, macroCommand._id)
			i:+1
		Next
	End Method
	
End Type