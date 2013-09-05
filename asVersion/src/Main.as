package
{
	import com.core.data.MessageItem;
	import com.core.view.DropList;
	import com.core.view.event.DropEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.filters.GlowFilter;
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	
	/**
	 * 
	 * @author LC
	 */
	[SWF(width='400', height='500', backgroundColor='#8FB4B1', frameRate='24')]
	public class Main extends Sprite
	{
		private const CONNECT:String = "_authorlcconnection";
		private const PRINTS:Array = ["LC","WLB","CRJ ","YS","ALL"];
		private var conn:LocalConnection;
		private var _messages:Array=[];
		private var _mes:String;
		
		public function Main()
		{
			initUI();
			initConect();
		}
		
		private function initConect():void
		{
			conn = new LocalConnection();
			conn.allowDomain("*");
			conn.client = this;
			try {
				conn.connect(CONNECT);
				var date:Date = new Date();
				var timeStr:String = (date.month+1)+":"+date.date+"--"+date.hours+":"+date.minutes+":"+date.seconds+":"+date.milliseconds;
				textArea.text = "【"+timeStr+"】开始";
			} catch (error:ArgumentError) {
				textArea.text = "Can't connect...the connection name is already being used by another SWF";
				conn.addEventListener(StatusEvent.STATUS,onStatus);
				conn.send(CONNECT,"a");
				return;
			}
			_mes = textArea.text+"<br>";
		}
		
		public function onData(level:uint, msg:String, host:String):void
		{
			var item:MessageItem = new MessageItem(msg, level, host);
			_messages.push(item);
			_mes += item.toString();
			textArea.htmlText = _mes;
			if(_lockFlag==false)
			{
				textArea.scrollV = textArea.maxScrollV;
			}
		}
		
		private function onStatus(e:StatusEvent):void
		{
			conn.removeEventListener(StatusEvent.STATUS,onStatus);
			try
			{
				conn.close();
			}
			catch(e:Error)
			{
				
			}
		}
		
		private function onCopyBtnHandle(e:MouseEvent):void
		{
			System.setClipboard(textArea.text);
		}
		
		private function onClearBtnHandle(e:MouseEvent):void
		{
			textArea.text = "";
			_mes = "";
			_messages.length = 0;
		}
		
		private var _lockFlag:Boolean = false;
		private function onLockHandle(e:MouseEvent):void
		{
			_lockFlag = !_lockFlag;
		}
		
		private var _host:String = "ALL";
		private function onSelectTypeHandle(e:DropEvent):void
		{
			_host = PRINTS[e.data];
			_mes = "";
			
			var item:MessageItem;
			if(_host == "ALL")
			{
				for each(item in _messages)
				{
					_mes += item.toString();
				}
			}
			else
			{
				for each(item in _messages)
				{
					if(_host == item.host)
					{
						_mes += item.toString();
					}
				}
			}
			textArea.htmlText = _mes;
			if(_lockFlag==false)
			{
				textArea.scrollV = textArea.maxScrollV;
			}
		}
		
		private var titleTF:TextField;
		private var textArea:TextField;
		private var copyBtn:Sprite;
		private var clearBtn:Sprite;
		private var lockBtn:Sprite;
		private var dropList:DropList;
		
		private function initUI():void
		{
			titleTF = new TextField();
			titleTF.text = "Flash调试器v0.01版";
			titleTF.width = 145;
			titleTF.height = 24;
			titleTF.mouseEnabled = false;
			var textformat:TextFormat = new TextFormat("Arial", 15, 0x030303,true);
			titleTF.setTextFormat(textformat);
			addChild(titleTF);
			titleTF.x = 10;
			titleTF.y = 13;
			
			textArea = new TextField();
			textArea.width = 386;
			textArea.height = 410;
			textArea.background = true;
			textArea.backgroundColor = 0xFFFFFF;
			textArea.border = true;
			textArea.multiline = true;
			textArea.wordWrap = true;
			textArea.type = TextFieldType.DYNAMIC;
			textArea.text = "123";
			addChild(textArea);
			textArea.x = 7;
			textArea.y = 33;
			
			copyBtn = createBtn("copyAll");
			addChild(copyBtn);
			copyBtn.x = 10;
			copyBtn.y = 460;
			copyBtn.addEventListener(MouseEvent.CLICK, onCopyBtnHandle);
			
			clearBtn = createBtn("clear ");
			addChild(clearBtn);
			clearBtn.x = 100;
			clearBtn.y = 460;
			clearBtn.addEventListener(MouseEvent.CLICK, onClearBtnHandle);
			
			lockBtn = createBtn("lock");
			addChild(lockBtn);
			lockBtn.x = 300;
			lockBtn.y = 460;
			lockBtn.addEventListener(MouseEvent.CLICK, onLockHandle);
			
			dropList = new DropList();
			addChild(dropList);
			dropList.x = 200;
			dropList.y = 460;
			dropList.setListData(PRINTS);
			dropList.addEventListener(DropEvent.ITEM_INDEX_CHANGE, onSelectTypeHandle);
		}
		
		private function createBtn(txt:String):Sprite
		{
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0xFFFFCC,0.8);
			btn.graphics.drawRoundRect(0,0,70,22,5,5);
			btn.graphics.endFill();
			btn.mouseChildren = false;
			btn.buttonMode = true;
			var btnLabel:TextField = new TextField();
			btnLabel.text = txt;
			btnLabel.width = btnLabel.textWidth+5;
			btnLabel.height = btnLabel.textHeight+5;
			var textformat:TextFormat = new TextFormat("Arial", 12, 0x030303,false);
			btnLabel.setTextFormat(textformat);
			btn.addChild(btnLabel);
			btnLabel.x = (70-btnLabel.width)/2;
			btnLabel.y = (22-btnLabel.height)/2;
			btn.filters = [new GlowFilter(0x0,1,2,2)];
			return btn;
		}
		
		
	}
}