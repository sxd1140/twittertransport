package Class
{
	import com.adobe.serialization.json.JSON;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.http.HTTPService;

	public class content extends EventDispatcher
	{
		public var ArticleID:int;
		public var ArticleContent:String;
		public var BrowserAgent:String;
		public var CommentCount:int;
		public var BrowserIP:String;
		public var ArticleTime:int;
		public var State:int;

		private var BaseURL:String = "http://www.sunwenhao.com/t1/index.php/api/";
		private var isUpdate:Boolean;

		public function content()
		{
		}

		public function getTwitter(limit:int = 10, timeStamp:Number = 0,direction:int=1):void
		{
//			if (timeStamp == 0)
//			{
//				timeStamp = new Date().getTime();
//			}
			var urlRequest:URLRequest = new URLRequest;
			urlRequest.url = BaseURL + "get_list";
//			urlRequest.data = '{"offset":' + offset + ',"limit":' + limit + '}';
			if (direction == 0)
			{
//				urlRequest.data = 'limit=' + limit;
				isUpdate = false;
			}
			else
			{
				isUpdate = true;
			}
				urlRequest.data = 'limit=' + limit + '&timetick=' + timeStamp+'&direction='+direction;
//			urlRequest.data = 'limit=' + limit;
			urlRequest.method = URLRequestMethod.POST;

			var urlLoader:URLLoader = new URLLoader;
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, OnGetListCompleted_handler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, OnGetTwitterError_handler);
			urlLoader.load(urlRequest);
		}

		private function OnGetListCompleted_handler(e:Event):void
		{
			var data:Array = JSON.decode(e.currentTarget.data);
			var ret:ArrayCollection = new ArrayCollection;
			for (var i:int = 0; i < data.length; i++)
			{
				var tw:content = new content;
				tw.ArticleContent = data[i].log_content;
				tw.ArticleID = data[i].log_id;
				tw.ArticleTime = data[i].log_time;
				tw.BrowserAgent = data[i].log_agent;
				tw.BrowserIP = data[i].log_ip;
				tw.CommentCount = data[i].log_comment_count;
				tw.State = data[i].log_state;

				ret.addItem(tw);
			}
			if (isUpdate)
			{
				dispatchEvent(new DataEvents("GetUpdateListCompleted", ret));
			}
			else
			{
				dispatchEvent(new DataEvents("GetAllListCompleted", ret));
			}
		}

		private function OnGetTwitterError_handler(event:IOErrorEvent):void
		{

		}

		public function AddTwitter(content:String):void
		{
			var urlRequest:URLRequest = new URLRequest;
			urlRequest.url = BaseURL + "add";
			urlRequest.data = '{"content":"' + content + '","agent":"Powered By Sxd"}';
			urlRequest.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader;
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, OnAddTwitterCompleted_handler);
			urlLoader.load(urlRequest);
		}

		private function OnAddTwitterCompleted_handler(e:Event):void
		{
			var data:Object = JSON.decode(e.currentTarget.data);
			if (data.success == 1)
			{
				dispatchEvent(new Event("AddTwitterSuccess"));
			}
			else
			{
				dispatchEvent(new Event("AddTwitterFaild"));
			}
		}
	}
}