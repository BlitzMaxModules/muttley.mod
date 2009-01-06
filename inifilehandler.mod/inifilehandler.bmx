REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: muttley.inifilehandler
'Version: 2
'Subversion: 0
'Revision: 0
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
Rem
    bbdoc:muttley\inifilehandler
End Rem
Module muttley.inifilehandler
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
Import brl.filesystem
Import brl.system
Import brl.standardio
Import brl.retro
Import brl.linkedlist
Import brl.data
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'LIB
'guid:71ed5841_fd57_45f6_a9e6_ae65840d5d47
Private
TYPE z_71ed5841_fd57_45f6_a9e6_ae65840d5d47_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bg71ed5841_fd57_45f6_a9e6_ae65840d5d47 Abstract
    Const Name:string = "muttley.inifilehandler" 'This string contains the name of the program
    Const MajorVersion:Int = 2  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
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


Type z_My_71ed5841_fd57_45f6_a9e6_ae65840d5d47 Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bg71ed5841_fd57_45f6_a9e6_ae65840d5d47  'This item has all the currently available assembly version information.
    Global Resources:z_71ed5841_fd57_45f6_a9e6_ae65840d5d47_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_71ed5841_fd57_45f6_a9e6_ae65840d5d47 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "src\TINIFile.bmx"
Include "src\TINIParameter.bmx"
Include "src\TINISection.bmx"
Include "src\TINIValue.bmx"
 
'#EndRegion &H03

