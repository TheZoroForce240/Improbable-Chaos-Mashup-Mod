import openfl.Lib;
import flixel.FlxG;

class KadeEngineData
{
    public static function initSave()
    {
        if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.dfjk == null)
			FlxG.save.data.dfjk = false;
			
		if (FlxG.save.data.accuracyDisplay == null)
			FlxG.save.data.accuracyDisplay = true;

		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.songPosition == null)
			FlxG.save.data.songPosition = false;

		if (FlxG.save.data.fps == null)
			FlxG.save.data.fps = false;

		if (FlxG.save.data.changedHit == null)
		{
			FlxG.save.data.changedHitX = -1;
			FlxG.save.data.changedHitY = -1;
			FlxG.save.data.changedHit = false;
		}

		if (FlxG.save.data.fpsRain == null)
			FlxG.save.data.fpsRain = false;

		if (FlxG.save.data.fpsCap == null)
			FlxG.save.data.fpsCap = 120;

		if (FlxG.save.data.fpsCap > 290 || FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = 120; // baby proof so you can't hard lock ur copy of kade engine
		
		if (FlxG.save.data.scrollSpeed == null)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.npsDisplay == null)
			FlxG.save.data.npsDisplay = false;

		if (FlxG.save.data.frames == null)
			FlxG.save.data.frames = 10;

		if (FlxG.save.data.accuracyMod == null)
			FlxG.save.data.accuracyMod = 1;

		if (FlxG.save.data.watermark == null)
			FlxG.save.data.watermark = true;

		if (FlxG.save.data.ghost == null)
			FlxG.save.data.ghost = true;

		if (FlxG.save.data.optimize == null)
			FlxG.save.data.optimize = false;

		if (FlxG.save.data.flashing == null)
			FlxG.save.data.flashing = true;
		
		if (FlxG.save.data.botplay == null)
			FlxG.save.data.botplay = false;

		if (FlxG.save.data.beatenHardIC == null)
			FlxG.save.data.beatenHardIC = false;
		
		if (FlxG.save.data.beatenIC == null)
			FlxG.save.data.beatenIC = false;

		if (FlxG.save.data.beatExShaggy == null)
			FlxG.save.data.beatExShaggy = false;
		
		if (FlxG.save.data.regnoteskin == null)
			FlxG.save.data.regnoteskin = false;
		
		if (FlxG.save.data.betacs == null)
			FlxG.save.data.betacs = false;
		
		if (FlxG.save.data.grem == null)
			FlxG.save.data.grem = true;

		if (FlxG.save.data.bg == null)
			FlxG.save.data.bg = true;

		if (FlxG.save.data.effects == null)
			FlxG.save.data.effects = true;

		if (FlxG.save.data.sign == null)
			FlxG.save.data.sign = true;

		if (FlxG.save.data.characters == null)
			FlxG.save.data.characters = true;

		if (FlxG.save.data.altnoteskin == null)
			FlxG.save.data.altnoteskin = false;
		
		if (FlxG.save.data.replacesky == null)
			FlxG.save.data.replacesky = false;

		if (FlxG.save.data.usesunday == null)
			FlxG.save.data.usesunday = false;

		if (FlxG.save.data.aa == null)
			FlxG.save.data.aa = true;

		if (FlxG.save.data.preload == null)
			FlxG.save.data.preload = true;

		if (FlxG.save.data.bgcharacters == null)
			FlxG.save.data.bgcharacters = true;

		if (FlxG.save.data.regbf == null)
			FlxG.save.data.regbf = false;

		if (FlxG.save.data.orange == null)
			FlxG.save.data.orange = false;

		if (FlxG.save.data.newhalo == null)
			FlxG.save.data.newhalo = true;
 
		Conductor.recalculateTimings();

		KeyBinds.keyCheck();
		PlayerSettings.player1.controls.loadKeyBinds();
		
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
	}
}