Rem
	License Details
	---------------
	muttley.INIFileHandler - BlitzMax INI File Handler Module
	Copyright (C) 2007 Paul Maskelyne

 	This software is licensed under the terms of the Artistic
 	License version 2.0.

	For full license details, please read the file 'artistic-2_0.txt' 
	included with this distribution, or see
	http://www.perlfoundation.org/legal/licenses/artistic-2_0.html
	
EndRem

SuperStrict

Import muttley.INIFileHandler

Local configFile:TINIFile=TINIFile.Create( "config.ini" ) 'Create handler.  config.ini is actually the default name

'Once you've created the handler, you can load the file up.  If the Load() method returns
'False then it was unable to load the config file and you should either do further checks
'or have a routine that creates and saves a default configuration (in case the user
'has deleted it by mistake, or maybe for a fresh installation).
If Not configFile.Load() Then Print "Config file missing"

'an example of storing your screen resolution and other settings in an ini file
Local width:Int = configFile.GetIntValue( "Graphics", "ScreenX" )
Local height:Int = configFile.GetIntValue( "Graphics", "ScreenY" )
Local depth:Int = configFile.GetIntValue( "Graphics", "BitDepth" )
Local Refresh:Int = configFile.GetIntValue( "Graphics", "Refresh" )
Local message:String = configFile.GetStringValue( "Data", "Message" )

'Now we'll create another INI file, this one doesn't exist on disk... unless you've already run this example of course.  ;)
Local missingConfigFile:TINIFile=TINIFile.Create( "generated.ini" )
missingConfigFile.Load()

missingConfigFile.CreateMissingEntries( True ) 'if set to true, any missings parameters are added to the INI file along with any required Sections

Local myByte:Byte = missingConfigFile.GetByteValue( "Bytes", "My Byte", 32:Byte )
Local myBytes:Byte[] = missingConfigFile.GetByteValues( "Bytes", "My Bytes", [ 1:Byte, 2:Byte, 4:Byte, 8:Byte, 16:Byte, 32:Byte, 64:Byte, 128:Byte ] )
Local myDouble:Double = missingConfigFile.GetDoubleValue( "Doubles", "My Double", 5234.7653:Double )
Local myDoubles:Double[] = missingConfigFile.GetDoubleValues( "Doubles", "My Doubles", [ 5324.7523475:Double, 7653.8754:Double ] )
Local myLong:Long = missingConfigFile.GetLongValue( "Longs", "My Long" )	'if default value is not provided the parameter won't be added to the ini file
Local myBool:Int = missingConfigFile.GetBoolValue( "Boolean", "My Boolean", "True" )
Print myBool
Local myBools:Int[] = missingConfigFile.GetBoolValues( "Boolean", "My Booleans", ["True","False","True","False","True","False","True","False","True","False"] )
missingConfigFile.SetBoolValue("Boolean", "My Boolean", "false") 

missingConfigFile.SetIntValue("New Section", "This is a new section", 64738) 
missingConfigFile.SetIntValue("New Section", "This is a another", 64738) 

For Local i:Int = EachIn myBools
	Print myBools[i]
Next

missingConfigFile.Save()

Graphics( width, height, depth, Refresh )

Local x:Int = ( width / 2 ) - ( TextWidth( message ) / 2 )
Local y:Int = ( height / 2 ) -  ( TextHeight( message ) / 2 )
While Not KeyHit( KEY_ESCAPE )
	Cls
	DrawText( message, x, y )
	DrawText( "Hit Escape to Exit", 0, 0 )

	Flip
Wend
