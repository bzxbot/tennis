package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.TextFieldAutoSize;
	
	/**	 
	 * @author  Bernardo
	 */
	public class Game extends Sprite
	{
		private var paddleUp:Boolean;
		private var paddleDown:Boolean;
		private var paddle:Paddle;
		private var ball:Ball;
		private var fps:FPSBox;
		private var startText:TextField;
		private var gameOverText:TextField
		private var retryText:TextField
		
		public function Game() : void
		{
			this.graphics.lineStyle(2, 0x000000);
			this.graphics.drawRect(0, 0, 300, 300);
			
			createStartScreen();
		}
		
		private function createStartScreen():void
		{
			startText = new TextField();
			startText.autoSize = TextFieldAutoSize.CENTER;
			startText.text = 'PRESS S TO START';
			startText.textColor = 0x666666;
			startText.x = stage.stageWidth / 2 - startText.width/2;
			startText.y = stage.stageHeight / 2 - startText.height/2;
			addChild(startText);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startListener);
		}
		
		private function removeStartScreen():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, startListener);
			removeChild(startText);
		}
		
		private function startListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 83)
			{
				removeStartScreen();
				initGame();
			}
		}
		
		private function initGame():void
		{
			fps = new FPSBox();
			addChild(fps);
			
			ball = new Ball();
			ball.x = 150;
			ball.y = 150;
			addChild(ball);
			
			paddle = new Paddle();
			paddle.x = 120;
			addChild(paddle);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function endGame():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			removeChild(ball);
			removeChild(paddle);
			removeChild(fps);
		}
		
		private function gameOver():void
		{
			endGame();
			createRetryScreen();
		}
		
		private function createRetryScreen():void
		{
			gameOverText = new TextField();
			gameOverText.autoSize = TextFieldAutoSize.CENTER;
			gameOverText.text = 'FAIL';
			gameOverText.textColor = 0x666666;
			gameOverText.x = stage.stageWidth / 2 - gameOverText.width/2;
			gameOverText.y = stage.stageHeight / 3 - gameOverText.height/2;
			addChild(gameOverText);
			
			retryText = new TextField();
			retryText.autoSize = TextFieldAutoSize.CENTER;
			retryText.text = 'PRESS R TO RETRY';
			retryText.textColor = 0x666666;
			retryText.x = stage.stageWidth / 2 - retryText.width/2;
			retryText.y = stage.stageHeight / 2 - retryText.height/2;
			addChild(retryText);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, retryListener);
		}
		
		private function removeRetryScreen():void
		{
			removeChild(gameOverText);
			removeChild(retryText);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, retryListener);
		}
		
		private function retryListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 82)
			{
				removeRetryScreen();
				initGame();
			}
		}
				
		private function enterFrame(e:Event):void
		{	
			if (paddleUp)
			{
				paddle.moveUp();
			}
			
			if (paddleDown)
			{
				paddle.moveDown();
			}
			
			if (ball.hitTestObject(paddle))
			{
				ball.paddleHit(paddle.getCenter(), paddle.height);
			}
			
			if (ball.x >= stage.stageWidth)
			{
				ball.horizontalHit();
			}			
			
			if (ball.y >= stage.stageHeight || ball.y <= 0)
			{
				ball.verticalHit();
			}
			
			if (ball.x <= 0)
			{
				gameOver();
			}
			else
			{
				ball.update();	
			}
		}
		
		private function keyDownListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 87)
			{
				paddleUp = true;
			}
			if (e.keyCode == 83)
			{
				paddleDown = true;
			}
		}	
		
		private function keyUpListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 87)
			{
				paddleUp = false;
			}
			if (e.keyCode == 83)
			{
				paddleDown = false;
			}
		}
	}
}