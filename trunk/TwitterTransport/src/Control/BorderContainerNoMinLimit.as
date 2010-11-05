package Control
{
	import spark.components.BorderContainer;

	public class BorderContainerNoMinLimit extends BorderContainer
	{
		public function BorderContainerNoMinLimit()
		{
			super();
			super.minWidth = 0;
			super.minHeight = 0;
		}
	}
}