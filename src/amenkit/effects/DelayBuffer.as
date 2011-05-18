package amenkit.effects
{
	import tonfall.core.Driver;
	import tonfall.core.Signal;
	
	/**
	 * 
	 * a stretchable signalbuffer
	 * 
	 */
	
	public final class DelayBuffer
	{
		private var _first:Signal;
		private var _current:Signal;
		private var _length:int;
		private var _totalLength:int;
		
		private var _vector:Vector.<Signal>;
		private var _ends:Vector.<int> = new Vector.<int>();
		
		public function DelayBuffer(bufferSize:int = 0)
		{
			init(0 >= bufferSize ? Driver.BLOCK_SIZE : bufferSize);
		}
		
		public function set length(value:int):void
		{
			_length = value;
			var i:int = _length - 1;
			_vector[i].next = _first;
			_ends.push(i);
			_ends.forEach(restore);
			var newEnds:Vector.<int> = _ends.filter(biggerThenLenght);
			_ends = newEnds;
		}
		
		private function restore(item:*, index:int, vector:Vector.<int>):void
		{
			if(item < _length - 1){
				if(item != _totalLength - 1){
					_vector[item].next = _vector[item + 1];
				}else{
					_vector[item].next = _first;
				}
			}	
		}
		
		private function biggerThenLenght(item:*, index:int, vector:Vector.<int>):Boolean
		{
			if(item >= _length - 1){
				return true;
			}else{
				return false;
			}
		}
		
		public function get current():Signal
		{
			return _current;
		}
		
		public function set current(newCurrent:Signal):void
		{
			_current = newCurrent;
		}
		
		public function zero(num:int):void
		{
			var signal: Signal = _current;
			
			for( var i: int = 0 ; i < num ; ++i )
			{
				signal.l = signal.r = 0.0;
				
				signal = signal.next;
			}
		}
		
		private function init(bufferSize:int):void
		{
			var head: Signal;
			var tail:Signal;
			
			_vector = new Vector.<Signal>(bufferSize, true);
			tail = head = _vector[0] = new Signal();
			
			for(var i:int = 1; i < bufferSize; ++i)
			{
				tail = tail.next = _vector[i] = new Signal();
			}
			
			_current = tail.next = head;
			_first = _current
			
			_length = bufferSize;
			_totalLength = _length;
		}
	}
}