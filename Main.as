package 
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import utils.SWFProfiler;

	public class Main extends MovieClip
	{
		var menuGame:	MenuGame;
		var game: 		Game;
		static var stageM;
		static var stageW:int;
		static var stageH:int;
		static var stageCenterX:int;
		static var stageCenterY:int;
		
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
      		stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			
			stageM = stage;
			stageW = stage.stageWidth;
			stageH = stage.stageHeight;
			stageCenterX = stageW/2;
			stageCenterY = stageH/2;
			
			Key.initialize(stage);
			
			startMenu();   				//начало игры через меню
			startGame();
			
			SWFProfiler.init(stage, this); 	//подключение статистики
		}
		
		public function startMenu():void
		{
			menuGame = new MenuGame();
			menuGame.varMain(this);
			addChild(menuGame);
		}
		
		
		public function startGame():void 
		{
			game = new Game;
			addChild (game);
		}

	}
}