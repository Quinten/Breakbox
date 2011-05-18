package amenkit.drums
{
	import flash.net.SharedObject;
	
	import tonfall.core.BlockInfo;
	import tonfall.core.Processor;
	import tonfall.core.TimeEventNote;
	
	public final class DrumSequencer extends Processor
	{
		public var storedPattern:SharedObject;
		public var pattern:Array = new Array();
		public var currentPattern:int  = 0;
		public var nextPattern:int = 0;
		
		public var receiver: Processor;
		
		public function DrumSequencer()
		{
			storedPattern = SharedObject.getLocal("psychotic-node");
			if(storedPattern.data.pattern){
				pattern = storedPattern.data.pattern;
			}else{
				for(var p:int = 0; p < 32;++p)
				{
					pattern[p] = new Array();
					for(var i:int = 0 ;i <16;++i)
					{
						pattern[p][i] = new Array();
					}
				}
				storedPattern.data.pattern = pattern;
			}
		}
		
		override public function process(info:BlockInfo):void
		{
			var index:int = int(info.barFrom * 16.0);
			var position:Number = index / 16.0;
			
			while(position < info.barTo)
			{
				if(position >= info.barFrom)
				{
					for(var i:int = 0; i < 8; ++i)
					{
						if(pattern[currentPattern][index%16][i])
						{
							var event: TimeEventNote = new TimeEventNote();
							event.barPosition = position;
							event.note = i;
							event.barDuration = 1.0/16.0;
							receiver.addTimeEvent(event);
						}
					}
				}
				position += 1.0/16.0;
				++index;
				if((index%16) == 0){
					currentPattern = nextPattern;
				}
			}
		}
		
		public function changePattern(u:int, v:int, value:Boolean):void
		{
			pattern[nextPattern][u][v] = value;
			storedPattern.data.pattern = pattern;
			storedPattern.flush();
		}
			
	}
}