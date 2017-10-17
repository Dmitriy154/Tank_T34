package 
{
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.sensors.Accelerometer;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;

	public class Game extends Sprite
	{
		static var mirX:		Number = 0; //верхний угол видимого мира
		static var mirY:		Number = 0;
		
		var dx:			Number;
		var dy:			Number;
		var tanksaveX:	Number;
		var tanksaveY:	Number;
		var cos:		Number;
		var sin:		Number;
		var fon:		Fon;
		
		var fonO:		FonO;
		
		var tank:		Tank;
		var zonaX:Boolean = false;
		var zonaY:Boolean = false;


		public function Game()
		{
			fon = new Fon;
			tank = new Tank;
			fonO = new FonO;
			
			addChild(fon);
			addChild(tank);
			addChild(fonO);
			
			tank.radiusCP = Main.stageW*.1;
			tank.x = Main.stageW * .5 - tank.radiusCP; //радиус 0.1
			tank.y = Main.stageH * .5;
			
			tank.cpX = (Main.stageW*.5 + mirX); //центр точки вращ.танка
			tank.cpY = (Main.stageH*.5 + mirY);
			
			addEventListener (Event.ENTER_FRAME, ef);
		}

		function ef(e:Event):void
		{
			//расчет поворота башни
			tank.ug_Click = Math.atan2((Main.stageM.mouseY - tank.y),(Main.stageM.mouseX - tank.x)) * 180 / Math.PI;
			tank.ug_b_gr =  -  tank.bashnya.rotation - tank.rotation + tank.ug_Click;
			if (tank.ug_b_gr > 180)
			{
				tank.ug_b_gr -=  360;
			}
			if (tank.ug_b_gr < -180)
			{
				tank.ug_b_gr +=  360;
			}

			if (Math.abs(tank.ug_b_gr) <= tank.svb)
			{
				tank.ug_b_gr = tank.ug_Click;
			}
			else if (tank.ug_b_gr >= 0)
			{
				tank.bashnya.rotation +=  tank.svb;
			}
			else
			{
				tank.bashnya.rotation -=  tank.svb;
			}
			
			//КАКАЯ-ТО КЛАВИША НАЖАТА
			if (Key.isSomethingPressed()) 
			{
				//ПОВОРОТ ТАНКА
				tank.ug_t_rad = tank.rotation * Math.PI / 180;
				cos = Math.cos(tank.ug_t_rad);
				sin = Math.sin(tank.ug_t_rad);
				
				//ЗАПОМИНАЕМ ПРЕДЫДУЩЕЕ ПОЛОЖЕНИЕ ТАНКА (для поворотов)
				tanksaveX = tank.x;
				tanksaveY = tank.y;
				
				//ОБЩАЯ ЦЕНТРАЛЬНАЯ ЗОНА
				if (mirX >= 0 && mirY >= 0)
				{
					zonaX = zonaY = false;
					
					tank.x = Main.stageW *(0.5 - 0.1 * cos);
					tank.y = Main.stageH *(0.5 - 0.1 * sin);				
					
					dx = tank.x - tanksaveX; //МОЖНО ВЫНЕСТИ?!
					dy = tank.y - tanksaveY;	
					
					strelki(tank);
					
					fon.dr(dx,dy);
					fonO.x += dx;
					fonO.y += dy;
					
					mirX -= dx;
					mirY -= dy;
				} else {

					//ЗОНА ХY
					if (mirX < 0 && mirY <0)
					{
						zonaX = zonaY = true;
						dx = dy = 0; // можно удалить потом
						strelki(tank);
						
						tank.x -= dx;
						tank.y -= dy;
						
						tank.cpX = tank.x + tank.radiusCP * cos;
						tank.cpY = tank.y + tank.radiusCP * sin;				
						
						if(tank.cpX >= Main.stageW *.5)
						{ 
							tank.cpX =  Main.stageW *.5;
							mirX = 0;
						}
						
						if(tank.cpY >= Main.stageH *.5)
						{ 
							tank.cpY =  Main.stageH *.5;
							mirY = 0;
						}
					}
	
					//ЗОНА Х
					if (mirX < 0 && mirY >= 0)
					{
						zonaX = true;
						dx = dy = 0; // можно удалить потом
						tank.y = Main.stageH *(0.5 - 0.1 * sin);
					
						dy = tank.y - tanksaveY;
						strelki(tank);
						
						tank.x -= dx;
	
						fon.dr(0,dy);
						fonO.y += dy;
						mirY -= dy;
						
						tank.cpX = tank.x + tank.radiusCP * cos;
					
						if(tank.cpX >= Main.stageW *.5)
						{ 
							tank.cpX =  Main.stageW *.5;
							mirX = 0;
						}
					}
				
					//ЗОНА Y
					if (mirY < 0 && mirX >= 0)
					{
						zonaY = true;
						dx = dy = 0; // можно удалить потом
						tank.x = Main.stageW *(0.5 - 0.1 * cos);
				
						dx = tank.x - tanksaveX;
						strelki(tank);
					
						tank.y -= dy;

						fon.dr(dx,0);
						fonO.x += dx;
						mirX -= dx;
					
						tank.cpY = tank.y + tank.radiusCP * sin; 
					
						if(tank.cpY >= Main.stageH *.5)
						{ 
							tank.cpY =  Main.stageH *.5;
							mirY = 0;
						}
					}
					
				}
			}
		}

		function strelki(tank:Tank):void
		{
			switch (true)
			{
				case Key.isDown(Keyboard.UP) && Key.isDown(Keyboard.LEFT) :
					dx +=   -  tank.st * cos;
					dy +=   -  tank.st * sin;
					tank.rotation -=  tank.svt;
					break;
				case Key.isDown(Keyboard.UP) && Key.isDown(Keyboard.RIGHT) :
					dx +=   -  tank.st * cos;
					dy +=   -  tank.st * sin;
					tank.rotation +=  tank.svt;
					break;
				case Key.isDown(Keyboard.DOWN) && Key.isDown(Keyboard.LEFT) :
					dx +=  tank.st * cos;
					dy +=  tank.st * sin;
					tank.rotation +=  tank.svt;
					break;
				case Key.isDown(Keyboard.DOWN) && Key.isDown(Keyboard.RIGHT) :
					dx +=  tank.st * cos;
					dy +=  tank.st * sin;
					tank.rotation -=  tank.svt;
					break;
				case Key.isDown(Keyboard.UP) :
					dx =  -  tank.st * cos;
					dy =  -  tank.st * sin;
					break;
				case Key.isDown(Keyboard.DOWN) :
					dx = tank.st * cos;
					dy = tank.st * sin;
					break;
				case Key.isDown(Keyboard.LEFT) :
					tank.rotation -=  tank.svt;
					break;
				case Key.isDown(Keyboard.RIGHT) :
					tank.rotation +=  tank.svt;
					break;
				default :
					return;
			}
		}
	}
}