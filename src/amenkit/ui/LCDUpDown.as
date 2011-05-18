package amenkit.ui
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	
	public class LCDUpDown extends Sprite
	{
		[Embed(source="../../../assets/fonts/Digit.TTF", embedAsCFF="false", fontName="Digit", mimeType="application/x-font")] 
		public static var fontStr:String;
		
		[Embed(source="../../../assets/fonts/Architek.ttf", embedAsCFF="false", fontName="Architek", mimeType="application/x-font")] 
		public static var fontStrStr:String;
		
		private var _textbox:TextField;
		
		public var upButton:Sprite;
		public var downButton:Sprite;
		
		public function LCDUpDown(newLabel:String = "")
		{
			var bgDsiplay:Sprite = new Sprite();
			bgDsiplay.x = 0;
			bgDsiplay.y = 32;
			bgDsiplay.graphics.beginFill(0x002424);
			bgDsiplay.graphics.drawRoundRect(2.0, 2.0, 188.0, 60.0, 12, 12);
			bgDsiplay.graphics.endFill();
			bgDsiplay.graphics.lineStyle(1, 0xD1E7E1, 0.5);
			bgDsiplay.graphics.moveTo(96, 32);
			bgDsiplay.graphics.lineTo(188, 32);
			bgDsiplay.graphics.lineStyle(2, 0xD1E7E1, 1);
			bgDsiplay.graphics.moveTo(108, 22);
			bgDsiplay.graphics.lineTo(142, 10);
			bgDsiplay.graphics.lineTo(178, 22);
			bgDsiplay.graphics.moveTo(108, 42);
			bgDsiplay.graphics.lineTo(142, 54);
			bgDsiplay.graphics.lineTo(178, 42);
			addChild(bgDsiplay);
			
			var formatLabel:TextFormat = new TextFormat();
			formatLabel.font = "Architek";
			formatLabel.color = 0xD1E7E1;
			formatLabel.size = 32;
			formatLabel.align = "left";
			formatLabel.letterSpacing = 0;
			
			var textlabel:TextField = new TextField();
			textlabel.defaultTextFormat = formatLabel;
			textlabel.embedFonts = true;
			textlabel.selectable = false;
			textlabel.width = 192;
			textlabel.text = newLabel;
			textlabel.x = 0;
			textlabel.y = -6;
			addChild(textlabel);

			var format:TextFormat = new TextFormat();
			format.font = "Digit";
			format.color = 0xD1E7E1;
			format.size = 48;
			format.align = "right";
			format.letterSpacing = 0;
			format.rightMargin = 8;
			
			_textbox = new TextField();
			_textbox.embedFonts = true;
			_textbox.selectable = false;
			_textbox.width = 96;
			_textbox.autoSize = TextFieldAutoSize.RIGHT;
			_textbox.antiAliasType = AntiAliasType.ADVANCED;
			_textbox.defaultTextFormat = format;
			_textbox.text = "240";
			_textbox.x = 0;
			_textbox.y = 36;
			addChild(_textbox);
			
			upButton = new Sprite();
			upButton.graphics.beginFill(0x00FF00, 0);
			upButton.graphics.drawRect(0,0,96,32);
			upButton.graphics.endFill();
			upButton.x = 96;
			upButton.y = 32;
			upButton.buttonMode = true;
			addChild(upButton);

			downButton = new Sprite();
			downButton.graphics.beginFill(0xFF0000, 0);
			downButton.graphics.drawRect(0,0,96,32);
			downButton.graphics.endFill();
			downButton.x = 96;
			downButton.y = 64;
			downButton.buttonMode = true;
			addChild(downButton);			
		}
		
		public function display(newNumber:Number):void{
			_textbox.text = String(newNumber);
		}
	}
}