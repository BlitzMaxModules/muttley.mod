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
.Handle:brl.stream.TStream&
.filename$&
.description$&
.overwrite%&
.maxLogFileSize%&
.logLevel%&
.timeStampFormat%&
-New%()="_muttley_logfilehandler_TLogFile_New"
-Delete%()="_muttley_logfilehandler_TLogFile_Delete"
+Create:TLogFile(filename$=$"logfile.log",description$=$"Log File",logLevel%=1,timeStampFormat%=1,overwrite%=1,maxLogFileSize%=104857600)="_muttley_logfilehandler_TLogFile_Create"
-SetTimeStampFormat%(format%)="_muttley_logfilehandler_TLogFile_SetTimeStampFormat"
-CreateTimeStamp$()="_muttley_logfilehandler_TLogFile_CreateTimeStamp"
-Init%()="_muttley_logfilehandler_TLogFile_Init"
-WriteHeader%()="_muttley_logfilehandler_TLogFile_WriteHeader"
-WriteFooter%()="_muttley_logfilehandler_TLogFile_WriteFooter"
-Rotate%()="_muttley_logfilehandler_TLogFile_Rotate"
-Close%()="_muttley_logfilehandler_TLogFile_Close"
-WriteEntry%(entry$,level%=1)="_muttley_logfilehandler_TLogFile_WriteEntry"
-LogGlobal%(entry$)="_muttley_logfilehandler_TLogFile_LogGlobal"
-LogInfo%(entry$)="_muttley_logfilehandler_TLogFile_LogInfo"
-LogWarn%(entry$)="_muttley_logfilehandler_TLogFile_LogWarn"
-LogError%(entry$)="_muttley_logfilehandler_TLogFile_LogError"
-LogEntry%(entry$,level%=1)="_muttley_logfilehandler_TLogFile_LogEntry"
-SetLevel%(level@=3)="_muttley_logfilehandler_TLogFile_SetLevel"
}="muttley_logfilehandler_TLogFile"
