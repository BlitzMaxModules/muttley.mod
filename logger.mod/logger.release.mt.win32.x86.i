ModuleInfo "Version: 1.0.0"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (c) 2009 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"
ModuleInfo "History: 1.0.0"
ModuleInfo "History: Initial Release"
ModuleInfo ""
import brl.blitz
import bah.boost
import bah.datetime
import brl.socket
import brl.socketstream
import brl.standardio
import brl.linkedlist
import brl.filesystem
LOGGER_EMERGENCY%=0
LOGGER_ALERT%=1
LOGGER_CRITICAL%=2
LOGGER_ERROR%=3
LOGGER_WARNING%=4
LOGGER_NOTICE%=5
LOGGER_INFO%=6
LOGGER_DEBUG%=7
TLogger^brl.blitz.Object{
instance:TLogger&=mem:p("_muttley_logger_TLogger_instance")
.host$&
.logWriters:brl.linkedlist.TList&
.messageCounts%&[]&
.runningUnitTests%&
-New%()="_muttley_logger_TLogger_New"
-Delete%()="_muttley_logger_TLogger_Delete"
-addWriter%(writer:TLogWriter)="_muttley_logger_TLogger_addWriter"
-createTimestamp$()="_muttley_logger_TLogger_createTimestamp"
-getHost$()="_muttley_logger_TLogger_getHost"
+getInstance:TLogger()="_muttley_logger_TLogger_getInstance"
-logMessage%(severity%,message$)="_muttley_logger_TLogger_logMessage"
-logAlert%(message$)="_muttley_logger_TLogger_logAlert"
-logCritical%(message$)="_muttley_logger_TLogger_logCritical"
-logDebug%(message$)="_muttley_logger_TLogger_logDebug"
-logEmergency%(message$)="_muttley_logger_TLogger_logEmergency"
-logError%(message$)="_muttley_logger_TLogger_logError"
-logInfo%(message$)="_muttley_logger_TLogger_logInfo"
-logNotice%(message$)="_muttley_logger_TLogger_logNotice"
-logWarning%(message$)="_muttley_logger_TLogger_logWarning"
-resetStatistics%()="_muttley_logger_TLogger_resetStatistics"
-setHost%(value$)="_muttley_logger_TLogger_setHost"
-close%()="_muttley_logger_TLogger_close"
}="muttley_logger_TLogger"
LogAlert%(message$)="muttley_logger_LogAlert"
LogCritical%(message$)="muttley_logger_LogCritical"
LogDebug%(message$)="muttley_logger_LogDebug"
LogEmergency%(message$)="muttley_logger_LogEmergency"
LogError%(message$)="muttley_logger_LogError"
LogInfo%(message$)="muttley_logger_LogInfo"
LogNotice%(message$)="muttley_logger_LogNotice"
LogWarning%(message$)="muttley_logger_LogWarning"
TLoggerMessage^brl.blitz.Object{
.host$&
.message$&
.severity%&
.timestamp$&
-New%()="_muttley_logger_TLoggerMessage_New"
-Delete%()="_muttley_logger_TLoggerMessage_Delete"
}="muttley_logger_TLoggerMessage"
TLogWriter^brl.blitz.Object{
severityDescriptions$&[]&=mem:p("_muttley_logger_TLogWriter_severityDescriptions")
.level%&
-New%()="_muttley_logger_TLogWriter_New"
-Delete%()="_muttley_logger_TLogWriter_Delete"
-close%()A="brl_blitz_NullMethodError"
-getLevel%()="_muttley_logger_TLogWriter_getLevel"
-setLevel%(severity%)="_muttley_logger_TLogWriter_setLevel"
-severityToString$(severity%)="_muttley_logger_TLogWriter_severityToString"
-write%(message:TLoggerMessage)A="brl_blitz_NullMethodError"
}A="muttley_logger_TLogWriter"
TConsoleLogWriter^TLogWriter{
.displayTimestamp%&
.displaySeverity%&
-New%()="_muttley_logger_TConsoleLogWriter_New"
-Delete%()="_muttley_logger_TConsoleLogWriter_Delete"
-close%()="_muttley_logger_TConsoleLogWriter_close"
-showSeverity%(value%)="_muttley_logger_TConsoleLogWriter_showSeverity"
-showTimestamp%(value%)="_muttley_logger_TConsoleLogWriter_showTimestamp"
-write%(message:TLoggerMessage)="_muttley_logger_TConsoleLogWriter_write"
}="muttley_logger_TConsoleLogWriter"
TFileLogWriter^TLogWriter{
DEFAULT_FILENAME$=$"logfile.log"
DEFAULT_LEVEL%=3
DEFAULT_OVERWRITE%=1
.displaySeverity%&
.filename$&
.overwrite%&
.stream:brl.stream.TStream&
-New%()="_muttley_logger_TFileLogWriter_New"
-Delete%()="_muttley_logger_TFileLogWriter_Delete"
-close%()="_muttley_logger_TFileLogWriter_close"
-openLogFile%()="_muttley_logger_TFileLogWriter_openLogFile"
-setFilename%(value$)="_muttley_logger_TFileLogWriter_setFilename"
-setOverwrite%(value%)="_muttley_logger_TFileLogWriter_setOverwrite"
-showSeverity%(value%)="_muttley_logger_TFileLogWriter_showSeverity"
-write%(message:TLoggerMessage)="_muttley_logger_TFileLogWriter_write"
}="muttley_logger_TFileLogWriter"
TSyslogLogWriter^TLogWriter{
DEFAULT_FACILITY%=16
DEFAULT_SERVER$=$"127.0.0.1"
DEFAULT_UDP_PORT%=514
.facility%&
.server$&
.stream:brl.socketstream.TSocketStream&
.udpPort%&
-New%()="_muttley_logger_TSyslogLogWriter_New"
-Delete%()="_muttley_logger_TSyslogLogWriter_Delete"
-close%()="_muttley_logger_TSyslogLogWriter_close"
-openSyslogStream%()="_muttley_logger_TSyslogLogWriter_openSyslogStream"
-setFacility%(value%)="_muttley_logger_TSyslogLogWriter_setFacility"
-setServer%(value$)="_muttley_logger_TSyslogLogWriter_setServer"
-setUdpPort%(value%)="_muttley_logger_TSyslogLogWriter_setUdpPort"
-write%(message:TLoggerMessage)="_muttley_logger_TSyslogLogWriter_write"
}="muttley_logger_TSyslogLogWriter"
