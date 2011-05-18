package amenkit.drums
{
	import tonfall.core.Engine;
	import tonfall.core.Signal;
	import tonfall.core.SignalBuffer;
	import tonfall.core.TimeEvent;
	import tonfall.core.TimeEventNote;
	import tonfall.poly.IPolySynthVoice;

	public final class DrumVoice implements IPolySynthVoice
	{
	private const engine:Engine = Engine.getInstance();
	private var _position:Number;
	private var _end:int;
	private var note:int = 0;
	private var sample:Signal;

	public function DrumVoice(){}
	
	public function start(event:TimeEvent):void
	{
		note = TimeEventNote(event).note;
		_position = 0;
		_end = AmenKitSamples.LIST[note].length;
		sample = AmenKitSamples.LIST[note].first;
	}

	public function stop():void{}

	public function processAdd(current:Signal, numSignals:int):Boolean
	{
		for(var i:int = 0; i < numSignals; ++i)
		{
			_position += 1;
			if(_position >= _end)
				return true;
			current.l += sample.l;
			current.r += sample.r;
			current = current.next;
			sample = sample.next;
		}
		return false;
	}

	public function dispose():void{}
}

}