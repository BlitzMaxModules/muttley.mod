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
Private
TYPE z_bd460470_2500_4c9a_bab4_50c634f5a682 abstract  'Resource folder
End Type


TYPE z_blide_bg2335d4db_2a70_4ed4_8a51_28020167c5ff Abstract
    Const Name:string = "Log File Handler" 'This string contains the name of the program
    Const MajorVersion:Int = 1  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
    Const Revision:Int =  2  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
EndType


Type z_My_2335d4db_2a70_4ed4_8a51_28020167c5ff Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg2335d4db_2a70_4ed4_8a51_28020167c5ff  'This item has all the currently available assembly version information.
    Global Resources:z_bd460470_2500_4c9a_bab4_50c634f5a682  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_2335d4db_2a70_4ed4_8a51_28020167c5ff 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "src\TLogFile.bmx"
 
'#EndRegion &H03

