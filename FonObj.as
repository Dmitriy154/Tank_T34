package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	public class FonObj extends Sprite
	{
		var shar = new Shar();
		var derB = new Les();
		var rect:Shape = new Shape();
		var fonObjW:int = 800;
		var fonObjH:int = 800;

		public function FonObj()
		{
			/*this.graphics.lineStyle(3);
			this.graphics.drawRect(0,0,fonObjW, fonObjH);
			trace(this.width,this.height);*/
			derB.x = 300;
			derB.y = 250;
			shar.x = 400;
			shar.y = 200;
			//задать условие в случае выхода из зоны rect.clear()
			rect.x = 0;
			rect.y = 0;
			rect.graphics.lineStyle(8);
			rect.graphics.drawRect(Game.mirX,Game.mirY,Level.mirW,Level.mirH);
	
			this.addChild(derB);
			this.addChild(shar);
			this.addChild(rect);
		}
		
		public function moveObj(tx:Number = 0, ty:Number = 0):void
		{
			this.x += tx; 
			this.y += ty;
			
		}



	}

}