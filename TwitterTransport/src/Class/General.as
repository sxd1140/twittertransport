package Class
{
	import spark.filters.DropShadowFilter;

	public final class General
	{
		public function General()
		{
		}

		static public function SetShadow(element:*, blur:int = 10, quality:int = 5, opacity:Number = 0.8, color:Number = 0x0, angle:Number = 45):void
		{
			var filter:DropShadowFilter = new DropShadowFilter;
			filter.blurX = blur;
			filter.blurY = blur;
			filter.quality = quality;
			filter.alpha = opacity;
			filter.angle = angle;
			filter.color = color;
			element.filters = [filter];
		}
	}
}