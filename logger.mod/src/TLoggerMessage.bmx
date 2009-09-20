Rem
bbdoc: This class represents and actual log message that is sent to all log writers
End Rem
Type TLoggerMessage
	
	Rem
	bbdoc: The identifier of the host that created this message
	EndRem
	Field host:String

	Rem
	bbdoc: The message itself
	EndRem
	Field message:String
	
	Rem
	bbdoc: The severity of the message
	EndRem
	Field severity:Int
	
	Rem
	bbdoc: The timestamp of when the message was created
	about: The timestamp is in RFC 3164 compatable format, for example:
	<pre>
	Sep 20 20:09:23
	Jan  1 07:23:57
	</pre>
	EndRem
	Field timestamp:String

End Type
