package 
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Fon extends Shape
	{
		private var bmd:BitmapData;
		var matrix:Matrix;

		public function Fon()
		{
			matrix = new Matrix();
			bmd = new BitmapData(Main.stageW,Main.stageH);
			bmd.noise(10, 110, 210, BitmapDataChannel.GREEN, false);
			dr();//????
		}

		function dr(tx:Number = 0, ty:Number = 0):void
		{	
				graphics.clear();
				matrix.translate(tx, ty);
				graphics.beginBitmapFill(bmd, matrix, true, true);
				graphics.drawRect(0, 0, Main.stageW, Main.stageH);
				graphics.endFill();
		}
	}
}