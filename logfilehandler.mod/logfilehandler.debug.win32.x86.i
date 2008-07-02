ModuleInfo "Name: muttley.LogFileHandler"
ModuleInfo "Version: 1.0.1"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (C) 2007 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"
ModuleInfo "History: 1.0.1"
ModuleInfo "History: Re-released under the Artistic License 2.0"
ModuleInfo "History: 1.0.0"
ModuleInfo "History: Initial Release"
import brl.blitz
import brl.filesystem
import brl.system
LOG_GLOBAL%=0
LOG_ERROR%=1
LOG_WARN%=2
LOG_INFO%=3
LOG_DATE%=0
LOG_TIME%=1
LOG_DATETIME%=2
TLogFile^brl.blitz.Object{
.handle:brl.stream.TStream&
.Filename$&
.description$&
.Overwrite%&
.MaxLogFileSize%&
.LogLevel%&
.timestampFormat%&
-New%()="_muttley_logfilehandler_TLogFile_New"
-Delete%()="_muttley_logfilehandler_TLogFile_Delete"
+Create:TLogFile(Filename$=$"logfile.log",description$=$"Log File",LogLevel%=1,timestampFormat%=1,Overwrite%=1,MaxLogFileSize%=104857600)="_muttley_logfilehandler_TLogFile_Create"
-SetTimestampFormat%(tFormat%)="_muttley_logfilehandler_TLogFile_SetTimestampFormat"
-CreateTimestamp$()="_muttley_logfilehandler_TLogFile_CreateTimestamp"
-Init%()="_muttley_logfilehandler_TLogFile_Init"
-WriteHeader%()="_muttley_logfilehandler_TLogFile_WriteHeader"
-WriteFooter%()="_muttley_logfilehandler_TLogFile_WriteFooter"
-Rotate%()="_muttley_logfilehandler_TLogFile_Rotate"
-Close%()="_muttley_logfilehandler_TLogFile_Close"
-WriteEntry%(entry$,level%=1)="_muttley_logfilehandler_TLogFile_WriteEntry"
-SetLevel%(level@=3)="_muttley_logfilehandler_TLogFile_SetLevel"
}="muttley_logfilehandler_TLogFile"
