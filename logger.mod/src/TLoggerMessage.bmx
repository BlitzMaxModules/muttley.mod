Rem
'
' muttley.logger - BlitzMax Logging Module
' Copyright (C) 2009 Paul Maskelyne
'
' This software is licensed under the terms of the Artistic
' License version 2.0.
'
' For full license details, please read the file 'artistic-2_0.txt' 
' included with this distribution, or see
' http://www.perlfoundation.org/legal/licenses/artistic-2_0.html
'	
EndRem

Rem
bbdoc: This class represents an actual log message that is sent to all log writers
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
	about: The timestamp is in RFC 5424 compatible format, for example:
	<pre>
	2009-09-27T12:21:57+01:00
	2007-02-13T08:09:10-05:00
	</pre>
	EndRem
	Field timestamp:String

End Type
