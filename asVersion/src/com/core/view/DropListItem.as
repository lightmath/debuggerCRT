package com.core.view
{
	import com.core.view.event.DropEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 * 
	 * @author LC
	 */
	public class DropListItem extends Sprite
	{
		public var index:uint;
		
		private var itemBtn:Sprite;
		
		public function DropListItem(desc:String, i:uint)
		{
			super();
			index = i;
			itemBtn = createBtn(desc);
			itemBtn.addEventListener(MouseEvent.CLICK, onClickHandle);
			addChild(itemBtn);
		}
		
		private function onClickHandle(e:MouseEvent):void
		{
			var event:DropEvent = new DropEvent(DropEvent.ITEM_INDEX_CHANGE, true);
			event.data = index;
			dispatchEvent(event);
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
			btn.filters = [new GlowFilter(0x0,1,3,3)];
			return btn;
		}
	}
}