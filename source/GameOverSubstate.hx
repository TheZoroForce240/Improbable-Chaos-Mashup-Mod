package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.effects.chainable.FlxGlitchEffect;
import flixel.effects.FlxFlicker;
import flixel.util.FlxSpriteUtil;
import flixel.addons.effects.chainable.FlxEffectSprite;

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

	var glitchEffect:FlxGlitchEffect;
	var whittyEffect:FlxEffectSprite;
	var mattEffect:FlxEffectSprite;
	var picoEffect:FlxEffectSprite;
	var hankcharEffect:FlxEffectSprite;
	var shaggyEffect:FlxEffectSprite;
	var ruvEffect:FlxEffectSprite;
	var hexEffect:FlxEffectSprite;

	var stageSuffix:String = "";

	var daStage = PlayState.curStage;
	public function new(x:Float, y:Float)
	{
		
		var daBf:String = 'signDeath';
		//var dachar:String = 'idle';

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		whitty = new Character(bf.x - 200, -200, 'whitty');
		matt = new Character(bf.x - 400, 700, 'matt');
		pico = new Character(bf.x + 500, 400, 'pico');
		hankchar = new Character(bf.x - 300, 100, 'hankchar');
		shaggy = new Character(0, 0, 'shaggy');
		ruv = new Character(bf.x + 500, -100, 'ruv');
		hex = new Character(bf.x + 150, -100, 'hex');

		glitchEffect = new FlxGlitchEffect(50, 30, 0.2, HORIZONTAL);


		if (daStage == 'auditorHell')
			{

				if (PlayState.isbf == true)
					{
						add(bf);
						bf.alpha = 0.7;
					}
				if (PlayState.iswhitty == true)
				{
					add(whitty);
					whitty.alpha = 0.7;
					//whittyEffect = new FlxEffectSprite(whitty, [glitchEffect]);
					//add(whittyEffect);
					//whittyEffect.x = whitty.x;
					//whittyEffect.y = whitty.y;
					whitty.playAnim('firstDeath');
				}
				if (PlayState.ishex == true)
				{
					add(hex);
					hex.alpha = 0.3;
					hexEffect = new FlxEffectSprite(hex, [glitchEffect]);
					add(hexEffect);
					hexEffect.x = hex.x;
					hexEffect.y = hex.y;
				}
				if (PlayState.isruv == true)
				{
					add(ruv);
					ruv.alpha = 0.3;
					ruvEffect = new FlxEffectSprite(ruv, [glitchEffect]);
					add(ruvEffect);
					ruvEffect.x = ruv.x;
					ruvEffect.y = ruv.y;
				}
				if (PlayState.isshaggy == true)
				{
					add(shaggy);
					shaggy.alpha = 0.3;
					shaggyEffect = new FlxEffectSprite(shaggy, [glitchEffect]);
					add(shaggyEffect);
					shaggyEffect.x = shaggy.x;
					shaggyEffect.y = shaggy.y;
				}
			 	if (PlayState.ishankchar == true)
				{
					add(hankchar);
					hankchar.alpha = 0.3;
					hankcharEffect = new FlxEffectSprite(hankchar, [glitchEffect]);
					add(hankcharEffect);
					hankcharEffect.x = hankchar.x;
					hankcharEffect.y = hankchar.y;
				}
				if (PlayState.ismatt == true)
				{
					add(matt);
					matt.alpha = 0.7;
					//mattEffect = new FlxEffectSprite(matt, [glitchEffect]);
					//add(mattEffect);
					//mattEffect.x = matt.x;
					//mattEffect.y = matt.y;
					matt.playAnim('firstDeath');
				}
				if (PlayState.ispico == true)
				{
					add(pico);
					pico.alpha = 0.3;
					picoEffect = new FlxEffectSprite(pico, [glitchEffect]);
					add(picoEffect);
					picoEffect.x = pico.x;
					picoEffect.y = pico.y;
				}


			}
		else 
			add(bf);




		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y - 300, 1, 1);
		FlxG.camera.zoom = 0.48;
		add(camFollow);

		
		FlxG.sound.play(Paths.sound('BF_Deathsound','clown'));
		new FlxTimer().start(0.5 , function(tmr:FlxTimer)
			{
				bf.playAnim('deathLoop');
			});
		new FlxTimer().start(1.5 , function(tmr:FlxTimer)
			{
				FlxG.sound.playMusic(Paths.music('gameOver','clown'));
				if (PlayState.iswhitty == true)
					whitty.playAnim('deathLoop');
				if (PlayState.ismatt == true)
					matt.playAnim('deathLoop');
			});



		Conductor.changeBPM(200);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
		
		
		//bf.animation.resume();
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
			FlxG.switchState(new MainMenuState());
			MainMenuState.reRoll = true;
			PlayState.loadRep = false;
			PlayState.isbf = true;
			PlayState.iswhitty = false;
			PlayState.ismatt = false;
			PlayState.ispico = false;
			PlayState.ishankchar = false;
			PlayState.isshaggy = false;
			PlayState.isruv = false;
			PlayState.ishex = false;
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
			if (daStage == 'auditorHell')
				{
					if (PlayState.iswhitty == true)
						whitty.playAnim('deathConfirm');
					if (PlayState.ismatt == true)
						matt.playAnim('deathConfirm');
					PlayState.isbf = true;
					PlayState.iswhitty = false;
					PlayState.ismatt = false;
					PlayState.ispico = false;
					PlayState.ishankchar = false;
					PlayState.isshaggy = false;
					PlayState.isruv = false;
					PlayState.ishex = false;
					bf.alpha = 1;
					whitty.alpha = 1;
					matt.alpha = 1;
					pico.alpha = 1;
					hankchar.alpha = 1;
					shaggy.alpha = 1;
					ruv.alpha = 1;
					hex.alpha = 1;
					remove(whittyEffect);
					remove(mattEffect);
					remove(picoEffect);
					remove(hankcharEffect);
					remove(shaggyEffect);
					remove(ruvEffect);
					remove(hexEffect);
				}

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
