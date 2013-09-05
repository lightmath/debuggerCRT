package com.core.view.event
{
	import flash.events.Event;
	
	
	/**
	 * 
	 * @author LC
	 */
	public class DropEvent extends Event
	{
		public static const ITEM_INDEX_CHANGE:String = "itemIndexChange";

		public var data:*;
		
		public function DropEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}