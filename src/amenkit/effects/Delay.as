package amenkit.effects
{
	import tonfall.core.BlockInfo;
	import tonfall.core.Processor;
	import tonfall.core.Signal;
	import tonfall.core.SignalBuffer;
	import tonfall.core.samplingRate;
	import tonfall.core.TimeConversion;
	import tonfall.core.Engine;

	public final class Delay extends Processor
	{	
		public const output:SignalBuffer = new SignalBuffer();
		
		private var _input: SignalBuffer;
		
		private var _buffer:DelayBuffer;
		private var _bufferIndex: int;
		private var _bufferSize: int;
		
		private var _wet: Number = 0.5;
		private var _dry: Number = 0.8;
		private var _feedback: Number = 4;
		
		private var _steps:int = 7;
		private var _time:int = 16;
		
		public function Delay()
		{
			_bufferSize = (TimeConversion.barsToMillis(_steps/_time, 50)) / 1000.0 * samplingRate; // the maximum length of the delay buffer(7 steps at 50 bpm)
			_buffer = new DelayBuffer(_bufferSize);
			_bufferIndex = 0;
		}
		
		override public function process( info: BlockInfo ) : void
		{
			var dly: Signal = _buffer.current;
			var inp: Signal = _input.current;
			var out: Signal = output.current;
			
			var readL: Number;
			var readR: Number;
			
			for(var i:int = 0 ; i < info.numSignals; ++i)
			{
				readL = dly.l;
				readR = dly.r;
				
				dly.l = inp.l + readL * _feedback / 10;
				dly.r = inp.r + readR * _feedback / 10;

				out.l = inp.l * _dry + dly.l * _wet;
				out.r = inp.r * _dry + dly.r * _wet;
				
				dly = dly.next;
				inp = inp.next;
				out = out.next;
			}

			_buffer.current = dly.next;
			 output.advancePointer(info.numSignals);
		}
		
		public function get steps():int
		{
			return _steps;
		}
		
		public function set steps(value:int):void
		{
			_steps = value;
			_buffer.length = (TimeConversion.barsToMillis(_steps/_time, engine.bpm)) / 1000.0 * samplingRate;
		}

		public function get input() : SignalBuffer
		{
			return _input;
		}

		public function set input( value: SignalBuffer ) : void
		{
			_input = value;
		}

		public function get wet() : Number
		{
			return _wet;
		}

		public function set wet( value: Number ) : void
		{
			_wet = value;
		}

		public function get dry() : Number
		{
			return _dry;
		}

		public function set dry( value: Number ) : void
		{
			_dry = value;
		}

		public function get feedback() : Number
		{
			return _feedback;
		}

		public function set feedback( value: Number ) : void
		{
			_feedback = value;
		}
	}
}