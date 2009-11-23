rem
	bbdoc: TEditor class
	about:
endrem
Type TEditor

	Const GRID_BOTTOM:Int = 500
	Const GRID_LEFT:Int = 200
	Const GRID_RIGHT:Int = 600
	Const GRID_TOP:Int = 100
	
	Const GRID_SIZE_X:Int = 16
	Const GRID_SIZE_Y:Int = 16
	
	Const CELL_SIZE_X:Int = 25
	Const CELL_SIZE_Y:Int = 25

	Global _instance:TEditor

	Field _colours:TColour[,]
	
	

	
	
	
	Method ClearGrid()
		For Local x:Int = 0 To GRID_SIZE_X - 1
			For Local y:Int = 0 To GRID_SIZE_Y - 1
				_colours[x, y] = TColour.Black()
			Next
		Next
	End Method
	
	
	
	Method CloneGrid:TColour[,] ()
		Local copy:TColour[,] = New TColour[GRID_SIZE_X, GRID_SIZE_X]
		
		For Local x:Int = 0 To GRID_SIZE_X - 1
			For Local y:Int = 0 To GRID_SIZE_Y - 1
				copy[x, y] = _colours[x, y]
			Next
		Next
		
		Return copy
	End Method
	
	
	
	Method DrawCells()
		For Local x:Int = 0 To GRID_SIZE_X - 1
			For Local y:Int = 0 To GRID_SIZE_Y - 1
				_colours[x, y].Set()
				DrawRect(200 + (x * 25), 100 + (y * 25), 25, 25)
			Next
		Next	
	End Method

	
	Method DrawGrid()
		SetColor(255, 255, 255)
		
		' Draw horizontal grid lines
		For Local i:Int = 0 To GRID_SIZE_X
			DrawLine(GRID_LEFT, GRID_TOP + (i * 25),  ..
				GRID_RIGHT, GRID_TOP + (i * 25) ..
			)
		Next
		
		' Draw vertical grid lines
		For Local i:Int = 0 To GRID_SIZE_Y
			DrawLine(GRID_LEFT + (i * 25), GRID_TOP,  ..
				GRID_LEFT + (i * 25), GRID_BOTTOM ..
			)
		Next
	End Method

	
	
	Method GetCell:TColour(x:Int, y:Int)
		If x < GRID_SIZE_X And y < GRID_SIZE_Y
			Return _colours[x, y]
		Else
			Return Null
		EndIf
	End Method
	
	
	
	Function GetInstance:TEditor()
		If Not _instance
			_instance = New TEditor
		EndIf
			
		Return _instance
	EndFunction
		
		
		
	Method GetMouseCellX:Int(x:Int)
		Return (x - GRID_LEFT) / CELL_SIZE_X
	End Method
	
	Method GetMouseCellY:Int(y:Int)
		Return (y - GRID_TOP) / CELL_SIZE_Y
	End Method
	
	Method Initialise()
		_colours = New TColour[GRID_SIZE_X, GRID_SIZE_Y]
		ClearGrid()
	End Method
	
	
	
	Method MouseInCell:Int(x:Int, y:Int)
		If x < GRID_LEFT Or x > GRID_RIGHT Or y < GRID_TOP Or y > GRID_BOTTOM
			Return False
		Else
			Return True
		EndIf
	End Method
	
	
	
	Method New()
		If _instance Throw "Cannot create multiple instances of Singleton Type"
		_instance = Self
		Initialise()
	EndMethod



	Method Render()
		DrawCells()
		DrawGrid()
	End Method
	
	
	Method SetCell(x:Int, y:Int, colour:TColour)
		If x < GRID_SIZE_X And y < GRID_SIZE_Y
			_colours[x, y] = colour
		EndIf
	End Method
	
	
	Method SetGrid(grid:TColour[,])
		For Local x:Int = 0 To GRID_SIZE_X - 1
			For Local y:Int = 0 To GRID_SIZE_Y - 1
				_colours[x, y] = grid[x, y]
			Next
		Next
	End Method
	
EndType
