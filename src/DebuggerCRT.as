package
{
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	
	
	/**
	 * 外部调试器
	 * @author LC
	 */
	[SWF(width='400', height='500', backgroundColor='#FFFFFF', frameRate="24")]
	public class DebuggerCRT extends Sprite
	{
		private const CONNECT:String = "lc_connection";
		private var conn:LocalConnection;
		private var textArea:TextField;
		
		public function DebuggerCRT()
		{
			init();
			conn = new LocalConnection();
			conn.client = this;
			try {
				conn.connect(CONNECT);
			} catch (error:ArgumentError) {
				trace("Can't connect...the connection name is already being used by another SWF");
			}
		}
		
		private function init():void
		{
			textArea = new TextField();
			textArea.width = 300;
			textArea.height = 360;
			textArea.border = true;
			textArea.wordWrap = true;
			textArea.multiline = true;
			textArea.x = 50;
			textArea.y = 120;
			addChild(textArea);
		}
		
		public function onData(level:uint, msg:String):void
		{
			textArea.htmlText += "<br><font face='SimSun' size='14' color='#FF0000'>"+msg+"</font>";
			
			textArea.scrollV = textArea.maxScrollV;
		}
		
	}
}