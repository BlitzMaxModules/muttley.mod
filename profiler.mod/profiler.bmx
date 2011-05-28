REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: Profiler Module
'Version: 1
'Subversion: 0
'Revision: 0
'#EndRegion &HFF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H01 Compile Options
SuperStrict
Rem
    bbdoc:muttley\profiler
End Rem
Module muttley.profiler
'#EndRegion &H01



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H0F Framework
 
'#EndRegion &H0F



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HAF Imports

'#EndRegion &HAF



'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H04 MyNamespace
'LIB
'guid:f4c170c5_852d_4f2d_a30f_55f7f64cb3f2
Private
TYPE z_f4c170c5_852d_4f2d_a30f_55f7f64cb3f2_3_0 abstract  'Resource folder
End Type


TYPE z_blide_bgf4c170c5_852d_4f2d_a30f_55f7f64cb3f2 Abstract
    Const Name:string = "Profiler Module" 'This string contains the name of the program
    Const MajorVersion:Int = 1  'This Const contains the major version number of the program
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


Type z_My_f4c170c5_852d_4f2d_a30f_55f7f64cb3f2 Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bgf4c170c5_852d_4f2d_a30f_55f7f64cb3f2  'This item has all the currently available assembly version information.
    Global Resources:z_f4c170c5_852d_4f2d_a30f_55f7f64cb3f2_3_0  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_f4c170c5_852d_4f2d_a30f_55f7f64cb3f2 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "Source\TProfiler.bmx"
Include "Source\TProfilerSample.bmx"
 
'#EndRegion &H03

