package amenkit.ui
{
	import flash.utils.describeType;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	public class Banner extends Sprite
	{
		[Embed(source="../../../assets/fonts/amsterdam.ttf", embedAsCFF="false", fontName="Amsterdam Graffiti", mimeType="application/x-font")] 
		public static var fontStr:String;
		
		public function Banner()
		{     	
			var format:TextFormat = new TextFormat();
			format.font = "Amsterdam Graffiti";
			format.color = 0xD1E7E1;
			format.size = 120;
			format.letterSpacing = 4;
			format.leftMargin = 20;
			
			var textbox:TextField = new TextField();
			textbox.embedFonts = true;
			textbox.selectable = false;
			textbox.autoSize = TextFieldAutoSize.LEFT;
			textbox.antiAliasType = AntiAliasType.ADVANCED;
			textbox.defaultTextFormat = format;
			textbox.text = "BreakBox";
			textbox.x = 44;
			textbox.y = -36;
			addChild(textbox);
		}
	}
}