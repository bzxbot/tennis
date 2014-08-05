package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author  Bernardo
	 */
	public class Ball extends Sprite
	{
		private var angle: int;
		public var speed: int;
		
		public var xIncrement: int = 1;
		public var yIncrement: int = 1;
		
		public function Ball()
		{
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
			
			//angle = (Math.random() * 178 + 1) * (Math.PI / 180);
			angle = 0;
			speed = 10;

			xIncrement += Math.sin(angle) * speed;
			yIncrement += Math.cos(angle) * speed;
		}
		
		public function update():void
		{
			this.x += xIncrement;
			this.y += yIncrement;
		}
		
		public function paddleHit(paddleCenter:int, paddleHeight:int):void
		{
			var adjustValue:Number = this.speed / paddleHeight * Math.sqrt(2);
			var yIncrement:Number = (this.y - paddleCenter) * adjustValue;
			this.yIncrement = yIncrement != 0 ? yIncrement : 1;
			var xIncrement:Number = Math.sqrt(Math.pow(this.speed, 2) -  Math.pow(this.yIncrement, 2));
			this.xIncrement = this.xIncrement < 0 ? xIncrement : -xIncrement;
		}
		
		public function horizontalHit():void
		{
			xIncrement = -xIncrement;
		}
		
		public function verticalHit():void
		{
			yIncrement = -yIncrement;
		}
	}
	
}