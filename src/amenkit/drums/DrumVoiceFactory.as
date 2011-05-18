package amenkit.drums
{
	import tonfall.core.TimeEventNote;
	import tonfall.poly.IPolySynthVoice;
	import tonfall.poly.IPolySynthVoiceFactory;

	public final class DrumVoiceFactory implements IPolySynthVoiceFactory
	{
		public static const INSTANCE: DrumVoiceFactory = new DrumVoiceFactory();
		
		public function create(event:TimeEventNote):IPolySynthVoice
		{
			return new DrumVoice();
		}
	}
}
