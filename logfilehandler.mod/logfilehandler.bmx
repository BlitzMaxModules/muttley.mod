REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: Log File Handler
'Version: 1
'Subversion: 0
'Revision: 2
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
Rem
    bbdoc:muttley\logfilehandler
End Rem
Module muttley.logfilehandler
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Import brl.filesystem
Import brl.system
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'LIB
'guid:e7882b32_2e20_4c35_abc4_6640bf0f45fc
Private
TYPE z_e7882b32_2e20_4c35_abc4_6640bf0f45fc_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bge7882b32_2e20_4c35_abc4_6640bf0f45fc Abstract
    Const Name:string = "Log File Handler" 'This string contains the name of the program
    Const MajorVersion:Int = 1  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
    Const Revision:Int =  2  'This Const contains the revision number of the current program version
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


Type z_My_e7882b32_2e20_4c35_abc4_6640bf0f45fc Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bge7882b32_2e20_4c35_abc4_6640bf0f45fc  'This item has all the currently available assembly version information.
    Global Resources:z_e7882b32_2e20_4c35_abc4_6640bf0f45fc_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_e7882b32_2e20_4c35_abc4_6640bf0f45fc 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "src\TLogFile.bmx"
 
'#EndRegion &H03

