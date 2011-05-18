package amenkit.drums
{	 
	public final class AmenKitSamples
	{
		[Embed(source='../../../assets/sounds/kick.wav', mimeType='application/octet-stream')]
		private static const CLASS_KICK:Class;
		
		[Embed(source='../../../assets/sounds/semi_kick.wav', mimeType='application/octet-stream')]
		private static const CLASS_SEMI_KICK:Class;
		
		[Embed(source='../../../assets/sounds/snare.wav',mimeType='application/octet-stream')]
		private static const CLASS_SNARE:Class;
		
		[Embed(source='../../../assets/sounds/semi_snare.wav',mimeType='application/octet-stream')]
		private static const CLASS_SEMI_SNARE:Class;
		
		[Embed(source='../../../assets/sounds/closed_hi_hat.wav', mimeType='application/octet-stream')]
		private static const CLASS_CLOSED_HI_HAT:Class;
			
		[Embed(source='../../../assets/sounds/open_hi_hat.wav', mimeType='application/octet-stream')]
		private static const CLASS_OPEN_HI_HAT:Class;
		
		[Embed(source='../../../assets/sounds/crash.wav', mimeType='application/octet-stream')]
		private static const CLASS_CRASH:Class;
		
		[Embed(source='../../../assets/sounds/crash_snare.wav', mimeType='application/octet-stream')]
		private static const CLASS_CRASH_SNARE:Class;

		public static const KICK:SampleBuffer = new SampleBuffer(new CLASS_KICK());
		public static const SEMI_KICK:SampleBuffer = new SampleBuffer(new CLASS_SEMI_KICK());
		public static const SNARE:SampleBuffer = new SampleBuffer(new CLASS_SNARE());
		public static const SEMI_SNARE:SampleBuffer = new SampleBuffer(new CLASS_SEMI_SNARE());
		public static const CLOSED_HI_HAT:SampleBuffer = new SampleBuffer(new CLASS_CLOSED_HI_HAT());
		public static const OPEN_HI_HAT:SampleBuffer = new SampleBuffer(new CLASS_OPEN_HI_HAT());
		public static const CRASH:SampleBuffer = new SampleBuffer(new CLASS_CRASH());
		public static const CRASH_SNARE:SampleBuffer = new SampleBuffer(new CLASS_CRASH_SNARE());
		
		public static const LIST: Vector.<SampleBuffer> = new Vector.<SampleBuffer>(8, true);
		
		LIST[0] = KICK;
		LIST[1] = SEMI_KICK;
		LIST[2] = SNARE;
		LIST[3] = SEMI_SNARE;
		LIST[4] = CLOSED_HI_HAT;
		LIST[5] = OPEN_HI_HAT;
		LIST[6] = CRASH;
		LIST[7] = CRASH_SNARE;
	}
}