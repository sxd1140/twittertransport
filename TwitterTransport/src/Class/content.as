package Class
{
	import com.adobe.serialization.json.JSON;

	import flash.events.Event;
	import flash.events.EventDispatcher;
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

		public function content()
		{
		}

		public function getTwitter(offset:int = 0, limit:int = 10):void
		{
//			, timetick:Number = 0
//			if (timetick == 0)
//			{
//				timetick = new Date().getTime();
//			}
			var urlRequest:URLRequest = new URLRequest;
			urlRequest.url = BaseURL + "get.list";
			urlRequest.data = '{"offset":' + offset + ',"limit":' + limit + '}';
//			urlRequest.data = '{"offset":' + offset + ',"limit":' + limit + ',"timetick":' + timetick + '}';
			urlRequest.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader;
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, OnGetListCompleted_handler);
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
			dispatchEvent(new DataEvents("GetAllListCompleted", ret));
		}

		public function AddTwitter(content:String):void
		{
			var urlRequest:URLRequest = new URLRequest;
			urlRequest.url = BaseURL + "insert.log";
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