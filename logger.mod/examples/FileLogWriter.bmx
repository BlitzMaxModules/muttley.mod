SuperStrict

Framework muttley.logger

Local fileWriter:TFileLogWriter = New TFileLogWriter
fileWriter.setLevel(LOGGER_DEBUG)
fileWriter.setFilename("data/FileLogWriter.log")

Local logger:TLogger = Tlogger.getInstance()
logger.addWriter(fileWriter)

logger.logInfo("[ConsoleLogWriter] An example Info log message")
logger.logError("[ConsoleLogWriter] An example Error log message")

logger.close()