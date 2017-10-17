package 
{
	import flash.display.Sprite;

	public class Granica extends Sprite
	{
		var granicaX:Number;
		var granicaY:Number;


		public function granicaDraw(mirX:Number,mirY:Number)
		{
			graphics.clear();
			graphics.moveTo (-mirX,-mirY);
			graphics.lineStyle(8, 0x00ff00);
			graphics.lineTo (-mirX,-mirY+600);
			graphics.moveTo (-mirX,-mirY);
			graphics.lineTo (-mirX+800,-mirY);
			if (mirX <=0) 
			{
				Game.addChildGame(this);
			}
			/*else
			{
				Game.removeChildGame(this);
			}*/
			
		}
		
		public function remove ():void
		{
			
		}
	}
}