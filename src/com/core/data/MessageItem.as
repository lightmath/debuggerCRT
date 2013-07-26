package com.core.data
{
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;

	public class MessageItem
	{
		
		public var message:String;
		
		public var level:uint;
		
		public function MessageItem(mes:String, lvl:uint)
		{
			message = mes;
			level = lvl;
		}
		
		public function toString():String
		{
			var date:Date = new Date();
			var timeStr:String = (date.month+1)+":"+date.date+"--"+date.hours+":"+date.minutes+":"+date.seconds+":"+date.milliseconds;
			var str:String = "<font face='SimHei' size='12' color='#000099'>"+timeStr+"</font><br>";
			
			switch(level)
			{
				case 0:
					str += "<font face='SimHei' size='14' color='#CC00FF'>"+message+"</font>";
					break;
				case 1:
					str += "<font face='SimHei' size='14' color='#FF9900'>"+message+"</font>";
					break;
				case 2:
					str += "<font face='SimHei' size='14' color='#006600'>"+message+"</font>";
					break;
				case 3:
					str += "<font face='SimHei' size='14' color='#FF0000'>"+message+"</font>";
					break;
			}
			str += "<br>"
			return str;
		}
		
	}
}