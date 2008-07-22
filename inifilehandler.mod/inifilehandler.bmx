REM
This file was created by the BLIde solution explorer and should not be modified from outside BLIde
EndRem
'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &HFF Program Info
'Program: Untitled
'Version: 1
'Subversion: 0
'Revision: 7
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
Private
TYPE z_3b75efa0_40eb_4f5c_add5_1f2638ad39ff abstract  'Resource folder
End Type


TYPE z_blide_bga3f6604c_ec53_4b85_a73e_961163f28c39 Abstract
    Const Name:string = "Untitled" 'This string contains the name of the program
    Const MajorVersion:Int = 1  'This Const contains the major version number of the program
    Const MinorVersion:Int = 0  'This Const contains the minor version number of the program
    Const Revision:Int =  7  'This Const contains the revision number of the current program version
    Const VersionString:String = MajorVersion + "." + MinorVersion + "." + Revision   'This string contains the assembly version in format (MAJOR.MINOR.REVISION)
    Const AssemblyInfo:String = Name + " " + MajorVersion + "." + MinorVersion + "." + Revision   'This string represents the available assembly info.
EndType


Type z_My_a3f6604c_ec53_4b85_a73e_961163f28c39 Abstract 'This type has all the run-tima binary information of your assembly
    Global Application:z_blide_bga3f6604c_ec53_4b85_a73e_961163f28c39  'This item has all the currently available assembly version information.
    Global Resources:z_3b75efa0_40eb_4f5c_add5_1f2638ad39ff  'This item has all the currently available incbined files names and relative location.
End Type


Global My:z_My_a3f6604c_ec53_4b85_a73e_961163f28c39 'This GLOBAL has all the run-time binary information of your assembly, and embeded resources shortcuts.
Public
'#EndRegion &H04 MyNamespace


'------------------------------------------------------------------------------------------------------------------------------------------------------
'#Region &H03 Includes
Include "src\TINIFile.bmx"
Include "src\TINIParameter.bmx"
Include "src\TINISection.bmx"
Include "src\TINIValue.bmx"
 
'#EndRegion &H03

