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
	public class DropList extends Sprite
	{
		
		private var dropBtn:Sprite;
		private var btnLabel:TextField;
		private var list:Sprite;
		
		public function DropList()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = this.mouseEnabled = true;
			initUI();
		}
		
		private function initUI():void
		{
			createBtn("ALL");
			addChild(dropBtn);
			dropBtn.addEventListener(MouseEvent.CLICK, openList);
			list = new Sprite();
			list.addEventListener(DropEvent.ITEM_INDEX_CHANGE, onSelectTypeHandle);
			list.y = dropBtn.height;
		}
		
		private function onSelectTypeHandle(e:DropEvent):void
		{
			btnLabel.text = _listData[e.data];
			removeList();
		}
		
		private function openList(e:MouseEvent):void
		{
			if(list.parent==null)
			{
				addChild(list);
			}
			else
			{
				removeChild(list);
			}
		}
		
		public function removeList():void
		{
			if(list.parent!=null)
			{
				removeChild(list);
			}
		}
		
		private var _listData:Array;
		public function setListData(value:Array):void
		{
			_listData = value;
			var L:uint = value.length;
			for(var i:uint=0;i<L;i++)
			{
				var item:DropListItem = new DropListItem(value[i], i);
				list.addChild(item);
				item.x = item.width;
				item.y = -item.height*(L-i);
			}
		}
		
		private function createBtn(txt:String):void
		{
			dropBtn = new Sprite();
			dropBtn.graphics.beginFill(0xFFFFCC,0.8);
			dropBtn.graphics.drawRoundRect(0,0,70,22,5,5);
			dropBtn.graphics.endFill();
			dropBtn.mouseChildren = false;
			dropBtn.buttonMode = true;
			btnLabel = new TextField();
			btnLabel.text = txt;
			btnLabel.width = btnLabel.textWidth+5;
			btnLabel.height = btnLabel.textHeight+5;
			var textformat:TextFormat = new TextFormat("Arial", 12, 0x030303,false);
			btnLabel.setTextFormat(textformat);
			dropBtn.addChild(btnLabel);
			btnLabel.x = (70-btnLabel.width)/2;
			btnLabel.y = (22-btnLabel.height)/2;
			dropBtn.filters = [new GlowFilter(0x0,1,2,2)];
		}
		
		
	}
}