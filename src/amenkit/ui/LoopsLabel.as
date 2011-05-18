package amenkit.ui
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	
	public class LoopsLabel extends Sprite
	{	
		[Embed(source="../../../assets/fonts/Architek.ttf", embedAsCFF="false", fontName="Architek", mimeType="application/x-font")] 
		public static var fontStrStr:String;
		
		public function LoopsLabel()
		{
			this.x = 448;
			var bgDsiplay:Sprite = new Sprite();
			bgDsiplay.x = 52;
			bgDsiplay.y = 0;
			bgDsiplay.graphics.lineStyle(1, 0xD1E7E1, 1);
			bgDsiplay.graphics.moveTo(0, 6);
			bgDsiplay.graphics.lineTo(0, 88);
			bgDsiplay.graphics.moveTo(0, 168);
			bgDsiplay.graphics.lineTo(0, 250);
			addChild(bgDsiplay);
			
			var formatLabel:TextFormat = new TextFormat();
			formatLabel.font = "Architek";
			formatLabel.color = 0xD1E7E1;
			formatLabel.size = 32;
			formatLabel.align = "center";
			formatLabel.letterSpacing = 0;
			
			var textlabel:TextField = new TextField();
			textlabel.defaultTextFormat = formatLabel;
			textlabel.embedFonts = true;
			textlabel.selectable = false;
			textlabel.width = 256;
			textlabel.text = "loops";
			textlabel.x = 30;
			textlabel.y = 256;
			textlabel.rotation = -90;
			addChild(textlabel);			
		}
	}
}