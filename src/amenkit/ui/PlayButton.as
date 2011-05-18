package amenkit.ui
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class PlayButton extends Sprite 
	{
		private var _selected:Boolean;
		
		private var gradientMat:Matrix = new Matrix();
	
		public function PlayButton()
		{
			gradientMat.createGradientBox(128,128,0,-32,-32);
			update();
			
			buttonMode = true;
		}
	
		public function get selected():Boolean
		{
			return _selected;
		}
	
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			update();
		}
		
		private function update():void
		{
			graphics.clear();
			if(_selected){
				graphics.lineStyle();
				graphics.beginGradientFill(GradientType.RADIAL,[0xD1E7E1, 0x315B50],[1.0,1.0],[10,205],gradientMat);
				graphics.drawRoundRect(2.0, 2.0, 60.0, 60.0, 12, 12);
				graphics.endFill();
				graphics.lineStyle(3, 0xffffff, 1);
				graphics.moveTo(16, 16);
				graphics.lineTo(16, 48);
				graphics.lineTo(48, 32);
				graphics.lineTo(16, 16);
			}else{
				graphics.lineStyle();
				graphics.beginFill(0x315B50);
				graphics.drawRoundRect(2.0, 2.0, 60.0, 60.0, 12, 12);
				graphics.endFill();
				graphics.lineStyle(3, 0xD1E7E1, 1);
				graphics.moveTo(16, 16);
				graphics.lineTo(16, 48);
				graphics.lineTo(48, 32);
				graphics.lineTo(16, 16);
			}
		}
	}
}