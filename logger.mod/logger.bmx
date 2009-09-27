'Version: 1.1.0
'License: Artistic License 2.0
'Author: Paul Maskelyne (Muttley)
'Copyright: (c) 2009 Paul Maskelyne
'E-Mail: muttley@muttleyville.org
'Website: http://www.muttleyville.org
'History: 1.1.0
'History: Updated Syslog support to RFC5424
'History: 1.0.1
'History: Minor documentation fixes
'History: 1.0.0
'History: Initial Release
REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: logger.mod
'Version: 1
'Subversion: 1
'Revision: 0
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
Rem
    bbdoc:muttley\logger
End Rem
Module muttley.logger
ModuleInfo "Version: 1.1.0"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (c) 2009 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"
ModuleInfo "History: 1.1.0"
ModuleInfo "History: Updated Syslog support to RFC5424"
ModuleInfo "History: 1.0.1"
ModuleInfo "History: Minor documentation fixes"
ModuleInfo "History: 1.0.0"
ModuleInfo "History: Initial Release"
ModuleInfo ""
ModuleInfo ""
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Import bah.boost
Import bah.datetime
Import brl.socket
Import brl.socketstream
Import brl.standardio
Import brl.linkedlist
Import brl.filesystem
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'LIB
'guid:2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc
Private
TYPE z_2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bg2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc Abstract
    Const Name:string = "logger.mod" 'This string contains the name of the program
    Const MajorVersion:Int = 1  'This Const contains the major version number of the program
    Const MinorVersion:Int = 1  'This Const contains the minor version number of the program
    Const Revision:Int =  0  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
    ?win32
    Const Platform:String = "Win32" 'This constant contains "Win32", "MacOs" or "Linux" depending on the current running platoform for your game or application.
    ?
    ?MacOs
    Const Platform:String = "MacOs"
    ?
    ?Linux
    Const Platform:String = "Linux"
    ?
    ?PPC
    Const Architecture:String = "PPC" 'This const contains "x86" or "Ppc" depending on the running architecture of the running computer. x64 should return also a x86 value
    ?
    ?x86
    Const Architecture:String = "x86" 
    ?
    ?debug
    Const DebugOn : Int = True    'This const will have the integer value of TRUE if the application was build on debug mode, or false if it was build on release mode
    ?
    ?not debug
    Const DebugOn : Int = False
    ?
EndType


Type z_My_2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc  'This item has all the currently available assembly version information.
    Global Resources:z_2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_2c35c95c_dae3_4abd_9ee2_87d07ca0d7cc 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "src\TLogger.bmx"
Include "src\TLoggerMessage.bmx"
Include "src\Writers\TLogWriter.bmx"
Include "src\Writers\TConsoleLogWriter.bmx"
Include "src\Writers\TFileLogWriter.bmx"
Include "src\Writers\TSyslogLogWriter.bmx"
 
'#EndRegion &H03

