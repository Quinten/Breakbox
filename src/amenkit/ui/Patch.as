package amenkit.ui
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Patch extends Sprite 
	{
		private var _u:int;
		private var _v:int;
		private var _selected:Boolean;
		
		private var gradientMat:Matrix = new Matrix();
	
		public function Patch(u:int, v:int)
		{
			_u = u;
			_v = v;
			
			gradientMat.createGradientBox(128,128,0,-32,-32);
			update();
			
			buttonMode = true;
		}
	
		public function get u():int
		{
			return _u;
		}
	
		public function get v():int
		{
			return _v;
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
				graphics.beginGradientFill(GradientType.RADIAL,[0xD1E7E1, 0x315B50],[1.0,1.0],[10,205],gradientMat);
			}else{
				graphics.beginFill(0x315B50);
			}
			graphics.drawRoundRect(2.0, 2.0, 60.0, 60.0, 12, 12);
			graphics.endFill();
		}
	}
}