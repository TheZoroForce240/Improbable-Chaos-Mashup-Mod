package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var whitty:Character;
	var hex:Character;
	var ruv:Character;
	var shaggy:Character;
	var hankchar:Character;
	var matt:Character;
	var pico:Character;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = 'signDeath';
		//var dachar:String = 'Death';

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		//whitty = new Character(x, y, dachar);
		//hex = new Character(x, y, dachar);
		//ruv = new Character(x, y, dachar);
		//shaggy = new Character(x, y, dachar);
		//hankchar = new Character(x, y, dachar);
		//matt = new Character(x, y, dachar);
		//pico = new Character(x, y, dachar);
		add(bf);
		/*if (isbf == true)
		{
			
		}
		else if (iswhitty == true)
		{
			add(whitty);
		}
		else if (ishex == true)
		{
			add(hex);
		}
		else if (isruv == true)
		{
			add(ruv);
		}
		else if (isshaggy == true)
		{
			add(shaggy);
		}
		else if (ishankchar == true)
		{
			add(hankchar);
		}
		else if (ismatt == true)
		{
			add(matt);
		}
		else if (ispico == true)
		{
			add(pico);
		}*/


		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		
		FlxG.sound.play(Paths.sound('BF_Deathsound','clown'));
		FlxG.sound.play(Paths.sound('Micdrop','clown'));


		Conductor.changeBPM(200);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
		
		bf.playAnim('firstDeath');
		bf.animation.resume();
	}

	var playedMic:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			MainMenuState.reRoll = true;
			FlxG.switchState(new MainMenuState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver','clown'));
			bf.playAnim('deathLoop', true);
		}

		else if (bf.animation.curAnim.finished && bf.animation.curAnim.name != 'deathConfirm')
		{
			bf.playAnim('deathLoop', true);
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd','clown'));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
