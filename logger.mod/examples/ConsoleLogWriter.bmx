SuperStrict

Framework muttley.logger

Local consoleWriter:TConsoleLogWriter = New TConsoleLogWriter
consoleWriter.setLevel(LOGGER_DEBUG)
consoleWriter.showTimestamp(True)
consoleWriter.showSeverity(true)

Local logger:TLogger = Tlogger.getInstance()
logger.addWriter(consoleWriter)

logger.logInfo("[ConsoleLogWriter] An example Info log message")
logger.logError("[ConsoleLogWriter] An example Error log message")

logger.close()