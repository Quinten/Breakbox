package amenkit.drums
{
	import flash.utils.ByteArray;
	
	import tonfall.core.Memory;
	import tonfall.core.Signal;
	import tonfall.format.wav.WAVDecoder;
	
	public class SampleBuffer
	{
			private var _first:Signal;
			private var _length:int;
			
			private var _vector: Vector.<Signal>;
			
			public function SampleBuffer(bytes:ByteArray)
			{
				init(new WAVDecoder(bytes));
			}
			
			public function get length():int
			{
				return _length;
			}
			
			public function get first():Signal
			{
				return _first;
			}
			
			private function init(wavDecoder:WAVDecoder): void
			{
				var numSignals:int = wavDecoder.numSamples;
				var head:Signal;
				var tail:Signal;
				
				Memory.position = 0;
				wavDecoder.extract(Memory, numSignals, 0);
				Memory.position = 0;
				
				_vector = new Vector.<Signal>(numSignals, true);
				
				_vector[0] = new Signal();
				_vector[0].l = Memory.readFloat();
				_vector[0].r = Memory.readFloat();
				
				tail = head = _vector[0];
				
				for(var i:int = 1; i < numSignals; ++i)
				{
					_vector[i] = new Signal();
					_vector[i].l = Memory.readFloat();
					_vector[i].r = Memory.readFloat();
					
					tail = tail.next = _vector[i];
				}
				
				_first = tail.next = head;
				
				_length = numSignals;
			}
		}
	}