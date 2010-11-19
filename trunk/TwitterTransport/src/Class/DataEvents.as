package Class
{
	import mx.events.FlexEvent;

	public class DataEvents extends FlexEvent
	{
		public var eventInfo:String; //自定义的事件信息
		public var result:Object; //数据返回结果
		public var tag:Object;

		public function DataEvents(s:String, ret:Object, bubbles:Boolean = false)
		{
			super(s, bubbles); //如果在构造时不设bubbles，默认是false，也就是不能传递的。
			eventInfo = "这个事件是:" + s;
			result = ret;
		}
	}
}