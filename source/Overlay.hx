package;

import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * Credits: Yoshubs.
 */
class Overlay extends TextField
{
	private var times:Array<Float> = [];
	private var memPeak:Float = 0;

	public function new(x:Float, y:Float, color:Int)
	{
		super();

		this.x = x;
		this.y = x;
		this.autoSize = LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		this.defaultTextFormat = new TextFormat('_sans', 14, 0xFFFFFF);

		addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var now = Timer.stamp();
			times.push(now);
			while (times[0] < now - 1)
				times.shift();

			var currentFrames:Int = times.length;
			if (currentFrames > PreferencesData.framerate)
				currentFrames = PreferencesData.framerate;

			if (currentFrames <= PreferencesData.framerate / 4)
				textColor = 0xFFFF0000;
			else if (currentFrames <= PreferencesData.framerate / 2)
				textColor = 0xffd64400;
			else
				textColor = 0xFFFFFFFF;

			#if cpp
			var mem:Float = cpp.vm.Gc.memInfo64(3);
			#else
			var mem:Float = openfl.system.System.totalMemory;
			#end

			if (mem > memPeak)
				memPeak = mem;

			if (visible)
				text = currentFrames + ' FPS\n' + CoolUtil.getInterval(mem) + ' / ' + CoolUtil.getInterval(memPeak) + '\n';
		});
	}
}
