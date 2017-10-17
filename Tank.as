package 
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	

	public class Tank extends MovieClip
	{			
		public var st:Number=1.5;//скорость танка
		public var svt:Number=1.2;//вращение танка (угол в град)
		public var svtR:Number = svt* Math.PI / 180; // вращение танка в рад
		public var svb:Number=0.7;//вращение башни
		public var ug_t_rad:Number;// угол поворота танка в радианах
		public var ug_t_gr:Number;// угол поворота танка в градусах
		public var ug_b_gr:Number = 0;// угол поворота башни
		public var ug_Click:Number;// угол щелчка (кончика) мыши без учета поворота танка
		public var zaryageno:Boolean = true;
		public var skorostPuli:int = 5;
		public var cpX: Number; // центральная точка вращения танка
		public var cpY: Number; // центральная точка вращения танка
		public var radiusCP:Number; //расстояние до точки вращения
	}
}