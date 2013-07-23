package
{
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 * 外部调试器，显示项目（发送方）中的打印信息
	 * @author LC
	 */
	[SWF(width='400', height='500', backgroundColor='#FFFFFF', frameRate="24")]
	public class DebuggerCRT extends Sprite
	{
		private const CONNECT:String = "_lc_connection";
		private var conn:LocalConnection;
		private var textArea:TextField;
		
		public function DebuggerCRT()
		{
			init();
			conn = new LocalConnection();
			conn.allowDomain("*");
			conn.client = this;
			try {
				conn.connect(CONNECT);
			} catch (error:ArgumentError) {
				trace("Can't connect...the connection name is already being used by another SWF");
			}
		}
		
		private function init():void
		{
			initDesc();
			
			textArea = new TextField();
			textArea.width = 350;
			textArea.height = 360;
			textArea.border = true;
			textArea.wordWrap = true;
			textArea.multiline = true;
			textArea.x = 1;
			textArea.y = 25;
			addChild(textArea);
			printeTime();
		}
		
		public function onData(level:uint, msg:String):void
		{
			printeTime();
			switch(level)
			{
				case 0:
					textArea.htmlText += "<font face='SimHei' size='14' color='#CC00FF'>"+msg+"</font>";
					break;
				case 1:
					textArea.htmlText += "<font face='SimHei' size='14' color='#FF9900'>"+msg+"</font>";
					break;
				case 2:
					textArea.htmlText += "<font face='SimHei' size='14' color='#006600'>"+msg+"</font>";
					break;
				case 3:
					textArea.htmlText += "<font face='SimHei' size='14' color='#FF0000'>"+msg+"</font>";
					break;
			}
			textArea.htmlText += "<br>"
			textArea.scrollV = textArea.maxScrollV;
		}
		
		private function printeTime():void
		{
			var date:Date = new Date();
			var timeStr:String = (date.month+1)+":"+date.date+"--"+date.hours+":"+date.minutes+":"+date.seconds+":"+date.milliseconds;
			textArea.htmlText += "<font face='SimHei' size='12' color='#000099'>"+timeStr+"</font>";
		}
		
		
		private function initDesc():void
		{
			var descTF:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat("SimHei", 16, 0x6699CC,true);
			descTF.mouseEnabled = false;
			descTF.defaultTextFormat = textFormat;
			descTF.text = "Flash调试器v0.01版";
			descTF.width = 200;
			descTF.height = 50;
			addChild(descTF);
			descTF.x = 1;
			descTF.y = 1;
		}
		
	}
}