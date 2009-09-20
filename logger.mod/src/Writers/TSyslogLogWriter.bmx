'This BMX file was edited with BLIde ( http://www.blide.org )
Rem
	bbdoc:Undocumented type
endRem
Type TSyslogLogWriter Extends TLogWriter

	const DEFAULT_FACILITY:Int = 16	'local0
	const DEFAULT_SERVER:string = "127.0.0.1"
	const DEFAULT_UDP_PORT:Int = 514

	field facility:Int
	field server:string
	field stream:TSocketStream
	field udpPort:Int
	
	method close()
		if stream
			stream.Flush()
			stream.Close()
		endIf
	endmethod
		
	method New()
		server = DEFAULT_SERVER
		udpPort = DEFAULT_UDP_PORT
		facility = DEFAULT_FACILITY
	endmethod
	
	method openSyslogStream()
		local socket:TSocket = TSocket.CreateUDP()
		socket.Connect(hostip(server), udpPort)
		stream = TSocketStream.Create(socket)
	endmethod
	
	method setFacility(value:Int)
		
	End Method
	
	method write(message:TLoggerMessage)
		If message.severity > level Then Return
		
		if not stream then openSyslogStream()
		
		local priority:Int = (facility * 8) + message.severity
		
		local line:string
		
		line:+"<" + priority + ">" + message.timestamp + " " + message.host + ": " + message.message
		
		if line.length > 1024 then line = line[..1024]
		
		stream.WriteString(line)
		stream.Flush()
	endmethod
	
endtype
