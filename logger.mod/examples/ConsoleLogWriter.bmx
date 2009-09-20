SuperStrict

Framework muttley.logger

Local consoleWriter:TConsoleLogWriter = New TConsoleLogWriter
consoleWriter.setLevel(TLogger.LOG_DEBUG)
consoleWriter.showTimestamp(True)

Local logger:TLogger = Tlogger.getInstance()
logger.addWriter(consoleWriter)

logger.logInfo("[ConsoleLogWriter] An example Info log message")
logger.logError("[ConsoleLogWriter] An example Error log message")

logger.logMessage(23, "Blah!")

logger.close()