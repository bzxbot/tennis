package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author  Bernardo
	 */
	public class Paddle extends Sprite
	{
		private var up:Boolean;
		private var down:Boolean;
		
		public function Paddle() 
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 10, 60);
			graphics.endFill();
		}
		
		public function moveDown():void
		{
			if (this.y < stage.stageHeight - 60)
			{
				this.y += 10;
			}
		}
		
		public function moveUp():void
		{
			if (this.y != 0)
			{
				this.y -= 10;
			}
		}
				
		public function getCenter():int
		{
			return this.y + 30;
		}
	}	
}