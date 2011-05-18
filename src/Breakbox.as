package
{
	import amenkit.drums.DrumSequencer;
	import amenkit.drums.DrumVoiceFactory;
	import amenkit.effects.Delay;
	import amenkit.ui.Banner;
	import amenkit.ui.LCDUpDown;
	import amenkit.ui.LoopsLabel;
	import amenkit.ui.Patch;
	import amenkit.ui.PlayButton;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	
	import net.hires.debug.Stats;
	
	import tonfall.core.Driver;
	import tonfall.core.Engine;
	import tonfall.core.Memory;
	import tonfall.core.TimeConversion;
	import tonfall.display.AbstractApplication;
	import tonfall.poly.PolySynth;

	[SWF(backgroundColor="#203C34", frameRate="31", width="1024", height="768")]
	public final class Breakbox extends Sprite
	{
		protected const driver:Driver = Driver.getInstance();
		protected const engine:Engine = Engine.getInstance();
		
		private const sequencer:DrumSequencer = new DrumSequencer();
		private const generator:PolySynth = new PolySynth(DrumVoiceFactory.INSTANCE);
		private var delay:Delay;
		
		private var stepLCD:LCDUpDown;
		private var bpmLCD:LCDUpDown;
		private var feedbackLCD:LCDUpDown;
		private var playButton:PlayButton;
		private var patchContainer:Sprite;
		private var loopPatchContainer:Sprite;
		
		public function Breakbox()
		{
			//Memory.length = Driver.BLOCK_SIZE << 3; //i dont think it is necessary to prallocate memeory cause i think it is already used before the constructor is called			
			driver.engine = engine;
			setTimeout(driver.init, 100);
			
			initUI();
			initAudio();
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, appDeactivate);
			addEventListener(Event.ADDED_TO_STAGE, stageReady);
		}
		
		public function appDeactivate(e:Event):void
		{
			if (playButton.selected) {
				playButton.selected = false;
				driver.running = false;
			}
		}

		private function initAudio() : void
		{
			engine.bpm = 160;
			bpmLCD.display(engine.bpm);
			
			delay = new Delay();
			delay.steps = 3;
			stepLCD.display(delay.steps);
			feedbackLCD.display(delay.feedback);
			
			engine.processors.push(sequencer);
			engine.processors.push(generator);
			engine.processors.push(delay);

			delay.input = generator.output;
			sequencer.receiver = generator;
			engine.input = delay.output;
			//engine.input = generator.output; //bypass delay
		}

		private function initUI() : void
		{
			addChild(new Banner());
			addChild(new LoopsLabel());
			
			bpmLCD = new LCDUpDown("bpm");
			bpmLCD.x = 0;
			bpmLCD.y = 64;
			addChild(bpmLCD);
			
			bpmLCD.upButton.addEventListener(MouseEvent.CLICK, bpmUp);
			bpmLCD.downButton.addEventListener(MouseEvent.CLICK, bpmDown);
			
			stepLCD = new LCDUpDown("delay :steps");
			stepLCD.x = 0;
			stepLCD.y = 160;
			addChild(stepLCD);
			
			stepLCD.upButton.addEventListener(MouseEvent.CLICK, stepUp);
			stepLCD.downButton.addEventListener(MouseEvent.CLICK, stepDown);
			
			feedbackLCD = new LCDUpDown(":feedback");
			feedbackLCD.x = 192;
			feedbackLCD.y = 160;
			addChild(feedbackLCD);
			
			feedbackLCD.upButton.addEventListener(MouseEvent.CLICK, feedbackUp);
			feedbackLCD.downButton.addEventListener(MouseEvent.CLICK, feedbackDown);
			
			
			playButton = new PlayButton();
			//playButton.x = 192;
			playButton.x = 384;
			playButton.y = 96;
			addChild(playButton);
			
			playButton.addEventListener(MouseEvent.CLICK, toggleSequencerPlayingState);
			
			// pattern patches
			patchContainer = new Sprite();
			patchContainer.x = 0;
			//patchContainer.y = 64;
			patchContainer.y = 256;
			addChild(patchContainer);
			for(var u:int = 0; u < 16; ++u)
			{
				for(var v:int = 0; v < 8; ++v)
				{
					var patch: Patch = new Patch(u, v);
					patch.x = u * 64;
					patch.y = v * 64;
					patchContainer.addChild(patch);
				}
			}
			patchContainer.addEventListener(MouseEvent.CLICK, onClickPatch);
			// loop patches
			loopPatchContainer = new Sprite();
			loopPatchContainer.x = 512;
			loopPatchContainer.y = 0;
			addChild(loopPatchContainer);
			var w:int = 0;
			for(var i:int = 0; i < 8; ++i)
			{
				for(var p:int = 0; p < 4; ++p)
				{
					var loopPatch:Patch = new Patch(w, 0);
					loopPatch.x = i * 64;
					loopPatch.y = p * 64;
					loopPatch.selected = (w == sequencer.currentPattern);
					loopPatchContainer.addChild(loopPatch);
					w++;
				}
			}
			loopPatchContainer.addEventListener(MouseEvent.CLICK, onClickLoopPatch);
			
			updatePatches();
			
			addChild(new Stats()); // debugger statistics
		}
		
		private function stageReady(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, stageReady);
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
		}

		private function onClickPatch(e:MouseEvent):void
		{
			var patch:Patch = e.target as Patch;
			if(null != patch){
				patch.selected = !patch.selected;
				sequencer.changePattern(patch.u, patch.v, patch.selected);
			}
		}
		
		private function onClickLoopPatch(e:MouseEvent):void
		{
			var prevLoopPatch:Patch = loopPatchContainer.getChildAt(sequencer.nextPattern) as Patch;
			prevLoopPatch.selected = false;
			
			var loopPatch:Patch = e.target as Patch;
			if(null != loopPatch){
				loopPatch.selected = true;
				sequencer.nextPattern = loopPatch.u;
				trace("next pattern is " + sequencer.nextPattern);
			}
			updatePatches();
		}
		
		public function updatePatches():void
		{
			for(var w:int = 0; w < patchContainer.numChildren; ++w)
			{
				var patch:Patch = patchContainer.getChildAt(w) as Patch;
				if(sequencer.pattern[sequencer.nextPattern][patch.u][patch.v]){
					patch.selected = true;
				}else{
					patch.selected = false;
				}
			}			
		}
		
		private function bpmUp(e:MouseEvent):void
		{
			if(engine.bpm < 240){
				engine.bpm += 1.0;
			}
			delay.steps = delay.steps; //i know, it seems strange, but it has a complex setter
			trace(engine.bpm);
			bpmLCD.display(engine.bpm);
		}
		
		private function bpmDown(e:MouseEvent):void
		{
			if(engine.bpm > 50){
				engine.bpm -= 1.0;
			}
			delay.steps = delay.steps; //i know, it seems strange, but it has a complex setter
			trace(engine.bpm);
			bpmLCD.display(engine.bpm);
		}
		
		private function toggleSequencerPlayingState(e:MouseEvent):void
		{
			playButton.selected = !playButton.selected;
			if(playButton.selected){
				sequencer.currentPattern = sequencer.nextPattern;
				engine.barPosition = 0.0;
				driver.running = true;
			}else{
				driver.running = false;
			}
		}
		
		private function stepUp(e:MouseEvent):void
		{
			if(delay.steps < 7){
				delay.steps += 1;
			}
			stepLCD.display(delay.steps);
		}
		
		private function stepDown(e:MouseEvent):void
		{
			if(delay.steps > 1){
				delay.steps -= 1;
			}
			stepLCD.display(delay.steps);
		}
		
		private function feedbackUp(e:MouseEvent):void
		{
			if(delay.feedback < 10){
				delay.feedback += 1;
			}
			feedbackLCD.display(delay.feedback);
		}
		
		private function feedbackDown(e:MouseEvent):void
		{
			if(delay.feedback > 0){
				delay.feedback -= 1;
			}
			feedbackLCD.display(delay.feedback);
		}
	}
}