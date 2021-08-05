package;

import flixel.group.FlxSpriteGroup;
import lime.app.Application;
import openfl.media.Video;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.effects.chainable.FlxGlitchEffect;
import flixel.effects.FlxFlicker;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

using StringTools;

class PlayState extends MusicBeatState
{
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var mania:Int = 0;
	public static var keyAmmo:Array<Int> = [4, 6, 9];
	private var ctrTime:Float = 0;

	var sh_r:Float = 600;
	var shaggy_r:Float = 600;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	public static var staticVar:PlayState;

	var halloweenLevel:Bool = false;

	private var vocals:FlxSound;

	var godCutEnd:Bool = false;
	var godMoveBf:Bool = true;
	var godMoveGf:Bool = false;
	var godMoveSh:Bool = false;
	var rock:FlxSprite;
	var gf_rock:FlxSprite;
	var gf_launched:Bool = false;

	// tricky lines
	public var TrickyLinesSing:Array<String> = ["SUFFER","INCORRECT", "INCOMPLETE", "INSUFFICIENT", "INVALID", "CORRECTION", "MISTAKE", "REDUCE", "ERROR", "ADJUSTING", "IMPROBABLE", "IMPLAUSIBLE", "MISJUDGED"];
	public var ExTrickyLinesSing:Array<String> = ["I FOUND YOU HANK", "HANK!!!", "HAAAAAAAAANK!!!", "WHO ARE YOU", "WHERE AM I", "THIS ISN'T RIGHT", "MIDGET", "SYSTEM UNRESPONSIVE", "WHY CAN'T I KILL?????"];
	public var TrickyLinesMiss:Array<String> = ["TERRIBLE", "WASTE", "MISS CALCULTED", "PREDICTED", "FAILURE", "DISGUSTING", "ABHORRENT", "FORESEEN", "CONTEMPTIBLE", "PROGNOSTICATE", "DISPICABLE", "REPREHENSIBLE"];

	//cutscene text unhardcoding
	public var cutsceneText:Array<String> = ["OMFG CLOWN!!!!", "YOU DO NOT KILL CLOWN", "CLOWN KILLS YOU!!!!!!"];

	public static var dad:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;


	// custom character switching code

	public var pico:Character;
	public var matt:Character;
	public var garcello:Character;
	public var shaggy:Character;
	public var hankchar:Character;
	public var whitty:Character;
	public var hex:Character;
	public var ruv:Character;

	public var cass:Character;
	public var bob:Character;
	public var zardy:Character;
	public var tabi:Character;
	public var agoti:Character;
	public var senpai:Character;
	public var tordbot:Character;

	//old character switch code
	//private var CharL1:Character;
	//private var CharL2:Character;
	//private var CharL3:Character;
	//private var CharR1:Character;
	//private var CharR2:Character;
	//private var CharR3:Character;

	public static var isbf:Bool = true;
	public var istricky:Bool = true;
	public static var ispico:Bool = false;
	public static var ismatt:Bool = false;
	public var isgarcello:Bool = false;
	public static var isshaggy:Bool = false;
	public static var ishankchar:Bool = false;
	public static var iswhitty:Bool = false;
	public static var ishex:Bool = false;
	public static var isruv:Bool = false;

	public var issky:Bool = false;
	public var isbob:Bool = false;
	public var iszardy:Bool = false;
	public var istabi:Bool = false;
	public var isagoti:Bool = false;
	public var issenpai:Bool = false;
	public var istordbot:Bool = false;

	public var gfbg:FlxSprite;
	public var carolbg:FlxSprite;
	public var opheebopscoobbg:FlxSprite;
	public var sarvbg:FlxSprite;
	public var boomboxbg:FlxSprite;

	public var missType:Int = 0;

	public var optimize:Bool = false; //not used anymore rip

	private var shaggyT:FlxTrail;
	private var exshaggyT:FlxTrail;
	private var senpaiT:FlxTrail;

	var bobmadshake:FlxSprite;
	var bobsound:FlxSound;

	private var sDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	var MAINLIGHT:FlxSprite;
	
	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	var hudArrows:Array<FlxSprite>;

	var babyArrow:FlxSprite;

	var cameragocrazy:Bool = false;
	var spinnyboi:Bool = false;
	var SpinAmount:Float = 0; //using code from bob

	var tstatic:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('TrickyStatic','clown'), true, 320, 180);

	var tStaticSound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("staticSound","preload"));

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	private var strumLineNotes:FlxTypedGroup<FlxSprite>;
	private var playerStrums:FlxTypedGroup<FlxSprite>;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	public static var instance:PlayState;

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;
	public static var misses:Int = 0;
	private var accuracy:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var sway:Bool = false;

	public static var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var camHUD:FlxCamera;
	var notesHitArray:Array<Date> = [];
	private var camGame:FlxCamera;
	var cs_reset:Bool = false;

	public var island:FlxSprite;
	public var stagestart:FlxSprite;

	var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];

	var fc:Bool = true;


	var talking:Bool = true;
	var songScore:Int = 0;
	var scoreTxt:FlxText;
	var healthTxt:FlxText;
	var replayTxt:FlxText;

	var gfDance:Bool = false;

	var godMoveShaggy:Bool = false;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public var hank:FlxSprite;
	var energyWall:FlxSprite;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;

	public static var trans:FlxSprite;

	override public function create()
	{
		KeyBinds.keyCheck();

		FlxG.sound.cache(Paths.inst(PlayState.SONG.song));
		FlxG.sound.cache(Paths.voices(PlayState.SONG.song));

		generatedMusic = false;
		theFunne = FlxG.save.data.newInput;
		optimize = FlxG.save.data.optimize;
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		instance = this;

		if (storyWeek == 7)
			transIn = null;

		var cover:FlxSprite = new FlxSprite(-180,755).loadGraphic(Paths.image('fourth/cover','clown'));
		var hole:FlxSprite = new FlxSprite(50,530).loadGraphic(Paths.image('fourth/Spawnhole_Ground_BACK','clown'));
		var converHole:FlxSprite = new FlxSprite(7,578).loadGraphic(Paths.image('fourth/Spawnhole_Ground_COVER','clown'));

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;

		misses = 0;

		repPresses = 0;
		repReleases = 0;

		resetSpookyText = true;

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);

		FlxCamera.defaultCameras = [camGame];

		staticVar = this;

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');
		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		mania = SONG.mania;
		
		//unhardcode tricky sing strings lmao
		TrickyLinesSing = CoolUtil.coolTextFile(Paths.txt('trickySingStrings'));
		TrickyLinesMiss = CoolUtil.coolTextFile(Paths.txt('trickyMissStrings'));
		ExTrickyLinesSing = CoolUtil.coolTextFile(Paths.txt('trickyExSingStrings'));

		//load cutscene text
		cutsceneText = CoolUtil.coolTextFile(Paths.txt('cutMyBalls'));
		//yes i called it "cut my balls" fuck you i can name my txts whatever i want

		switch (SONG.song.toLowerCase())
		{
			case 'tutorial':
				dialogue = ["Hey you're pretty cute.", 'Use the arrow keys to keep up \nwith me singing.'];
			case 'bopeebo':
				dialogue = [
					'HEY!',
					"You think you can just sing\nwith my daughter like that?",
					"If you want to date her...",
					"You're going to have to go \nthrough ME first!"
				];
			case 'fresh':
				dialogue = ["Not too shabby boy.", ""];
			case 'dadbattle':
				dialogue = [
					"gah you think you're hot stuff?",
					"If you can beat me here...",
					"Only then I will even CONSIDER letting you\ndate my daughter!"
				];
			case 'senpai':
				dialogue = CoolUtil.coolTextFile(Paths.txt('senpai/senpaiDialogue'));
			case 'roses':
				dialogue = CoolUtil.coolTextFile(Paths.txt('roses/rosesDialogue'));
			case 'thorns':
				dialogue = CoolUtil.coolTextFile(Paths.txt('thorns/thornsDialogue'));
		}

		if (SONG.song.toLowerCase() == 'improbable-outset' || SONG.song.toLowerCase() == 'madness')
		{
			//trace("line 538");
			defaultCamZoom = 0.75;
			curStage = 'nevada';

			tstatic.antialiasing = true;
			tstatic.scrollFactor.set(0,0);
			tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
			tstatic.animation.add('static', [0, 1, 2], 24, true);
			tstatic.animation.play('static');

			tstatic.alpha = 0;

			var bg:FlxSprite = new FlxSprite(-350, -300).loadGraphic(Paths.image('red','clown'));
			// bg.setGraphicSize(Std.int(bg.width * 2.5));
			// bg.updateHitbox();
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			var stageFront:FlxSprite;
			if (SONG.song.toLowerCase() != 'madness')
			{
				add(bg);
				stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('island_but_dumb','clown'));
			}
			else
				stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('island_but_rocks_float','clown'));

			stageFront.setGraphicSize(Std.int(stageFront.width * 1.4));
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);
			
			MAINLIGHT = new FlxSprite(-470, -150).loadGraphic(Paths.image('hue','clown'));
			MAINLIGHT.alpha - 0.3;
			MAINLIGHT.setGraphicSize(Std.int(MAINLIGHT.width * 0.9));
			MAINLIGHT.blend = "screen";
			MAINLIGHT.updateHitbox();
			MAINLIGHT.antialiasing = true;
			MAINLIGHT.scrollFactor.set(1.2, 1.2);
		}
		else if (SONG.song.toLowerCase() == 'hellclown')
		{
			//trace("line 538");
			defaultCamZoom = 0.35;
			curStage = 'nevadaSpook';

			tstatic.antialiasing = true;
			tstatic.scrollFactor.set(0,0);
			tstatic.setGraphicSize(Std.int(tstatic.width * 10));
			tstatic.screenCenter(Y);
			tstatic.animation.add('static', [0, 1, 2], 24, true);
			tstatic.animation.play('static');

			tstatic.alpha = 0;


			var bg:FlxSprite = new FlxSprite(-1000, -1000).loadGraphic(Paths.image('fourth/bg','clown'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.setGraphicSize(Std.int(bg.width * 5));
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-2000, -400).loadGraphic(Paths.image('hellclwn/island_but_red','clown'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 2.6));
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);
			
			hank = new FlxSprite(60,-170);
			hank.frames = Paths.getSparrowAtlas('hellclwn/Hank','clown');
			hank.animation.addByPrefix('dance','Hank',24);
			hank.animation.play('dance');
			hank.scrollFactor.set(0.9, 0.9);
			hank.setGraphicSize(Std.int(hank.width * 1.55));
			hank.antialiasing = true;
			

			add(hank);
		}
		else if (SONG.song.toLowerCase() == 'improbable-chaos')
		{
			//trace("line 538");
			defaultCamZoom = 0.48;
			camHUD.zoom = 0.9;
			curStage = 'auditorHell';

			
			tstatic.scrollFactor.set(0,0);
			tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
			tstatic.animation.add('static', [0, 1, 2], 24, true);
			tstatic.animation.play('static');

			tstatic.alpha = 0;

			var bg:FlxSprite = new FlxSprite(-10, -10).loadGraphic(Paths.image('fourth/bg','clown'));
	
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 4));


			hole.scrollFactor.set(0.95, 0.95);
					

			converHole.scrollFactor.set(0.95, 0.95);
			converHole.setGraphicSize(Std.int(converHole.width * 1.3));
			hole.setGraphicSize(Std.int(hole.width * 1.55));


			cover.scrollFactor.set(0.95, 0.95);
			cover.setGraphicSize(Std.int(cover.width * 1.55));

			energyWall = new FlxSprite(1350,-690).loadGraphic(Paths.image("fourth/Energywall","clown"));

			energyWall.scrollFactor.set(0.9, 0.9);

			
			stagestart = new FlxSprite(-350, -355).loadGraphic(Paths.image('fourth/daBackground','clown'));

			stagestart.scrollFactor.set(0.95, 0.95);
			stagestart.setGraphicSize(Std.int(stagestart.width * 1.55));


			island = new FlxSprite(-1100, -660).loadGraphic(Paths.image('island_but_rocks_float','clown'));

			island.scrollFactor.set(0.95, 0.95);
			island.setGraphicSize(Std.int(island.width * 1.55));
			island.scale.set(2, 2);
			island.alpha = 0;


			boomboxbg = new FlxSprite(650, -300).loadGraphic(Paths.image('characters/thegfs/Destroyed_boombox'));

			boomboxbg.scrollFactor.set(0.95, 0.95);
			boomboxbg.alpha = 0;
			

			gfbg = new FlxSprite(650, -300);
			gfbg.frames = Paths.getSparrowAtlas('characters/thegfs/PostExpGF_Assets');
			gfbg.animation.addByPrefix('dance','GF LayedDownHurt ',24);
			gfbg.animation.play('dance');

			gfbg.scrollFactor.set(0.95, 0.95);
			gfbg.scale.set(0.8, 0.8);
			gfbg.flipX = true;
			gfbg.alpha = 0;
			

			carolbg = new FlxSprite(650, -600).loadGraphic(Paths.image('characters/thegfs/carolbg'));

			carolbg.scrollFactor.set(0.95, 0.95);
			carolbg.scale.set(0.8, 0.8);
			carolbg.alpha = 0;
			

			opheebopscoobbg = new FlxSprite(500, -800).loadGraphic(Paths.image('characters/thegfs/opheebop_and_scoob'));

			opheebopscoobbg.scrollFactor.set(0.95, 0.95);
			opheebopscoobbg.scale.set(0.8, 0.8);
			opheebopscoobbg.alpha = 0;
			

			sarvbg = new FlxSprite(950, -800);
			sarvbg.frames = Paths.getSparrowAtlas('characters/thegfs/theseknees');
			sarvbg.animation.addByPrefix('dance','TiredSarv',24);
			sarvbg.animation.play('dance');
			
			sarvbg.scrollFactor.set(0.95, 0.95);
			sarvbg.scale.set(0.8, 0.8);
			sarvbg.alpha = 0;
			if (FlxG.save.data.aa)
				{
					tstatic.antialiasing = true;
					sarvbg.antialiasing = true;
					opheebopscoobbg.antialiasing = true;
					carolbg.antialiasing = true;
					gfbg.antialiasing = true;
					boomboxbg.antialiasing = true;
					island.antialiasing = true;
					stagestart.antialiasing = true;
					energyWall.antialiasing = true;
					cover.antialiasing = true;
					hole.antialiasing = true;
					bg.antialiasing = true;
					converHole.antialiasing = true;
				}

			else if (!FlxG.save.data.aa)
				{
					tstatic.antialiasing = false;
					sarvbg.antialiasing = false;
					opheebopscoobbg.antialiasing = false;
					carolbg.antialiasing = false;
					gfbg.antialiasing = false;
					boomboxbg.antialiasing = false;
					island.antialiasing = false;
					stagestart.antialiasing = false;
					energyWall.antialiasing = false;
					cover.antialiasing = false;
					hole.antialiasing = false;
					bg.antialiasing = false;
					converHole.antialiasing = false;
				}

			if (FlxG.save.data.bg)
				{
					add(bg);
					add(energyWall);
					add(stagestart);
					add(island);
				}
			if (FlxG.save.data.bgcharacters)
				{
					add(sarvbg);
					add(opheebopscoobbg);
					add(boomboxbg);
					add(gfbg);
					add(carolbg);
				}




				 


			bobmadshake = new FlxSprite( -198, -118);
			bobmadshake.frames = Paths.getSparrowAtlas('bobscreen');
			bobmadshake.animation.addByPrefix('idle', 'BobScreen', 24);
			bobmadshake.scrollFactor.set(0, 0);
			bobmadshake.scale.set(2.5, 2.5);
			bobmadshake.visible = false;
	
			
			bobsound = new FlxSound().loadEmbedded(Paths.sound('bobscreen'));
		}
		else if (SONG.song.toLowerCase() == 'expurgation')
			{
				//trace("line 538");
				defaultCamZoom = 0.55;
				camHUD.zoom = 0.9;
				curStage = 'shaggyHell';
	
				tstatic.antialiasing = true;
				tstatic.scrollFactor.set(0,0);
				tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
				tstatic.animation.add('static', [0, 1, 2], 24, true);
				tstatic.animation.play('static');
	
				tstatic.alpha = 0;
	
				var bg:FlxSprite = new FlxSprite(-10, -10).loadGraphic(Paths.image('fourth/bg','clown'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				bg.setGraphicSize(Std.int(bg.width * 4));
				add(bg);
	
				hole.antialiasing = true;
				hole.scrollFactor.set(0.9, 0.9);
						
				converHole.antialiasing = true;
				converHole.scrollFactor.set(0.9, 0.9);
				converHole.setGraphicSize(Std.int(converHole.width * 1.3));
				hole.setGraphicSize(Std.int(hole.width * 1.55));
	
				cover.antialiasing = true;
				cover.scrollFactor.set(0.9, 0.9);
				cover.setGraphicSize(Std.int(cover.width * 1.55));
	
				energyWall = new FlxSprite(1350,-690).loadGraphic(Paths.image("fourth/Energywall","clown"));
				energyWall.antialiasing = true;
				energyWall.scrollFactor.set(0.9, 0.9);
				add(energyWall);

					
				add(new MansionDebris(300, -800, 'norm', 0.4, 1, 0, 1));
				add(new MansionDebris(600, -300, 'tiny', 0.4, 1.5, 0, 1));
				add(new MansionDebris(-150, -400, 'spike', 0.4, 1.1, 0, 1));
				add(new MansionDebris(-750, -850, 'small', 0.4, 1.5, 0, 1));

				/*
				add(new MansionDebris(-300, -1700, 'norm', 0.5, 1, 0, 1));
				add(new MansionDebris(-600, -1100, 'tiny', 0.5, 1.5, 0, 1));
				add(new MansionDebris(900, -1850, 'spike', 0.5, 1.2, 0, 1));
				add(new MansionDebris(1500, -1300, 'small', 0.5, 1.5, 0, 1));
				*/

				add(new MansionDebris(-300, -1700, 'norm', 0.75, 1, 0, 1));
				add(new MansionDebris(-1000, -1750, 'rect', 0.75, 2, 0, 1));
				add(new MansionDebris(-600, -1100, 'tiny', 0.75, 1.5, 0, 1));
				add(new MansionDebris(900, -1850, 'spike', 0.75, 1.2, 0, 1));
				add(new MansionDebris(1500, -1300, 'small', 0.75, 1.5, 0, 1));
				add(new MansionDebris(-600, -800, 'spike', 0.75, 1.3, 0, 1));
				add(new MansionDebris(-1000, -900, 'small', 0.75, 1.7, 0, 1));
				
				stagestart = new FlxSprite(-350, -355).loadGraphic(Paths.image('fourth/daBackground','clown'));
				stagestart.antialiasing = true;
				stagestart.scrollFactor.set(0.9, 0.9);
				stagestart.setGraphicSize(Std.int(stagestart.width * 1.55));
				add(stagestart);

				gf_rock = new FlxSprite(20, 20);
				gf_rock.frames = Paths.getSparrowAtlas('god_bg');
				gf_rock.animation.addByPrefix('rock', "gf_rock", 30);
				gf_rock.animation.play('rock');
				gf_rock.scrollFactor.set(0.8, 0.8);
				gf_rock.antialiasing = true;
				add(gf_rock);

				rock = new FlxSprite(20, 20);
				rock.frames = Paths.getSparrowAtlas('god_bg');
				rock.animation.addByPrefix('rock', "rock", 30);
				rock.animation.play('rock');
				rock.scrollFactor.set(1, 1);
				rock.antialiasing = true;
				add(rock);
			}
		else if (SONG.song.toLowerCase() == 'absolute-chaos')
			{
				//trace("line 538");
				defaultCamZoom = 0.48;
				camHUD.zoom = 0.9;
				curStage = 'absoluteHell';
	
				
				tstatic.scrollFactor.set(0,0);
				tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
				tstatic.animation.add('static', [0, 1, 2], 24, true);
				tstatic.animation.play('static');
	
				tstatic.alpha = 0;
	
				var bg:FlxSprite = new FlxSprite(-10, -10).loadGraphic(Paths.image('fourth/bg','clown'));
		
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				bg.setGraphicSize(Std.int(bg.width * 4));

	
				
				stagestart = new FlxSprite(-350, -355).loadGraphic(Paths.image('fourth/daBackground','clown'));
	
				stagestart.scrollFactor.set(0.95, 0.95);
				stagestart.setGraphicSize(Std.int(stagestart.width * 1.55));
	
	
				island = new FlxSprite(-1100, -660).loadGraphic(Paths.image('island_but_rocks_float','clown'));
	
				island.scrollFactor.set(0.95, 0.95);
				island.setGraphicSize(Std.int(island.width * 1.55));
				island.scale.set(2, 2);
				island.alpha = 0;
			if (FlxG.save.data.bg)
				{
					add(bg);
					add(island);
				}
				bobmadshake = new FlxSprite( -198, -118);
			    bobmadshake.frames = Paths.getSparrowAtlas('bobscreen');
			    bobmadshake.animation.addByPrefix('idle', 'BobScreen', 24);
			    bobmadshake.scrollFactor.set(0, 0);
			    bobmadshake.scale.set(2.5, 2.5);
			    bobmadshake.visible = false;
			}
		else
		{
			defaultCamZoom = 0.9;
			curStage = 'stage';
			var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);

			var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			stageCurtains.antialiasing = true;
			stageCurtains.scrollFactor.set(1.3, 1.3);
			stageCurtains.active = false;

			add(stageCurtains);
		}


		var gfVersion:String = 'gf';

		switch (curStage)
		{
			case 'nevadaSpook':
				gfVersion = 'gf-hell';
			case 'shaggyHell':
				gfVersion = 'gf-tied';
		}

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);

		dad = new Character(100, 100, SONG.player2);
		
		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);


		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'dad':
				camPos.x += 400;
			case 'tricky':
				camPos.x += 400;
				camPos.y += 600;
			case 'trickyMask':
				camPos.x += 400;
			case 'trickyH':
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y + 500);
				dad.y -= 2000;
				dad.x -= 1400;
				gf.x -= 380;
			case 'exTricky':
				dad.x -= 250;
				dad.y -= 365;
				gf.x += 345;
				gf.y -= 25;
				dad.visible = false;
			case 'shaggy': 
				dad.y -= 250;
				dad.flipX = false;
				gf.x += 445;
				gf.y -= 25;
				dad.visible = false;

		}


		var bfVersion = SONG.player1;

		switch(curStage)
		{
			case 'nevadaSpook':
				bfVersion = 'bf-hell';
		}

		//old testing code
		//CharL1srg = 'bf';
		//CharL1srg = 'whitty';
		//CharL1srg = 'matt';

		//CharL1 = new Character(770, 450, 'bf');
		//CharL2 = new Character(770, 450, 'whitty');
		//CharL3 = new Character(770, 450, 'matt');

		//CharL1.curCharacter = CharL1srg;
		//CharL2.curCharacter = CharL2srg;
		//CharL3.curCharacter = CharL3srg;
		//CharR1.curCharacter = CharR1srg;
		//CharR2.curCharacter = CharR2srg;
		//CharR3.curCharacter = CharR3srg;


		//character stuff
		
		if (curStage == 'auditorHell')
			{
				tabi = new Character(-200, 80, 'tabi');
				agoti = new Character(-350, -100, 'agoti');
				cass = new Character(50, 200, 'cass');
				tordbot = new Character(-800, -2100, 'tordbot');
				tordbot.scale.set(1.5, 1.5);
				zardy = new Character(430, -230, 'zardy');
				bob = new Character(450, 240, 'bob');
				senpai = new Character(-550, -200, 'senpai');
		
				whitty = new Character(1380, -300, 'whitty');
				matt = new Character(1350, 500, 'matt');
				pico = new Character(2000, 200, 'pico');
				hankchar = new Character(1300, -100, 'hankchar');
				garcello = new Character(2100, -300, 'garcello');
				shaggy = new Character(0, 0, 'shaggy');
				ruv = new Character(2000, -350, 'ruv');
				hex = new Character(1700, -200, 'hex');
		
			//	switchCharacter('')
			//	resetCharacters()
			//	removeCharacter('') 
			//this is just so i can copy paste cuz i had the page split
				tabi.alpha = 0;
				agoti.alpha = 0;
				cass.alpha = 0;
				tordbot.alpha = 0;
				zardy.alpha = 0;
				bob.alpha = 0;
				senpai.alpha = 0;
		
				whitty.alpha = 0;
				matt.alpha = 0;
				pico.alpha = 0;
				hankchar.alpha = 0;
				garcello.alpha = 0;
				shaggy.alpha = 0;
				ruv.alpha = 0;
				hex.alpha = 0;
			}
		if (curStage == 'absoluteHell')
			{
				ruv = new Character(2000, -350, 'ruv');
				hex = new Character(1700, -200, 'hex');
				shaggy = new Character(0, 0, 'shaggy');
			}



		shaggyT = new FlxTrail(shaggy, null, 5, 7, 0.3, 0.001);
		
		shaggyT.alpha = 0;

		



		senpaiT = new FlxTrail(senpai, null, 5, 7, 0.3, 0.001);
		
		senpaiT.alpha = 0;



		boyfriend = new Boyfriend(770, 450, bfVersion);

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'nevada':
				boyfriend.y -= 0;
				boyfriend.x += 260;
			case 'auditorHell':
				boyfriend.y -= 160;
				boyfriend.x += 950;
			case 'absoluteHell':
				boyfriend.y -= 160;
				boyfriend.x += 950;
			case 'shaggyHell': 
				boyfriend.y -= 160;
				boyfriend.x += 350;
		}
		if (curStage == 'shaggyHell')
			add(gf);
			


		if (curStage == 'auditorHell' || curStage == 'shaggyHell')
			add(hole);
			
		if (dad.curCharacter == 'shaggy')
				exshaggyT = new FlxTrail(dad, null, 5, 7, 0.3, 0.001);
				add(exshaggyT);


		if (dad.curCharacter == 'trickyH')
			dad.addOtherFrames();

		//characters are in this order for layering

		if (FlxG.save.data.characters)
		{
			if (curStage == 'auditorHell')
				{
					if (FlxG.save.data.replacesky && FlxG.save.data.usesunday)
						{
							add(cass);
							cass.x += 400;
							cass.y -= 600;
							cass.scale.set(0.9, 0.9);
						}
						
					add(zardy);
					add(tordbot);
					add(senpaiT);
					add(senpai);
					add(agoti);
				}
				
				
				add(dad);
				
				if (curStage == 'auditorHell')
				{
					add(bob);
					add(shaggyT);
					add(shaggy);
					add(whitty);
					add(ruv);
					add(garcello);
					add(hex);
					add(hankchar);
					add(pico);
		
					add(senpai);
					
				}
				if (curStage == 'absoluteHell')
					{
						add(hex);
						add(ruv);
						add(shaggy);
					}
				add(boyfriend);

				
		

			if (curStage == 'shaggyHell')
			{
				// Clown init
				if (FlxG.save.data.preload)
				{
					scoobone = new FlxSprite(0,0);
					scoobtwo = new FlxSprite(0,0);
					scoobone.frames = CachedFrames.cachedInstance.fromSparrow('scoob','fourth/bonus/scoob');
					scoobtwo.frames = CachedFrames.cachedInstance.fromSparrow('scoob','fourth/bonus/scoob');
					scoobone.alpha = 0;
					scoobtwo.alpha = 0;
					scoobone.animation.addByPrefix('clone','Clone',24,false);
					scoobtwo.animation.addByPrefix('clone','Clone',24,false);
				}

				exshaggyT.alpha = 0.3;

				// cover crap
				if (FlxG.save.data.preload)
				{
					add(scoobone);
					add(scoobtwo);
				}

				add(cover);
				add(converHole);
				add(dad.exSpikes);
			}

			else if (curStage == 'auditorHell')
			{


				// Clown init
				if (FlxG.save.data.preload)
				{
					cloneOne = new FlxSprite(0,0);
					cloneTwo = new FlxSprite(0,0);
					cloneOne.frames = CachedFrames.cachedInstance.fromSparrow('cln','fourth/Clone');
					cloneTwo.frames = CachedFrames.cachedInstance.fromSparrow('cln','fourth/Clone');
					cloneOne.alpha = 0;
					cloneTwo.alpha = 0;
					cloneOne.animation.addByPrefix('clone','Clone',24,false);
					cloneTwo.animation.addByPrefix('clone','Clone',24,false);
				}

				// cover crap
				if (FlxG.save.data.preload)
				{
					add(cloneOne);
					add(cloneTwo);
				}

				add(cover);
				add(converHole);
				add(dad.exSpikes);

			}
			if (curStage == 'auditorHell')
				{
					add(tabi);

					if (FlxG.save.data.replacesky && !FlxG.save.data.usesunday)
						{
							add(cass);
						}


					add(matt);

				}
		}

		if (FlxG.save.data.effects)
			add(bobmadshake);

		
		
		trace('hello');

		if (dad.curCharacter == 'trickyH')
		{
			gf.setGraphicSize(Std.int(gf.width * 0.8));
			boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.8));
			gf.x += 220;
		}

		if (curStage == 'nevada')
		{	
			add(MAINLIGHT);
		}

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;


		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();

		if (FlxG.save.data.downscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		generateSong(SONG.song);

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (dad.curCharacter == 'trickyH')
		{
			camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y + 265);
		
		}
		
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.008);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;


		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (FlxG.save.data.downscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4 - healthBarBG.x - healthBarBG.x + 78, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width * 2 - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 4);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0x00000000, 0xFF66FF33);
		//(0xFFFF0000, 0xFF66FF33);
		// healthBar
		add(healthBar);

		// Add Kade Engine watermark
		// what's your fuckin' deal???????????? -roze
		// what roze bud??? -kade
		// no 
		// ░░░░░▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄░░░░░░░
		// ░░░░░█░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▀▀▄░░░░
		// ░░░░█░░░▒▒▒▒▒▒░░░░░░░░▒▒▒░░█░░░
		// ░░░█░░░░░░▄██▀▄▄░░░░░▄▄▄░░░░█░░
		// ░▄▀▒▄▄▄▒░█▀▀▀▀▄▄█░░░██▄▄█░░░░█░
		// █░▒█▒▄░▀▄▄▄▀░░░░░░░░█░░░▒▒▒▒▒░█
		// █░▒█░█▀▄▄░░░░░█▀░░░░▀▄░░▄▀▀▀▄▒█
		// ░█░▀▄░█▄░█▀▄▄░▀░▀▀░▄▄▀░░░░█░░█░
		// ░░█░░░▀▄▀█▄▄░█▀▀▀▄▄▄▄▀▀█▀██░█░░
		// ░░░█░░░░██░░▀█▄▄▄█▄▄█▄████░█░░░ //is that a fnf referecnce!?!?!??! haha trollage funne
		// ░░░░█░░░░▀▀▄░█░░░█░█▀██████░█░░
		// ░░░░░▀▄░░░░░▀▀▄▄▄█▄█▄█▄█▄▀░░█░░
		// ░░░░░░░▀▄▄░▒▒▒▒░░░░░░░░░░▒░░░█░
		// ░░░░░░░░░░▀▀▄▄░▒▒▒▒▒▒▒▒▒▒░░░░█░
		// ░░░░░░░░░░░░░░▀▄▄▄▄▄░░░░░░░░█░░
		// trolling

		/*var kadeEngineWatermark = new FlxText(4,FlxG.height - 4,0,SONG.song + " " + (storyDifficulty == 2 ? "Hard" : storyDifficulty == 1 ? "Normal" : "Easy") + " - KE " + MainMenuState.kadeEngineVer, 16);
		kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);*/

		scoreTxt = new FlxText(0,0 , 0, "", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.screenCenter();
		scoreTxt.x -= 200;
		if (!theFunne)
			scoreTxt.x -= 75;
		scoreTxt.y = healthBarBG.y + 50;
		add(scoreTxt);
		healthTxt = new FlxText(0,0 , 0, "", 20);
		healthTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		healthTxt.scrollFactor.set();
		healthTxt.screenCenter();
		healthTxt.x -= 200;
		if (!theFunne)
			healthTxt.x -= 75;
		healthTxt.y = healthBarBG.y + 70;
		add(healthTxt);

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		replayTxt.scrollFactor.set();
		if (loadRep)
			{
				add(replayTxt);
			}

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		healthTxt.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camHUD];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		if (FlxG.save.data.effects)
		{
			if (curStage == "nevada" || curStage == "nevadaSpook" || curStage == 'auditorHell' || curStage == 'shaggyHell' || curStage == 'absoluteHell')
				add(tstatic);
		}


		if (curStage == 'auditorHell' || curStage == 'shaggyHell')
			tstatic.alpha = 0.1;

		if (curStage == 'nevadaSpook' || curStage == 'auditorHell' || curStage == 'shaggyHell' || curStage == 'absoluteHell')
		{
			tstatic.setGraphicSize(Std.int(tstatic.width * 12));
			tstatic.x += 600;
		}


		if (isStoryMode)
		{
			switch (curSong.toLowerCase())
			{
				case 'improbable-outset':
					camFollow.setPosition(boyfriend.getMidpoint().x + 70, boyfriend.getMidpoint().y - 50);
					if (playCutscene)
					{
						trickyCutscene();
						playCutscene = false;
					}
					else
						startCountdown();
				case 'expurgation':
					camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
					var spawnAnim = new FlxSprite(-150,-380);
					spawnAnim.frames = Paths.getSparrowAtlas('fourth/EXENTER','clown');

					spawnAnim.animation.addByPrefix('start','Entrance',24,false);

					add(spawnAnim);


					spawnAnim.animation.play('start');
					var p = new FlxSound().loadEmbedded(Paths.sound("fourth/shagFly","clown"));
					var pp = new FlxSound().loadEmbedded(Paths.sound("fourth/TrickyGlitch","clown"));
					p.play();
					spawnAnim.animation.finishCallback = function(pog:String)
						{
							pp.fadeOut();
							dad.visible = true;
							remove(spawnAnim);
							startCountdown();
						}
					new FlxTimer().start(0.001, function(tmr:FlxTimer)
						{
							if (spawnAnim.animation.frameIndex == 24)
							{
								pp.play();
							}
							else
								tmr.reset(0.001);
						});
				default:
					startCountdown();
			

			}
		}
		if (!isStoryMode && curSong.toLowerCase() == 'expurgation')
			{
				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
					var spawnAnim = new FlxSprite(-150,-380);
					spawnAnim.frames = Paths.getSparrowAtlas('fourth/EXENTER','clown');

					spawnAnim.animation.addByPrefix('start','Entrance',24,false);
					add(spawnAnim);


					spawnAnim.animation.play('start');
					var p = new FlxSound().loadEmbedded(Paths.sound("fourth/shagFly","clown"));
					var pp = new FlxSound().loadEmbedded(Paths.sound("fourth/TrickyGlitch","clown"));
					p.play();
					spawnAnim.animation.finishCallback = function(pog:String)
						{
							pp.fadeOut();
							dad.visible = true;
							remove(spawnAnim);
							startCountdown();
						}
					new FlxTimer().start(0.001, function(tmr:FlxTimer)
						{
							if (spawnAnim.animation.frameIndex == 24)
							{
								pp.play();
							}
							else
								tmr.reset(0.001);
						});
			}
		else if (!isStoryMode)
			{
				startCountdown();
			}



		super.create();
	}

	function doStopSign(sign:Int = 0, fuck:Bool = false)
	{
		if (FlxG.save.data.sign && FlxG.save.data.preload)
		{
			trace('sign ' + sign);
			var daSign:FlxSprite = new FlxSprite(0,0);
			// CachedFrames.cachedInstance.get('sign')

			daSign.frames = CachedFrames.cachedInstance.fromSparrow('sign','fourth/mech/Sign_Post_Mechanic');

			daSign.setGraphicSize(Std.int(daSign.width * 0.67));

			daSign.cameras = [camHUD];

			switch(sign)
			{
				case 0:
					daSign.animation.addByPrefix('sign','Signature Stop Sign 1',24, false);
					daSign.x = FlxG.width - 650;
					daSign.angle = -90;
					daSign.y = -300;
				case 1:
					/*daSign.animation.addByPrefix('sign','Signature Stop Sign 2',20, false);
					daSign.x = FlxG.width - 670;
					daSign.angle = -90;*/ // this one just doesn't work???
				case 2:
					daSign.animation.addByPrefix('sign','Signature Stop Sign 3',24, false);
					daSign.x = FlxG.width - 780;
					daSign.angle = -90;
					if (FlxG.save.data.downscroll)
						daSign.y = -395;
					else
						daSign.y = -980;
				case 3:
					daSign.animation.addByPrefix('sign','Signature Stop Sign 4',24, false);
					daSign.x = FlxG.width - 1070;
					daSign.angle = -90;
					daSign.y = -145;
			}
			add(daSign);
			daSign.flipX = fuck;
			daSign.animation.play('sign');
			daSign.animation.finishCallback = function(pog:String)
				{
					trace('ended sign');
					remove(daSign);
				}
		}
	}

	var totalDamageTaken:Float = 0;

	var shouldBeDead:Bool = false;

	var interupt = false;

	// basic explanation of this is:
	// get the health to go to
	// tween the gremlin to the icon
	// play the grab animation and do some funny maths,
	// to figure out where to tween to.
	// lerp the health with the tween progress
	// if you loose any health, cancel the tween.
	// and fall off.
	// Once it finishes, fall off.

	function doGremlin(hpToTake:Int, duration:Int,persist:Bool = false)
	{
		interupt = false;

		grabbed = true;
		
		totalDamageTaken = 0;

		var gramlan:FlxSprite = new FlxSprite(0,0);

		if (SONG.song.toLowerCase() == 'improbable-chaos')
		{
			if (FlxG.save.data.preload)
				gramlan.frames = CachedFrames.cachedInstance.fromSparrow('grem','fourth/mech/HP GREMLIN');
		}
		else if (SONG.song.toLowerCase() == 'expurgation')
		{
			if (FlxG.save.data.preload)
				gramlan.frames = CachedFrames.cachedInstance.fromSparrow('scoobgrem','fourth/bonus/scoobGREMLIN');
		}
		else if (SONG.song.toLowerCase() == 'absolute-chaos')
			{
				if (FlxG.save.data.preload)
					gramlan.frames = CachedFrames.cachedInstance.fromSparrow('grem','fourth/mech/HP GREMLIN');
			}

		gramlan.setGraphicSize(Std.int(gramlan.width * 0.76));
 
		gramlan.cameras = [camHUD];

		gramlan.x = iconP1.x;
		gramlan.y = healthBarBG.y - 325;

		gramlan.animation.addByIndices('come','HP Gremlin ANIMATION',[0,1], "", 24, false);
		gramlan.animation.addByIndices('grab','HP Gremlin ANIMATION',[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], "", 24, false);
		gramlan.animation.addByIndices('hold','HP Gremlin ANIMATION',[25,26,27,28],"",24);
		gramlan.animation.addByIndices('release','HP Gremlin ANIMATION',[29,30,31,32,33],"",24,false);

		if (FlxG.save.data.aa)
			gramlan.antialiasing = true;
		else if (FlxG.save.data.aa)
			gramlan.antialiasing = false;

		if (FlxG.save.data.grem && FlxG.save.data.preload)
			add(gramlan);

		if(FlxG.save.data.downscroll){
			gramlan.flipY = true;
			gramlan.y -= 150;
		}
		
		// over use of flxtween :)

		var startHealth = health;
		var toHealth = (hpToTake / 100) * startHealth; // simple math, convert it to a percentage then get the percentage of the health

		var perct = toHealth / 2 * 100;

		trace('start: $startHealth\nto: $toHealth\nwhich is prect: $perct');

		var onc:Bool = false;

		FlxG.sound.play(Paths.sound('fourth/GremlinWoosh','clown'));

		gramlan.animation.play('come');
		new FlxTimer().start(0.14, function(tmr:FlxTimer) {
			gramlan.animation.play('grab');
			FlxTween.tween(gramlan,{x: iconP1.x - 140},1,{ease: FlxEase.elasticIn, onComplete: function(tween:FlxTween) {
				trace('I got em');
				gramlan.animation.play('hold');
				FlxTween.tween(gramlan,{
					x: (healthBar.x + 
					(healthBar.width * (FlxMath.remapToRange(perct, 0, 100, 100, 0) * 0.01) 
					- 26)) - 75}, duration,
				{
					onUpdate: function(tween:FlxTween) { 
						// lerp the health so it looks pog
						if (interupt && !onc && !persist)
						{
							onc = true;
							trace('oh shit');
							gramlan.animation.play('release');
							gramlan.animation.finishCallback = function(pog:String) { gramlan.alpha = 0;}
						}
						else if (!interupt || persist)
						{
							var pp = FlxMath.lerp(startHealth,toHealth, tween.percent);
							if (pp <= 0)
								pp = 0.1;
							health = pp;
						}

						if (shouldBeDead)
							health = 0;
					},
					onComplete: function(tween:FlxTween)
					{
						if (interupt && !persist)
						{
							remove(gramlan);
							grabbed = false;
						}
						else
						{
							trace('oh shit');
							gramlan.animation.play('release');
							if (persist && totalDamageTaken >= 0.7)
								health -= totalDamageTaken; // just a simple if you take a lot of damage wtih this, you'll loose probably.
							gramlan.animation.finishCallback = function(pog:String) { remove(gramlan);}
							grabbed = false;
						}
					}
				});
			}});
		});
	}

	var cloneOne:FlxSprite;
	var cloneTwo:FlxSprite;

	var scoobone:FlxSprite;
	var scoobtwo:FlxSprite;


	function doClone(side:Int)
	{
				switch(side)
				{
					case 0:
						if (cloneOne.alpha == 1)
							return;
						cloneOne.x = dad.x - 20;
						cloneOne.y = dad.y + 140;
						cloneOne.alpha = 1;

						cloneOne.animation.play('clone');
						cloneOne.animation.finishCallback = function(pog:String) {cloneOne.alpha = 0;}
					case 1:
						if (cloneTwo.alpha == 1)
							return;
						cloneTwo.x = dad.x + 390;
						cloneTwo.y = dad.y + 140;
						cloneTwo.alpha = 1;

						cloneTwo.animation.play('clone');
						cloneTwo.animation.finishCallback = function(pog:String) {cloneTwo.alpha = 0;}
				}
			

	}

	function doscoobClone(side:Int)
	{
		switch(side)
			{
				case 0:
					if (scoobone.alpha == 1)
						return;
					scoobone.x = dad.x - 220;
					scoobone.y = dad.y + 140;
					scoobone.alpha = 1;

					scoobone.animation.play('clone');
					scoobone.animation.finishCallback = function(pog:String) {scoobone.alpha = 0;}
				case 1:
					if (scoobtwo.alpha == 1)
						return;
					scoobtwo.x = dad.x + 190;
					scoobtwo.y = dad.y + 140;
					scoobtwo.alpha = 1;

					scoobtwo.animation.play('clone');
					scoobtwo.animation.finishCallback = function(pog:String) {scoobtwo.alpha = 0;}
			}
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

		var startTimer:FlxTimer;
		var perfectMode:Bool = false;
		var bfScared:Bool = false;

		function trickySecondCutscene():Void // why is this a second method? idk cry about it loL!!!!
		{
			var done:Bool = false;

			trace('starting cutscene');

			var black:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
			black.scrollFactor.set();
			black.alpha = 0;
			
			var animation:FlxSprite = new FlxSprite(200,300); // create the fuckin thing

			animation.frames = Paths.getSparrowAtlas('trickman','clown'); // add animation from sparrow
			animation.antialiasing = true;
			animation.animation.addByPrefix('cut1','Cutscene 1', 24, false);
			animation.animation.addByPrefix('cut2','Cutscene 2', 24, false);
			animation.animation.addByPrefix('cut3','Cutscene 3', 24, false);
			animation.animation.addByPrefix('cut4','Cutscene 4', 24, false);
			animation.animation.addByPrefix('pillar','Pillar Beam Tricky', 24, false);
			
			animation.setGraphicSize(Std.int(animation.width * 1.5));

			animation.alpha = 0;

			camFollow.setPosition(dad.getMidpoint().x + 300, boyfriend.getMidpoint().y - 200);

			inCutscene = true;
			startedCountdown = false;
			generatedMusic = false;
			canPause = false;

			FlxG.sound.music.volume = 0;
			vocals.volume = 0;

			var sounders:FlxSound = new FlxSound().loadEmbedded(Paths.sound('honkers','clown'));
			var energy:FlxSound = new FlxSound().loadEmbedded(Paths.sound('energy shot','clown'));
			var roar:FlxSound = new FlxSound().loadEmbedded(Paths.sound('sound_clown_roar','clown'));
			var pillar:FlxSound = new FlxSound().loadEmbedded(Paths.sound('firepillar','clown'));

			var fade:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
			fade.scrollFactor.set();
			fade.alpha = 0;

			var textFadeOut:FlxText = new FlxText(300,FlxG.height * 0.5,0,"TO BE CONTINUED");
			textFadeOut.setFormat("Impact", 128, FlxColor.RED);

			textFadeOut.alpha = 0;

			add(animation);

			add(black);

			add(textFadeOut);

			add(fade);

			var startFading:Bool = false;
			var varNumbaTwo:Bool = false;
			var fadeDone:Bool = false;

			sounders.fadeIn(30);

			new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
					if (fade.alpha != 1 && !varNumbaTwo)
					{
						camHUD.alpha -= 0.1;
						fade.alpha += 0.1;
						if (fade.alpha == 1)
						{
							// THIS IS WHERE WE LOAD SHIT UN-NOTICED
							varNumbaTwo = true;

							animation.alpha = 1;
							
							dad.alpha = 0;
						}
						tmr.reset(0.1);
					}
					else
					{
						fade.alpha -= 0.1;
						if (fade.alpha <= 0.5)
							fadeDone = true;
						tmr.reset(0.1);
					}
				});

			var roarPlayed:Bool = false;

			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				if (!fadeDone)
					tmr.reset(0.1)
				else
				{
					if (animation.animation == null || animation.animation.name == null)
					{
						trace('playin cut cuz its funny lol!!!');
						animation.animation.play("cut1");
						resetSpookyText = false;
						createSpookyText(cutsceneText[1], 260, FlxG.height * 0.9);
					}

					if (!animation.animation.finished)
					{
						tmr.reset(0.1);
						trace(animation.animation.name + ' - FI ' + animation.animation.frameIndex);

						switch(animation.animation.frameIndex)
						{
							case 104:
								if (animation.animation.name == 'cut1')
									resetSpookyTextManual();
						}

						if (animation.animation.name == 'pillar')
						{
							if (animation.animation.frameIndex >= 85) // why is this not in the switch case above? idk cry about it
								startFading = true;
							FlxG.camera.shake(0.05);
						}
					}
					else
					{
						trace('completed ' + animation.animation.name);
						resetSpookyTextManual();
						switch(animation.animation.name)
						{
							case 'cut1':
								animation.animation.play('cut2');
							case 'cut2':
								animation.animation.play('cut3');
								energy.play();
							case 'cut3':
								animation.animation.play('cut4');
								resetSpookyText = false;
								createSpookyText(cutsceneText[2], 260, FlxG.height * 0.9);
								animation.x -= 100;
							case 'cut4':
								resetSpookyTextManual();
								sounders.fadeOut();
								pillar.fadeIn(4);
								animation.animation.play('pillar');
								animation.y -= 670;
								animation.x -= 100;
						}
						tmr.reset(0.1);
					}

					if (startFading)
					{
						sounders.fadeOut();
						trace('do the fade out and the text');
						if (black.alpha != 1)
						{
							tmr.reset(0.1);
							black.alpha += 0.02;

							if (black.alpha >= 0.7 && !roarPlayed)
							{
								roar.play();
								roarPlayed = true;
							}
						}
						else if (done)
						{
							endSong();
							FlxG.camera.stopFX();
						}
						else
						{
							done = true;
							tmr.reset(5);
						}
					}
				}
			});
		}


		public static var playCutscene:Bool = true;

		function trickyCutscene():Void // god this function is terrible
		{
			trace('starting cutscene');

			var playonce:Bool = false;

			
			trans = new FlxSprite(-400,-760);
			trans.frames = Paths.getSparrowAtlas('Jaws','clown');
			trans.antialiasing = true;

			trans.animation.addByPrefix("Close","Jaws smol", 24, false);
			
			trace(trans.animation.frames);

			trans.setGraphicSize(Std.int(trans.width * 1.6));

			trans.scrollFactor.set();

			trace('added trancacscas ' + trans);

	

			var faded:Bool = false;
			var wat:Bool = false;
			var black:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
			black.scrollFactor.set();
			black.alpha = 0;
			var black3:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
			black3.scrollFactor.set();
			black3.alpha = 0;
			var red:FlxSprite = new FlxSprite(-300, -120).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.fromRGB(19, 0, 0));
			red.scrollFactor.set();
			red.alpha = 1;
			inCutscene = true;
			//camFollow.setPosition(bf.getMidpoint().x + 80, bf.getMidpoint().y + 200);
			dad.alpha = 0;
			gf.alpha = 0;
			remove(boyfriend);
			var nevada:FlxSprite = new FlxSprite(260,FlxG.height * 0.7);
			nevada.frames = Paths.getSparrowAtlas('somewhere','clown'); // add animation from sparrow
			nevada.antialiasing = true;
			nevada.animation.addByPrefix('nevada', 'somewhere idfk', 24, false);
			var animation:FlxSprite = new FlxSprite(-50,200); // create the fuckin thing
			animation.frames = Paths.getSparrowAtlas('intro','clown'); // add animation from sparrow
			animation.antialiasing = true;
			animation.animation.addByPrefix('fuckyou','Symbol', 24, false);
			animation.setGraphicSize(Std.int(animation.width * 1.2));
			nevada.setGraphicSize(Std.int(nevada.width * 0.5));
			add(animation); // add it to the scene
			
			// sounds

			var ground:FlxSound = new FlxSound().loadEmbedded(Paths.sound('ground','clown'));
			var wind:FlxSound = new FlxSound().loadEmbedded(Paths.sound('wind','clown'));
			var cloth:FlxSound = new FlxSound().loadEmbedded(Paths.sound('cloth','clown'));
			var metal:FlxSound = new FlxSound().loadEmbedded(Paths.sound('metal','clown'));
			var buildUp:FlxSound = new FlxSound().loadEmbedded(Paths.sound('trickyIsTriggered','clown'));

			camHUD.visible = false;
			
			add(boyfriend);

			add(red);
			add(black);
			add(black3);

			add(nevada);

			add(trans);

			trans.animation.play("Close",false,false,18);
			trans.animation.pause();

			new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
				if (!wat)
					{
						tmr.reset(1.5);
						wat = true;
					}
					else
					{
					if (wat && trans.animation.frameIndex == 18)
					{
						trans.animation.resume();
						trace('playing animation...');
					}
				if (trans.animation.finished)
				{
				trace('animation done lol');
				new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{

						if (boyfriend.animation.finished && !bfScared)
							boyfriend.animation.play('idle');
						else if (boyfriend.animation.finished)
							boyfriend.animation.play('scared');
						if (nevada.animation.curAnim == null)
						{
							trace('NEVADA | ' + nevada);
							nevada.animation.play('nevada');
						}
						if (!nevada.animation.finished && nevada.animation.curAnim.name == 'nevada')
						{
							if (nevada.animation.frameIndex >= 41 && red.alpha != 0)
							{
								trace(red.alpha);
								red.alpha -= 0.1;
							}
							if (nevada.animation.frameIndex == 34)
								wind.fadeIn();
							tmr.reset(0.1);
						}
						if (animation.animation.curAnim == null && red.alpha == 0)
						{
							remove(red);
							trace('play tricky');
							animation.animation.play('fuckyou', false, false, 40);
						}
						if (!animation.animation.finished && animation.animation.curAnim.name == 'fuckyou' && red.alpha == 0 && !faded)
						{
							trace("animation loop");
							tmr.reset(0.01);

							// animation code is bad I hate this
							// :(

							
							switch(animation.animation.frameIndex) // THESE ARE THE SOUNDS NOT THE ACTUAL CAMERA MOVEMENT!!!!
							{
								case 73:
									ground.play();
								case 84:
									metal.play();
								case 170:
									if (!playonce)
									{
										resetSpookyText = false;
										createSpookyText(cutsceneText[0], 260, FlxG.height * 0.9);
										playonce = true;
									}
									cloth.play();
								case 192:
									resetSpookyTextManual();
									if (tstatic.alpha != 0)
										manuallymanuallyresetspookytextmanual();
									buildUp.fadeIn();
								case 219:
									trace('reset thingy');
									buildUp.fadeOut();
							}

						
							// im sorry for making this code.
							// TODO: CLEAN THIS FUCKING UP (switch case it or smth)

							if (animation.animation.frameIndex == 190)
								bfScared = true;

							if (animation.animation.frameIndex >= 115 && animation.animation.frameIndex < 200)
							{
								camFollow.setPosition(dad.getMidpoint().x + 150, boyfriend.getMidpoint().y + 50);
								if (FlxG.camera.zoom < 1.1)
									FlxG.camera.zoom += 0.01;
								else
									FlxG.camera.zoom = 1.1;
							}
							else if (animation.animation.frameIndex > 200 && FlxG.camera.zoom != defaultCamZoom)
							{
								FlxG.camera.shake(0.01, 3);
								if (FlxG.camera.zoom < defaultCamZoom || camFollow.y < boyfriend.getMidpoint().y - 50)
									{
										FlxG.camera.zoom = defaultCamZoom;
										camFollow.y = boyfriend.getMidpoint().y - 50;
									}
								else
									{
										FlxG.camera.zoom -= 0.008;
										camFollow.y = dad.getMidpoint().y -= 1;
									}
							}
							if (animation.animation.frameIndex >= 235)
								faded = true;
						}
						else if (red.alpha == 0 && faded)
						{
							trace('red gay');
							// animation finished, start a dialog or start the countdown (should also probably fade into this, aka black fade in when the animation gets done and black fade out. Or just make the last frame tranisiton into the idle animation)
							if (black.alpha != 1)
							{
								if (tstatic.alpha != 0)
									manuallymanuallyresetspookytextmanual();
								black.alpha += 0.4;
								tmr.reset(0.1);
								trace('increase blackness lmao!!!');
							}
							else
							{
								if (black.alpha == 1 && black.visible)
								{
									black.visible = false;
									black3.alpha = 1;
									trace('transision ' + black.visible + ' ' + black3.alpha);
									remove(animation);
									dad.alpha = 1;
									// why did I write this comment? I'm so confused
									// shitty layering but ninja muffin can suck my dick like mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
									remove(red);
									remove(black);
									remove(black3);
									dad.alpha = 1;
									gf.alpha = 1;
									add(black);
									add(black3);
									remove(tstatic);
									add(tstatic);
									tmr.reset(0.3);
									FlxG.camera.stopFX();
									camHUD.visible = true;
								}
								else if (black3.alpha != 0)
								{
									black3.alpha -= 0.1;
									tmr.reset(0.3);
									trace('decrease blackness lmao!!!');
								}
								else 
								{
									wind.fadeOut();
									startCountdown();
								}
							}
					}
				});
				}
				else
				{
					trace(trans.animation.frameIndex);
					if (trans.animation.frameIndex == 30)
						trans.alpha = 0;
					tmr.reset(0.1);
				}
				}
			});
		}

	var noticeB:Array<FlxText> = [];
	var nShadowB:Array<FlxText> = [];

	function startCountdown():Void
	{
		inCutscene = false;

		hudArrows = [];
		generateStaticArrows(0);
		generateStaticArrows(1);

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		if (SONG.song.toLowerCase() == "improbable-chaos")
			{
				dad.visible = true;
				godMoveShaggy = true;
				if (SONG.mania == 2)
				{
					new FlxTimer().start(0.2, function(cbt:FlxTimer)
						{
							if (ctrTime == 0)
							{
								var cText:Array<String> = ['A', 'S', 'D', 'F', 'S\nP\nA\nC\nE', 'H', 'J', 'K', 'L'];
			
								if (FlxG.save.data.dfjk == 2)
								{
									cText = ['A', 'S', 'D', 'F', 'S\nP\nA\nC\nE', '1', '2', '3', 'R\nE\nT\nU\nR\nN'];
								}
								var nJx = 100;
								for (i in 0...9)
								{
									noticeB[i] = new FlxText(0, 0, 0, cText[i], 32);
									noticeB[i].x = FlxG.width * 0.5 + nJx*i + 155;
									noticeB[i].y = 20;
									if (FlxG.save.data.downscroll)
									{
										noticeB[i].y = FlxG.height - 120;
										switch (i)
										{
											case 4:
												noticeB[i].y -= 160;
											case 8:
												if (FlxG.save.data.dfjk == 2)
												noticeB[i].y -= 190;
										}
									}
									noticeB[i].scrollFactor.set();
									//notice[i].alpha = 0;
			
									nShadowB[i] = new FlxText(0, 0, 0, cText[i], 32);
									nShadowB[i].x = noticeB[i].x + 4;
									nShadowB[i].y = noticeB[i].y + 4;
									nShadowB[i].scrollFactor.set();
			
									nShadowB[i].alpha = noticeB[i].alpha;
									nShadowB[i].color = 0x00000000;
			
									//notice.alpha = 0;
			
									add(nShadowB[i]);
									add(noticeB[i]);
								}
			
								
							}
							else
							{
								for (i in 0...9)
								{
									if (ctrTime < 600)
									{
										if (noticeB[i].alpha < 1)
										{
											noticeB[i].alpha += 0.02;
										}
									}
									else
									{
										noticeB[i].alpha -= 0.02;
									}
								}
							}
							for (i in 0...9)
							{
								nShadowB[i].alpha = noticeB[i].alpha;
							}
							ctrTime ++;
							cbt.reset(0.004);
						});
				}
				
				

				if (FlxG.save.data.characters)
				{
					new FlxTimer().start(0.4, function(fade:FlxTimer)
					{
						island.alpha += 0.05;
						tabi.alpha += 0.05;
						agoti.alpha += 0.05;
						cass.alpha += 0.05;
						tordbot.alpha += 0.05;
						zardy.alpha += 0.05;
						bob.alpha += 0.05;
						senpai.alpha += 0.05;

						whitty.alpha += 0.05;
						hex.alpha += 0.05;
						ruv.alpha += 0.05;
						matt.alpha += 0.05;
						shaggy.alpha += 0.05;
						pico.alpha += 0.05;
						hankchar.alpha += 0.05;
						garcello.alpha += 0.025;

						shaggyT.alpha += 0.05;
						senpaiT.alpha += 0.05;

						gfbg.alpha += 0.05;
						carolbg.alpha += 0.05;
						opheebopscoobbg.alpha += 0.05;
						sarvbg.alpha += 0.05;
						boomboxbg.alpha += 0.05;
						if (island.alpha < 1)
							{
								fade.reset(0.3);
							}
						else
						{
							tabi.alpha = 1;
							agoti.alpha = 1;
							cass.alpha = 1;
							tordbot.alpha = 1;
							zardy.alpha = 1;
							bob.alpha = 1;
							senpai.alpha = 1;
					
							whitty.alpha = 1;
							matt.alpha = 1;
							pico.alpha = 1;
							hankchar.alpha = 1;
							garcello.alpha = 0.5;
							shaggy.alpha = 1;
							ruv.alpha = 1;
							hex.alpha = 1;

							shaggyT.alpha = 0.3;
							senpaiT.alpha = 0.3;

							gfbg.alpha = 1;
							carolbg.alpha = 1;
							opheebopscoobbg.alpha = 1;
							sarvbg.alpha = 1;
							boomboxbg.alpha = 1;
							if (!FlxG.save.data.characters)
								{
									remove(tabi);
									remove(agoti);
									remove(cass);
									remove(tordbot);
									remove(zardy);
									remove(bob);
									remove(senpai);
									remove(whitty);
									remove(matt);
									remove(pico);
									remove(hankchar);
									remove(garcello);
									remove(shaggy);
									remove(ruv);
									remove(hex);
									remove(shaggyT);
									remove(senpaiT);
									remove(island);
									remove(cloneOne);
									remove(cloneTwo);
									remove(bobmadshake);
								}
							if (!FlxG.save.data.bgcharacters)
								{
									remove(gfbg);
									remove(carolbg);
									remove(opheebopscoobbg);
									remove(sarvbg);
									remove(boomboxbg);
								}
						}

					});
				}
				
			}

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			if (swagCounter < 4)
			{
				trace('dance moment');
				dad.dance();
				gf.dance();
				boyfriend.playAnim('idle');
			}
			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3'), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2'), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1'), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo'), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);

		if (SONG.song.toLowerCase() == 'improbable-chaos' || SONG.song.toLowerCase() == 'expurgation') // start the grem time
		{
			new FlxTimer().start(25, function(tmr:FlxTimer) {
				if (curStep < 2400)
				{
					if (canPause && !paused && health >= 1.5 && !grabbed)
						doGremlin(40,3);
					trace('checka ' + health);
					tmr.reset(25);
				}
			});
		}
	}

	var grabbed = false;

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		trace('starting song :D');
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		if (SONG.song.toLowerCase().contains('madness') && isStoryMode)
			FlxG.sound.music.onComplete = trickySecondCutscene;
		else
			FlxG.sound.music.onComplete = endSong;
		vocals.play();

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			if(!paused)
			resyncVocals();
		});
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			//some 5note changes
			var mn:Int = keyAmmo[mania]; //new var to determine max notes
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % mn);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] >= mn)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var daType = songNotes[3];

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, daType);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, daType);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
					else
					{
						sustainNote.strumTime -= FlxG.save.data.offset;
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
					swagNote.strumTime -= FlxG.save.data.offset;
				}
			}
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	var hudArrXPos:Array<Float>;
	var hudArrYPos:Array<Float>;

	private function generateStaticArrows(player:Int):Void
	{
		if (player == 1)
			{
				hudArrXPos = [];
				hudArrYPos = [];
			}
		for (i in 0...keyAmmo[mania])
			{
				// FlxG.log.add(i);
				babyArrow = new FlxSprite(685, strumLine.y);
				hudArrows.push(babyArrow);

			switch (curStage)
			{
				case 'school' | 'schoolEvil':
					babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [6]);
					babyArrow.animation.add('red', [7]);
					babyArrow.animation.add('blue', [5]);
					babyArrow.animation.add('purplel', [4]);

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.add('static', [0]);
							babyArrow.animation.add('pressed', [4, 8], 12, false);
							babyArrow.animation.add('confirm', [12, 16], 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.add('static', [1]);
							babyArrow.animation.add('pressed', [5, 9], 12, false);
							babyArrow.animation.add('confirm', [13, 17], 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.add('static', [2]);
							babyArrow.animation.add('pressed', [6, 10], 12, false);
							babyArrow.animation.add('confirm', [14, 18], 12, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.add('static', [3]);
							babyArrow.animation.add('pressed', [7, 11], 12, false);
							babyArrow.animation.add('confirm', [15, 19], 24, false);
					}
				
				default:
					if (FlxG.save.data.altnoteskin) 
						babyArrow.frames = Paths.getSparrowAtlas('altnoteassets/NOTE_assets');
					else
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

					
					babyArrow.antialiasing = true;
					//babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
					babyArrow.setGraphicSize(Std.int(babyArrow.width * Note.noteScale));

					var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
					var pPre:Array<String> = ['left', 'down', 'up', 'right'];
					switch (mania)
					{
						case 1:
							nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
							pPre = ['left', 'up', 'right', 'yel', 'down', 'dark'];
						case 2:
							nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
							pPre = ['left', 'down', 'up', 'right', 'white', 'yel', 'violet', 'black', 'dark'];
							babyArrow.x -= Note.tooMuch;

					}
					babyArrow.x += Note.swagWidth * i;
					babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
					babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
					babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 0;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;
			

			if (player == 1)
			{
				hudArrXPos.push(babyArrow.x);
				hudArrYPos.push(babyArrow.y);
				playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += -630;
			babyArrow.x += ((FlxG.width / 2) * player);

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;
		}

		super.closeSubState();
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	function truncateFloat( number : Float, precision : Int): Float {
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
		}
	var spookyText:FlxText;
	var spookyRendered:Bool = false;
	var spookySteps:Int = 0;
	var healthpercent:Float;
	var nps:Int = 0;
	var maxNPS:Int = 0;




	override public function update(elapsed:Float)
	{
		#if !debug
		perfectMode = false;
		#end

		switch(curStage)
		{
			case 'shaggyHell':
				var rotRate = curStep * 0.25;
				var rotRateSh = curStep / 6.5;
				var rotRateGf = curStep / 9.5 / 4;
				var derp = 12;

				if (godCutEnd)
				{
					if (curBeat < 32)
					{
						sh_r = 60;
					}
					else if (curStep >= 2655)
					{
						sh_r += (60 - sh_r) / 32;
					}
					else
					{
						sh_r = 600;
					}

					if ((curBeat >= 32 && curBeat < 48) || (curBeat >= 116 * 4 && curBeat < 132 * 4))
					{
						if (boyfriend.animation.curAnim.name.startsWith('idle'))
						{
							boyfriend.playAnim('scared', true);
						}
					}

					if (curBeat < 50*4)
					{
					}
					else if (curBeat < 66 * 4)
					{
						rotRateSh *= 1.2;
					}
					else if (curBeat < 116 * 4)
					{
					}
					else if (curBeat < 132 * 4)
					{
						rotRateSh *= 1.2;
					}
					var bf_toy = -1500 + Math.sin(rotRate) * 20;

					var sh_toy = -1950 + -Math.sin(rotRateSh * 2) * sh_r * 0.45;
					var sh_tox = -330 -Math.cos(rotRateSh) * sh_r;

					var gf_tox = 100 + Math.sin(rotRateGf) * 200;
					var gf_toy = -1500 -Math.sin(rotRateGf) * 80;

					if (godMoveBf)
					{
						boyfriend.y += (bf_toy - boyfriend.y) / derp;
						rock.x = boyfriend.x - 200;
						rock.y = boyfriend.y + 200;
						rock.alpha = 1;
						energyWall.y = boyfriend.y - 800;
					}

					if (godMoveSh)
					{
						dad.x += (sh_tox - dad.x) / 12;
						dad.y += (sh_toy - dad.y) / 12;

					}

					if (godMoveGf)
					{
						gf.x += (gf_tox - gf.x) / derp;
						gf.y += (gf_toy - gf.y) / derp;

						gf_rock.x = gf.x + 80;
						gf_rock.y = gf.y + 530;
						gf_rock.alpha = 1;
						if (!gf_launched)
						{
							gf.scrollFactor.set(0.8, 0.8);
							gf.setGraphicSize(Std.int(gf.width * 0.8));
							gf_launched = true;
						}
					}
				}
				if (!godCutEnd || !godMoveBf)
				{
					rock.alpha = 0;
				}
				if (!godMoveGf)
				{
					gf_rock.alpha = 0;
				}
	
		}



		var balls = notesHitArray.length-1;
		while (balls >= 0)
		{
			var cock:Date = notesHitArray[balls];
			if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
				notesHitArray.remove(cock);
			else
				balls = 0;
			balls--;
		}
		nps = notesHitArray.length;
		if (nps > maxNPS)
			maxNPS = nps;
		//healthpercent = (healthBar.percent * 2);
		healthTxt.text = ("Health: ") + Std.string(healthBar.percent * 2) + ("%");

		var rotRateShaggy = curStep / 9.5;

		var shaggy_toy = -850 + -Math.sin(rotRateShaggy * 2) * shaggy_r * 0.45;
		var shaggy_tox = 2030 -Math.cos(rotRateShaggy) * shaggy_r;

		if (godMoveShaggy)
			{
				shaggy.x += (shaggy_tox - shaggy.x) / 12;
				shaggy.y += (shaggy_toy - shaggy.y) / 12;
			}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		super.update(elapsed);

		playerStrums.forEach(function(spr:FlxSprite)
			{
				//spr.offset.set(spr.frameWidth / 2, spr.frameHeight / 2);
				spr.x = hudArrXPos[spr.ID];
				spr.y = hudArrYPos[spr.ID];
				if (spr.animation.curAnim.name == 'confirm')
				{
					var jj:Array<Float> = [0, 3, 9];
					spr.x = hudArrXPos[spr.ID] + jj[mania];
					spr.y = hudArrYPos[spr.ID] + jj[mania];
				}
			});

		scoreTxt.text = Ratings.CalculateRanking(songScore,0,nps,accuracy);

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			Main.editor = true;
			FlxG.switchState(new ChartingState());
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 4)
			health = 4;

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		//#if debug
		if (FlxG.keys.justPressed.EIGHT){
            if(FlxG.keys.pressed.SHIFT){
                FlxG.switchState(new AnimationDebug(SONG.player1));
            }
            else if(FlxG.keys.pressed.CONTROL){
                FlxG.switchState(new AnimationDebug(gf.curCharacter));
            }
            else{
                FlxG.switchState(new AnimationDebug(SONG.player2));
            }
        }
		//#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			if (curBeat % 4 == 0)
			{
				// trace(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			}
			

			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				if (istordbot)
					{
						camFollow.setPosition(tordbot.getMidpoint().x + 150, tordbot.getMidpoint().y - 700);
					}
				else 
				{
					camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				}
					// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

					switch (dad.curCharacter)
					{
						case 'mom':
							camFollow.y = dad.getMidpoint().y;
						case 'trickyMask':
							camFollow.y = dad.getMidpoint().y + 25;
						case 'trickyH':
							camFollow.y = dad.getMidpoint().y + 375;
						case 'senpai':
							camFollow.y = dad.getMidpoint().y - 430;
							camFollow.x = dad.getMidpoint().x - 100;
						case 'senpai-angry':
							camFollow.y = dad.getMidpoint().y - 430;
							camFollow.x = dad.getMidpoint().x - 100;
					}

					if (dad.curCharacter == 'mom')
						vocals.volume = 1;

					if (SONG.song.toLowerCase() == 'tutorial')
					{
						tweenCamIn();
					}
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100)
			{
				if (isshaggy)
					{
						camFollow.setPosition(shaggy.getMidpoint().x - 100, shaggy.getMidpoint().y);
					}
				else {
					camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 300);
				}
				if (SONG.song.toLowerCase() == 'tutorial')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
				}
			}
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			//camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);
		if (loadRep) // rep debug
			{
				FlxG.watch.addQuick('rep rpesses',repPresses);
				FlxG.watch.addQuick('rep releases',repReleases);
				// FlxG.watch.addQuick('Queued',inputsQueued);
			}
		if (health <= 0)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}
		// this is where I overuse FlxG.Random :)
		if (spookyRendered) // move shit around all spooky like
			{
				spookyText.angle = FlxG.random.int(-5,5); // change its angle between -5 and 5 so it starts shaking violently.
				//tstatic.x = tstatic.x + FlxG.random.int(-2,2); // move it back and fourth to repersent shaking.
				if (tstatic.alpha != 0)
					tstatic.alpha = FlxG.random.float(0.1,0.5); // change le alpha too :)
			}

		
			if (generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.y > FlxG.height)
						{
							daNote.active = false;
							daNote.visible = false;
						}
						else
						{
							daNote.visible = true;
							daNote.active = true;
						}
		
						if (!daNote.mustPress && daNote.wasGoodHit)
						{
							if (SONG.song != 'Tutorial')
								camZooming = true;
		
							var altAnim:String = "";
		
							if (SONG.notes[Math.floor(curStep / 16)] != null)
							{
								if (SONG.notes[Math.floor(curStep / 16)].altAnim)
									altAnim = '-alt';
							}
							if (daNote.noteType == 4)
							{
								if (FlxG.save.data.effects)
									FlxG.sound.play(Paths.sound('shooters', 'shared'), 0.6);
							}
		


							var dadsDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
							if (mania == 1)
							{
								dadsDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
							}
							else if (mania == 2)
							{
								dadsDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
							}
							switch (curStage)
							{
								case 'auditorHell':
									if (isbob)
										{
											//bob.playAnim('sing' + dadsDir[daNote.noteData], true);
											bob.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00005;
												} 
												else
													health -= 0.0005;
										}
									if (issky)
										{
											cass.playAnim('sing' + dadsDir[daNote.noteData], true);
											cass.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.01;
										}
									if (isagoti)
										{
											agoti.playAnim('sing' + dadsDir[daNote.noteData], true);
											agoti.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.01;
										}
									if (istordbot)
										{
											tordbot.playAnim('sing' + dadsDir[daNote.noteData], true);
											tordbot.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.01;
										}
									if (iszardy)
										{
											zardy.playAnim('sing' + dadsDir[daNote.noteData], true);
											zardy.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.01;
										}
									if (issenpai)
										{
											senpai.playAnim('sing' + dadsDir[daNote.noteData], true);
											senpai.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.005;
										}
									if (istabi)
										{
											tabi.playAnim('sing' + dadsDir[daNote.noteData], true);
											tabi.holdTimer = 0;
											if (FlxG.save.data.effects)
												FlxG.camera.shake(0.008, 0.02, null, true);
											if (daNote.isSustainNote)
												{
													health -= 0.00025;
												} 
												else 
													health -= 0.015;
										}
									if (istricky)
										{
											dad.playAnim('sing' + dadsDir[daNote.noteData], true);
											dad.holdTimer = 0;
											if (daNote.isSustainNote)
												{
													health -= 0.00015;
												} 
												else 
													health -= 0.004;
										}
								case 'shaggyHell': 
									if (cameragocrazy)
										{
											FlxTween.tween(FlxG.camera, {zoom: 0.45}, 0.15);
											FlxTween.tween(camHUD, {zoom: 0.8}, 0.1);
											new FlxTimer().start(0.1, function(tmr7:FlxTimer)
												{
													//camHUD.zoom = 0.9;
													//FlxG.camera.zoom = 0.55;
													FlxTween.tween(FlxG.camera, {zoom: 0.55}, 0.1);
													FlxTween.tween(camHUD, {zoom: 0.9}, 0.1);
												});
										}
									if (spinnyboi)
										{
											for (str in playerStrums){
												str.angle = str.angle + SpinAmount;
												SpinAmount = SpinAmount + 0.05;
											}
										}
									else if (!spinnyboi)
										{
											for (str in playerStrums){
												str.angle = 0;
											}
										}
									dad.playAnim('sing' + dadsDir[daNote.noteData], true);
									dad.holdTimer = 0;
									if (daNote.isSustainNote)
										{
											health -= 0.00020;
										} 
										else
											health -= 0.0075;
									
							}
							

							
								//319, 
								//1423 - 1441, 1631

		
							switch(dad.curCharacter)
							{
								case 'trickyMask': // 1% chance
									if (FlxG.random.bool(1) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
										{
											createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
										}
								case 'tricky': // 20% chance
									if (FlxG.random.bool(20) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
										{
											createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
										}
								case 'trickyH': // 45% chance
									if (FlxG.random.bool(45) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
										{
											createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
										}
									FlxG.camera.shake(0.02,0.2);
								case 'exTricky': // 60% chance
									if (istricky && FlxG.save.data.effects)
									{
										if (FlxG.random.bool(30) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
											{
												createSpookyText(ExTrickyLinesSing[FlxG.random.int(0,ExTrickyLinesSing.length)]);
											}
									}
							}
		
		
							//dad.holdTimer = 0;
		
							if (SONG.needsVoices)
								vocals.volume = 1;
		
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
		

						if (FlxG.save.data.downscroll)
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2)));	
						else
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(FlxG.save.data.scrollSpeed == 1 ? SONG.speed : FlxG.save.data.scrollSpeed, 2)));
						
						daNote.y -= (daNote.burning ? ((curStage != 'auditorHell' && FlxG.save.data.downscroll) ? 185 : 65 ) : 0);
		
						// WIP interpolation shit? Need to fix the pause issue
						// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
		
						if (daNote.y < -daNote.height && !FlxG.save.data.downscroll || daNote.y >= strumLine.y + 106 && FlxG.save.data.downscroll)
						{
							switch (daNote.noteType)
							{
						
								case 0: //normal
								{
									if (daNote.isSustainNote && daNote.wasGoodHit)
										{

											daNote.kill();
											notes.remove(daNote, true);
											daNote.destroy();
											
										}
									else
										{
											if (daNote.mustPress)
											{
												health -= 0.075;
												vocals.volume = 0;
												noteMiss(daNote.noteData);

											}
										}
					
										daNote.active = false;
										daNote.visible = false;
					
										daNote.kill();
										notes.remove(daNote, true);
										daNote.destroy();
								}
								case 1: //kill note, Thank you srPerez so much i couldnt figure this shit out thank you thank yo thank you
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 2: 
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 4: 
									health -= 1;
									if (FlxG.save.data.effects)
										FlxG.sound.play(Paths.sound('shooters', 'shared'), 1);
									vocals.volume = 0;
									noteMiss(daNote.noteData);
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								case 5: 
									{
										daNote.kill();
										notes.remove(daNote, true);
										daNote.destroy();
									}
								case 6: 
									killplayer();
									FlxG.sound.play(Paths.sound('death', 'clown'));
									noteMiss(daNote.noteData);
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
							}	
						}
						
					});
				}

		if (!inCutscene)
			keyShit();

		/*
			if (FlxG.keys.justPressed.ONE)
				trickySecondCutscene();
		*/
	}

	function createSpookyText(text:String, x:Float = -1111111111111, y:Float = -1111111111111):Void
	{
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound','clown'));
		spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(dad.x + 40,dad.x + 120) : x), (y == -1111111111111 ? FlxG.random.float(dad.y + 200, dad.y + 300) : y));
		spookyText.setFormat("Impact", 128, FlxColor.RED);
		if (curStage == 'nevedaSpook')
		{
			spookyText.size = 200;
			spookyText.x += 250;
		}
		spookyText.bold = true;
		spookyText.text = text;
		add(spookyText);
	}

	public function endSong():Void
	{
		var song = SONG.song;
		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
			#if !switch
			Highscore.saveScore(SONG.song, songScore, storyDifficulty);
			#end
		

		if (isStoryMode)
		{
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;

			campaignScore += songScore;

			storyPlaylist.remove(storyPlaylist[0]);

			if (storyPlaylist.length <= 0)
			{
				FlxG.switchState(new MainMenuState());
				MainMenuState.reRoll = true;

				if (storyDifficulty == 2)
					FlxG.save.data.beatenHardIC = true;
				if (storyDifficulty >= 1)
					FlxG.save.data.beatenIC = true;

				FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
				FlxG.save.flush();
			}
			else
			{
				var difficulty:String = "";

				if (storyDifficulty == 0)
					difficulty = '-easy';

				if (storyDifficulty == 2)
					difficulty = '-hard';

				if (storyDifficulty == 3)
					difficulty = '-4kold';
				if (storyDifficulty == 4)
					difficulty = '-6kold';
				if (storyDifficulty == 5)
					difficulty = '-9kold';

				if (storyDifficulty == 6)
					difficulty = '-4koldv1';
				if (storyDifficulty == 7)
					difficulty = '-6koldv1';
				if (storyDifficulty == 8)
					difficulty = '-9koldv1';

				trace('LOADING NEXT SONG');
				trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

				if (SONG.song.toLowerCase() == 'eggnog')
				{
					var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
						-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
					blackShit.scrollFactor.set();
					add(blackShit);
					camHUD.visible = false;

					FlxG.sound.play(Paths.sound('Lights_Shut_off'));
				}

				prevCamFollow = camFollow;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
				FlxG.sound.music.stop();
				switch(song.toLowerCase())
				{
					case 'improbable-outset':
						LoadingState.loadAndSwitchState(new VideoState("assets/videos/HankFuckingShootsTricky.webm", new PlayState()));
					case 'madness':
						LoadingState.loadAndSwitchState(new VideoState("assets/videos/HELLCLOWN_ENGADGED.webm",new PlayState()));
					default:
						FlxG.switchState(new MainMenuState());
						MainMenuState.reRoll = true;
				}
			}
		}
		else
		{
			if (song.toLowerCase() == "expurgation")
				FlxG.save.data.beatExShaggy = true;

			FlxG.switchState(new MainMenuState());
			MainMenuState.reRoll = true;
		}
	}

	
	function toPlay() {FlxG.switchState(new PlayState());}
	function toMenu() {FlxG.switchState(new MainMenuState());}

	var endingSong:Bool = false;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = Math.abs(Conductor.songPosition - daNote.strumTime);
			var wife:Float = EtternaFunctions.wife3(noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
	
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;

			var healthDrain:Float = 0;

			if (SONG.song.toLowerCase() == 'hellclown')
				healthDrain = 0.04;

			switch(daRating)
			{
				case 'shit':
					if (daNote.noteType == 2)
						{
							health -= 2;
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}

					else if (daNote.noteType == 5)
						{
							killplayer();
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else if (daNote.noteType == 4)
						{
							if (FlxG.save.data.effects)
								FlxG.sound.play(Paths.sound('shooters', 'shared'), 0.4);
						}
					if (daNote.noteType == 1)
						{
							if (grabbed)
								{
									killplayer();
								}
								interupt = true;
								health -= 2;
								FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else 
						{
							score = -300;
							combo = 0;
							misses++;
							health -= 0.2;
							totalDamageTaken += 0.2;
							interupt = true;
							ss = false;
							shits++;
						}
					
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.25;
				case 'bad':
					if (daNote.noteType == 2)
						{
							health -= 0.6;
							FlxG.sound.play(Paths.sound('energy shot', 'clown'));
						}
					else if (daNote.noteType == 4)
						{
							if (FlxG.save.data.effects)
								FlxG.sound.play(Paths.sound('shooters', 'shared'), 0.4);
						}
					else if (daNote.noteType == 5)
						{
							killplayer();
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					if (daNote.noteType == 1)
						{
							if (grabbed)
								{
									killplayer();
								}
								interupt = true;
								health -= 2;
								FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else 
						{
							daRating = 'bad';
							score = 0;
							health -= 0.06;
							totalDamageTaken += 0.06;
							interupt = true;
							ss = false;
							bads++;
						}
					
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
				case 'good':
					if (daNote.noteType == 2)
						{
							interupt = true;
							health += 0.4;
						}
					else if (daNote.noteType == 1)
						{
							if (grabbed)
								{
									killplayer();
								}
							interupt = true;
							health -= 2;
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else if (daNote.noteType == 5)
						{
							killplayer();
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else if (daNote.noteType == 4)
						{
							FlxG.sound.play(Paths.sound('shooters', 'shared'), 0.4);
						}
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (health < 2 && !grabbed)
						if (!FlxG.save.data.ghost)
							{
								health += 0.065;
							}
						else
							health += 0.04;

						
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
				case 'sick':
					if (daNote.noteType == 2)
						{
							interupt = true;
							health += 1;
							FlxG.sound.play(Paths.sound('thunder_2'));
						}
					else if (daNote.noteType == 1)
						{
							if (grabbed)
							{
								killplayer();
							}
							interupt = true;
							health -= 2;
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else if (daNote.noteType == 5)
						{
							killplayer();
							FlxG.sound.play(Paths.sound('death', 'clown'));
						}
					else if (daNote.noteType == 4)
						{
							if (FlxG.save.data.effects)
								FlxG.sound.play(Paths.sound('shooters', 'shared'), 0.4);
						}
					if (health < 2 && !grabbed)
						if (!FlxG.save.data.ghost)
							{
								health += 0.2 - healthDrain;
							}
						else
							health += 0.1 - healthDrain;					
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);


			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = true;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = true;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}

			comboSpr.updateHitbox();
			rating.updateHitbox();
	
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			if (comboSplit.length == 2)
				seperatedScore.push(0); // make sure theres a 0 in front or it looks weird lol!

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = true;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				if (combo >= 10 || combo == 0)
					add(numScore);
	
				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}



	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}


	// anti mash functions :D (soon TM)

	public function canHit(controlArray:Array<Bool>, noteArray:Array<Note>):Bool
	{
		var hit:Bool = true;

		if (noteArray == null)
			return true;

		var baseStrum:Float = noteArray[0].strumTime;

		for(i in 0...noteArray.length)
		{
			var n:Note = noteArray[i];
			if (!controlArray[n.noteData])
				hit = false;
		}
		return hit;
	}




	var upHold:Bool = false;
	var downHold:Bool = false;
	var rightHold:Bool = false;
	var leftHold:Bool = false;	

	var l1Hold:Bool = false;
	var uHold:Bool = false;
	var r1Hold:Bool = false;
	var l2Hold:Bool = false;
	var dHold:Bool = false;
	var r2Hold:Bool = false;

	var n0Hold:Bool = false;
	var n1Hold:Bool = false;
	var n2Hold:Bool = false;
	var n3Hold:Bool = false;
	var n4Hold:Bool = false;
	var n5Hold:Bool = false;
	var n6Hold:Bool = false;
	var n7Hold:Bool = false;
	var n8Hold:Bool = false;

	var noteHit:Int = 0;
	private function keyShit():Void // I've invested in emma stocks
		{
			var control = PlayerSettings.player1.controls;

			// control arrays, order L D R U
			var holdArray:Array<Bool> = [control.LEFT, control.DOWN, control.UP, control.RIGHT, control.L1, control.U1, control.R1, control.L2, control.D1, control.R2, control.N0, control.N1, control.N2, control.N3, control.N4, control.N5, control.N6, control.N7, control.N8];
			var pressArray:Array<Bool> = [
				control.LEFT_P,
				control.DOWN_P,
				control.UP_P,
				control.RIGHT_P,
				control.L1_P,
				control.U1_P,
				control.R1_P,
				control.L2_P,
				control.D1_P,
				control.R2_P,
				control.N0_P,
				control.N1_P,
				control.N2_P,
				control.N3_P,
				control.N4_P,
				control.N5_P,
				control.N6_P,
				control.N7_P,
				control.N8_P
			];
			var releaseArray:Array<Bool> = [
				control.LEFT_R,
				control.DOWN_R,
				control.UP_R,
				control.RIGHT_R,
				control.L1_R,
				control.U1_R,
				control.R1_R,
				control.L2_R,
				control.D1_R,
				control.R2_R,
				control.N0_R,
				control.N1_R,
				control.N2_R,
				control.N3_R,
				control.N4_R,
				control.N5_R,
				control.N6_R,
				control.N7_R,
				control.N8_R
			];

			var up = controls.UP;
			var right = controls.RIGHT;
			var down = controls.DOWN;
			var left = controls.LEFT;

			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;

			var l1 = controls.L1;
			var u = controls.U1;
			var r1 = controls.R1;
			var l2 = controls.L2;
			var d = controls.D1;
			var r2 = controls.R2;

			var l1P = controls.L1_P;
			var uP = controls.U1_P;
			var r1P = controls.R1_P;
			var l2P = controls.L2_P;
			var dP = controls.D1_P;
			var r2P = controls.R2_P;

			var n0 = controls.N0;
			var n1 = controls.N1;
			var n2 = controls.N2;
			var n3 = controls.N3;
			var n4 = controls.N4;
			var n5 = controls.N5;
			var n6 = controls.N6;
			var n7 = controls.N7;
			var n8 = controls.N8;

			var n0P = controls.N0_P;
			var n1P = controls.N1_P;
			var n2P = controls.N2_P;
			var n3P = controls.N3_P;
			var n4P = controls.N4_P;
			var n5P = controls.N5_P;
			var n6P = controls.N6_P;
			var n7P = controls.N7_P;
			var n8P = controls.N8_P;

			var upR = controls.UP_R;
			var rightR = controls.RIGHT_R;
			var downR = controls.DOWN_R;
			var leftR = controls.LEFT_R;

			var l1R = controls.L1_R;
			var uR = controls.U1_R;
			var r1R = controls.R1_R;
			var l2R = controls.L2_R;
			var dR = controls.D1_R;
			var r2R = controls.R2_R;

			var n0R = controls.N0_R;
			var n1R = controls.N1_R;
			var n2R = controls.N2_R;
			var n3R = controls.N3_R;
			var n4R = controls.N4_R;
			var n5R = controls.N5_R;
			var n6R = controls.N6_R;
			var n7R = controls.N7_R;
			var n8R = controls.N8_R;

			var ex1 = false;
	 
			// HOLDS, check for sustain notes
			if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData] && daNote.alpha != 0.1)
						goodNoteHit(daNote);
				});
			}
			var controlArray:Array<Bool> = [leftP, downP, upP, rightP];

	 
			var ankey = (upP || rightP || downP || leftP);
			if (mania == 1)
			{ 
				ankey = (l1P || uP || r1P || l2P || dP || r2P);
				controlArray = [l1P, uP, r1P, l2P, dP, r2P];
			}
			else if (mania == 2)
			{
				ankey = (n0P || n1P || n2P || n3P || n4P || n5P || n6P || n7P || n8P);
				controlArray = [n0P, n1P, n2P, n3P, n4P, n5P, n6P, n7P, n8P];
			}
			if (ankey && !boyfriend.stunned && generatedMusic)
				{
					repPresses++;
					boyfriend.holdTimer = 0;
		
					var possibleNotes:Array<Note> = [];
		
					var ignoreList:Array<Int> = [1];
		
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
						{
							// the sorting probably doesn't need to be in here? who cares lol
							possibleNotes.push(daNote);
							possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
		
							ignoreList.push(daNote.noteType);
						}
					});
		
					if (possibleNotes.length > 0)
					{
						var daNote = possibleNotes[0];
						
		
						// Jump notes
						if (possibleNotes.length >= 2)
						{
							if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
							{
								for (coolNote in possibleNotes)
									{
										if (coolNote.burning)
										{
											if (curStage == 'auditorHell')
											{
												// lol death
												health = 0;
												shouldBeDead = true;
												FlxG.sound.play(Paths.sound('death'));
											}
										}
										var inIgnoreList:Bool = false; 

										if (controlArray[coolNote.noteData])
											goodNoteHit(coolNote);
										else
										{
											//var inIgnoreList:Bool = false;
											//for (shit in 0...ignoreList.length)
											//{
												//if (controlArray[ignoreList[shit]])
													//inIgnoreList = true;
											//}
											if (!inIgnoreList && !theFunne && startedCountdown && !cs_reset && !grace)
												if (coolNote.noteType == 1)
													{
														missType = 1;
														badNoteCheck();
														//goodNoteHit(daNote);
													}
												else{
													missType = 0;
													badNoteCheck();
													//goodNoteHit(daNote);
												}
												
										}
									}
							}
							else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
							{
								if (loadRep)
								{
									if (NearlyEquals(daNote.strumTime,rep.replay.keyPresses[repPresses].time, 30))
									{
										goodNoteHit(daNote);
										trace('force note hit');
									}
									else
										noteCheck(controlArray, daNote);
								}
								else
									noteCheck(controlArray, daNote);
							}
							else
							{
								for (coolNote in possibleNotes)
								{
									if (loadRep)
										{
											if (NearlyEquals(coolNote.strumTime,rep.replay.keyPresses[repPresses].time, 30))
											{
												goodNoteHit(coolNote);
												trace('force note hit');
											}
											else
												noteCheck(controlArray, daNote);
										}
									else
										noteCheck(controlArray, coolNote);
								}
							}
						}
						else // regular notes?
						{	
							if (loadRep)
							{
								if (NearlyEquals(daNote.strumTime,rep.replay.keyPresses[repPresses].time, 30))
								{
									goodNoteHit(daNote);
									trace('force note hit');
								}
								else
									noteCheck(controlArray, daNote);
							}
							else
								noteCheck(controlArray, daNote);
						}
						/* 
							if (controlArray[daNote.noteData])
								goodNoteHit(daNote);
						*/
						// trace(daNote.noteData);
						/* 
							switch (daNote.noteData)
							{
								case 2: // NOTES YOU JUST PRESSED
									if (upP || rightP || downP || leftP)
										noteCheck(upP, daNote);
								case 3:
									if (upP || rightP || downP || leftP)
										noteCheck(rightP, daNote);
								case 1:
									if (upP || rightP || downP || leftP)
										noteCheck(downP, daNote);
								case 0:
									if (upP || rightP || downP || leftP)
										noteCheck(leftP, daNote);
							}
						*/
						if (daNote.wasGoodHit)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
						
					}
					else if (!theFunne && startedCountdown && !cs_reset && !grace)
					{
							badNoteCheck();
					}
					else if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								if (pressArray[shit])
									noteMiss(shit);
						}
				}
				
				var condition = ((up || right || down || left) && generatedMusic || (upHold || downHold || leftHold || rightHold) && loadRep && generatedMusic);
				if (mania == 1)
				{
					condition = ((l1 || u || r1 || l2 || d || r2) && generatedMusic || (l1Hold || uHold || r1Hold || l2Hold || dHold || r2Hold) && loadRep && generatedMusic);
				}
				else if (mania == 2)
				{
					condition = ((n0 || n1 || n2 || n3 || n4 || n5 || n6 || n7 || n8) && generatedMusic || (n0Hold || n1Hold || n2Hold || n3Hold || n4Hold || n5Hold || n6Hold || n7Hold || n8Hold) && loadRep && generatedMusic);
				}
				if (condition)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
						{
							//goodNoteHit(daNote);
							if (mania == 0)
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 2:
										if (up || upHold)
											goodNoteHit(daNote);
									case 3:
										if (right || rightHold)
											goodNoteHit(daNote);
									case 1:
										if (down || downHold)
											goodNoteHit(daNote);
									case 0:
										if (left || leftHold)
											goodNoteHit(daNote);
								}
							}
							else if (mania == 1)
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 0:
										if (l1 || l1Hold)
											goodNoteHit(daNote);
									case 1:
										if (u || uHold)
											goodNoteHit(daNote);
									case 2:
										if (r1 || r1Hold)
											goodNoteHit(daNote);
									case 3:
										if (l2 || l2Hold)
											goodNoteHit(daNote);
									case 4:
										if (d || dHold)
											goodNoteHit(daNote);
									case 5:
										if (r2 || r2Hold)
											goodNoteHit(daNote);
								}
							}
							else
							{
								switch (daNote.noteData)
								{
									// NOTES YOU ARE HOLDING
									case 0: if (n0 || n0Hold) goodNoteHit(daNote);
									case 1: if (n1 || n1Hold) goodNoteHit(daNote);
									case 2: if (n2 || n2Hold) goodNoteHit(daNote);
									case 3: if (n3 || n3Hold) goodNoteHit(daNote);
									case 4: if (n4 || n4Hold) goodNoteHit(daNote);
									case 5: if (n5 || n5Hold) goodNoteHit(daNote);
									case 6: if (n6 || n6Hold) goodNoteHit(daNote);
									case 7: if (n7 || n7Hold) goodNoteHit(daNote);
									case 8: if (n8 || n8Hold) goodNoteHit(daNote);
								}
							}
						}
					});
				}
		
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !up && !down && !right && !left)
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
					{
						boyfriend.playAnim('idle');
					}
				}
		
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (mania == 0)
					{
						switch (spr.ID)
						{
							case 2:
								if (upP && spr.animation.curAnim.name != 'confirm')
								{
									spr.animation.play('pressed');
									trace('play');
								}
								if (upR)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 3:
								if (rightP && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (rightR)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 1:
								if (downP && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (downR)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 0:
								if (leftP && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (leftR)
								{
									spr.animation.play('static');
									repReleases++;
								}
						}
					}
					else if (mania == 1)
					{
						switch (spr.ID)
						{
							case 0:
								if (l1P && spr.animation.curAnim.name != 'confirm')
								{
									spr.animation.play('pressed');
									trace('play');
								}
								if (l1R)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 1:
								if (uP && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (uR)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 2:
								if (r1P && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (r1R)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 3:
								if (l2P && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (l2R)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 4:
								if (dP && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (dR)
								{
									spr.animation.play('static');
									repReleases++;
								}
							case 5:
								if (r2P && spr.animation.curAnim.name != 'confirm')
									spr.animation.play('pressed');
								if (r2R)
								{
									spr.animation.play('static');
									repReleases++;
								}
						}
					}
					else if (mania == 2)
					{
						switch (spr.ID)
						{
							case 0:
								if (n0P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n0R) spr.animation.play('static');
							case 1:
								if (n1P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n1R) spr.animation.play('static');
							case 2:
								if (n2P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n2R) spr.animation.play('static');
							case 3:
								if (n3P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n3R) spr.animation.play('static');
							case 4:
								if (n4P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n4R) spr.animation.play('static');
							case 5:
								if (n5P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n5R) spr.animation.play('static');
							case 6:
								if (n6P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n6R) spr.animation.play('static');
							case 7:
								if (n7P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n7R) spr.animation.play('static');
							case 8:
								if (n8P && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
								if (n8R) spr.animation.play('static');
						}
					}
					
					if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
					{
						spr.centerOffsets();
						spr.offset.x -= 13;
						spr.offset.y -= 13;
					}
					else
						spr.centerOffsets();
				});
		}


	function noteMiss(direction:Int = 1):Void
	{
		if (!boyfriend.stunned)
		{
			if (!FlxG.save.data.ghost)
			{
				health -= 0.03;
				totalDamageTaken += 0.02;
			}
			else 
			{
				health -= 0.04;
				totalDamageTaken += 0.04;
			}
			interupt = true;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			songScore -= 10;

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');


			if (dad.curCharacter.toLowerCase().contains("tricky") && FlxG.random.bool(dad.curCharacter == "tricky" ? 10 : 4) && !spookyRendered && curStage == "nevada") // create spooky text :flushed:
				createSpookyText(TrickyLinesMiss[FlxG.random.int(0,TrickyLinesMiss.length)]);
				

			// FlxG.sound.play('assets/sounds/missnote1' + TitleState.soundExt, 1, false);
			// FlxG.log.add('played imss note');
			if (isbf)
			{
				switch (direction)
				{
					case 0:
						boyfriend.playAnim('singLEFTmiss', true);
						//CharL2.playAnim('singLEFTmiss', true); old chracter switch code
						//CharL3.playAnim('singLEFTmiss', true);
					case 1:
						boyfriend.playAnim('singDOWNmiss', true);
						//CharL2.playAnim('singDOWNmiss', true);
						//CharL3.playAnim('singDOWNmiss', true);
					case 2:
						boyfriend.playAnim('singUPmiss', true);
						//CharL2.playAnim('singUPmiss', true);
						//CharL3.playAnim('singUPmiss', true);
					case 3:
						boyfriend.playAnim('singRIGHTmiss', true);
						//CharL2.playAnim('singRIGHTmiss', true);
						//CharL3.playAnim('singRIGHTmiss', true);
					case 4:
						boyfriend.playAnim('singDOWNmiss', true);
						//CharL2.playAnim('singDOWNmiss', true);
						//CharL3.playAnim('singDOWNmiss', true);
					case 5:
						boyfriend.playAnim('singRIGHTmiss', true);
						//CharL2.playAnim('singRIGHTmiss', true);
						//CharL3.playAnim('singRIGHTmiss', true);
					case 6:
						boyfriend.playAnim('singDOWNmiss', true);
						//CharL2.playAnim('singDOWNmiss', true);
						//CharL3.playAnim('singDOWNmiss', true);
					case 7:
						boyfriend.playAnim('singUPmiss', true);
						//CharL2.playAnim('singUPmiss', true);
						//CharL3.playAnim('singUPmiss', true);
					case 8:
						boyfriend.playAnim('singRIGHTmiss', true);
						//CharL2.playAnim('singRIGHTmiss', true);
						//CharL3.playAnim('singRIGHTmiss', true);
				}
			}


			

			updateAccuracy();
		}
	}

	function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;

			var l1P = controls.L1_P;
			var uP = controls.U1_P;
			var r1P = controls.R1_P;
			var l2P = controls.L2_P;
			var dP = controls.D1_P;
			var r2P = controls.R2_P;

			var n0P = controls.N0_P;
			var n1P = controls.N1_P;
			var n2P = controls.N2_P;
			var n3P = controls.N3_P;
			var n4P = controls.N4_P;
			var n5P = controls.N5_P;
			var n6P = controls.N6_P;
			var n7P = controls.N7_P;
			var n8P = controls.N8_P;
	
			if (mania == 0)
			{
				if (leftP)
					noteMiss(0);
				if (upP)
					noteMiss(2);
				if (rightP)
					noteMiss(3);
				if (downP)
					noteMiss(1);
			}
			else if (mania == 1)
			{
				if (l1P)
					noteMiss(0);
				else if (uP)
					noteMiss(1);
				else if (r1P)
					noteMiss(2);
				else if (l2P)
					noteMiss(3);
				else if (dP)
					noteMiss(4);
				else if (r2P)
					noteMiss(5);
			}
			else
			{
				if (n0P) noteMiss(0);
				if (n1P) noteMiss(1);
				if (n2P) noteMiss(2);
				if (n3P) noteMiss(3);
				if (n4P) noteMiss(4);
				if (n5P) noteMiss(5);
				if (n6P) noteMiss(6);
				if (n7P) noteMiss(7);
				if (n8P) noteMiss(8);
			}
			updateAccuracy();
		}

	function updateAccuracy()
		{
			if (misses > 0 || accuracy < 96)
				fc = false;
			else
				fc = true;
			totalPlayed += 1;
			accuracy = totalNotesHit / totalPlayed * 100;
		}


	
		function getKeyPresses(note:Note):Int
			{
				var possibleNotes:Array<Note> = []; // copypasted but you already know that
		
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
					{
						possibleNotes.push(daNote);
						possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
					}
				});
				return possibleNotes.length;
			}
			
			var mashing:Int = 0;
			var mashViolations:Int = 0;

			var grace:Bool = false;
		
			function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
				{
					var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);
		
					note.rating = Ratings.CalculateRating(noteDiff);
		
					if (loadRep)
						{
							if (controlArray[note.noteData])
								goodNoteHit(note);
							else if (!theFunne && startedCountdown && !cs_reset) 
								badNoteCheck();
							else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
							{
								if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
								{
									goodNoteHit(note);
								}
								else if (!theFunne && startedCountdown && !cs_reset && !grace) 
									badNoteCheck();
							}
						}
					
					if (controlArray[note.noteData])
					{
						goodNoteHit(note, (mashing > getKeyPresses(note)));
						
						/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
						{
							mashViolations++;
							goodNoteHit(note, (mashing > getKeyPresses(note)));
						}
						else if (mashViolations > 2)
						{
							// this is bad but fuck you
							playerStrums.members[0].animation.play('static');
							playerStrums.members[1].animation.play('static');
							playerStrums.members[2].animation.play('static');
							playerStrums.members[3].animation.play('static');
							health -= 0.4;
							trace('mash ' + mashing);
							if (mashing != 0)
								mashing = 0;
						}
						else
							goodNoteHit(note, false);*/
		
					}
				}
		

				function goodNoteHit(note:Note, resetMashViolation = true):Void
					{

						if (mashing != 0)
							mashing = 0;
		
						var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);
		
						note.rating = Ratings.CalculateRating(noteDiff);
		
						// add newest note to front of notesHitArray
						// the oldest notes are at the end and are removed first
						if (!note.isSustainNote)
							notesHitArray.unshift(Date.now());
		
						if (!resetMashViolation && mashViolations >= 1)
							mashViolations--;
		
						if (mashViolations < 0)
							mashViolations = 0;
		
						if (!note.wasGoodHit)
						{
							if (!note.isSustainNote)
							{
								popUpScore(note);
								combo += 1;
							}
							else
								totalNotesHit += 1;
			
		
							
							if (mania == 1)
							{
								sDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
							}
							else if (mania == 2)
							{
								sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
							}

							if (isbf) //character swtich stuff
							{
								boyfriend.playAnim('sing' + sDir[note.noteData], true);
								boyfriend.holdTimer = 0;
							}
							if (iswhitty)
							{
								whitty.playAnim('sing' + sDir[note.noteData], true);
								whitty.holdTimer = 0;
							}
							if (ismatt)
								{
									matt.playAnim('sing' + sDir[note.noteData], true);
									matt.holdTimer = 0;
								}
							if (ishex)
								{
									hex.playAnim('sing' + sDir[note.noteData], true);
									hex.holdTimer = 0;
								}
							if (isruv)
								{
									ruv.playAnim('sing' + sDir[note.noteData], true);
									ruv.holdTimer = 0;
									if (FlxG.save.data.effects)
										FlxG.camera.shake(0.03, 0.03);
									
								}
							if (isshaggy)
								{
									shaggy.playAnim('sing' + sDir[note.noteData], true);
									shaggy.holdTimer = 0;
								}
							if (ishankchar)
								{
									hankchar.playAnim('sing' + sDir[note.noteData], true);
									hankchar.holdTimer = 0;
								}
							if (ispico)
								{
									pico.playAnim('sing' + sDir[note.noteData], true);
									pico.holdTimer = 0;
								}
							if (isgarcello)
								{
									garcello.playAnim('sing' + sDir[note.noteData], true);
									garcello.holdTimer = 0;
								}


							

							
							playerStrums.forEach(function(spr:FlxSprite)
							{
								if (Math.abs(note.noteData) == spr.ID)
								{
									spr.animation.play('confirm', true);
								}
							});
							
							note.wasGoodHit = true;
							vocals.volume = 1;
				
							note.kill();
							notes.remove(note, true);
							note.destroy();
							
							updateAccuracy();
							grace = true;
							new FlxTimer().start(0.25, function(tmr:FlxTimer)
							{
								grace = false;
							});
						}
					}

	var resetSpookyText:Bool = true;

	function resetBobismad():Void
		{
			camHUD.visible = true;
			bobsound.volume = 0;
			bobmadshake.visible = false;
		}
	
	function Bobismad()
	{
		camHUD.visible = false;
		bobmadshake.visible = true;
		bobsound.play();
		bobsound.volume = 1;
		new FlxTimer().start(0.5 , function(tmr:FlxTimer)
		{
			resetBobismad();
		});
	}

	function resetCharacters():Void //new character switching functions epic
		{
			isbf = false;
			iswhitty = false;
			istricky = false;
			istabi = false;
			isagoti = false;
			issky = false;
			istordbot = false;
			iszardy = false;
			isbob = false;
			issenpai = false;
			ismatt = false;
			ispico = false;
			ishankchar = false;
			isgarcello = false;
			isshaggy = false;
			isruv = false;
			ishex = false;
			if (FlxG.save.data.betacs)
				betacsCheck();
		}

	function switchCharacter(characters:String):Void
		{
			switch(characters)
			{
				case 'bf': 
					isbf = true;
				case 'whitty': 
					iswhitty = true;
				case 'tricky': 
					istricky = true;
				case 'tabi': 
					istabi = true;
				case 'agoti': 
					isagoti = true;
				case 'cass': 
					issky = true;
				case 'tordbot': 
					istordbot = true;
				case 'zardy': 
					iszardy = true;
				case 'bob': 
					isbob = true;
				case 'senpai': 
					issenpai = true;
				case 'matt': 
					ismatt = true;
				case 'pico': 
					ispico = true;
				case 'hankchar': 
					ishankchar = true;
				case 'garcello': 
					isgarcello = true;
				case 'shaggy': 
					isshaggy = true;
				case 'ruv': 
					isruv = true;
				case 'hex': 
					ishex = true;

			} 
			if (FlxG.save.data.betacs)
				betacsCheck();
		}
	function removeCharacter(characters:String):Void
		{
			switch(characters)
			{
				case 'bf': 
					isbf = false;
				case 'whitty': 
					iswhitty = false;
				case 'tricky': 
					istricky = false;
				case 'tabi': 
					istabi = false;
				case 'agoti': 
					isagoti = false;
				case 'cass': 
					issky = false;
				case 'tordbot': 
					istordbot = false;
				case 'zardy': 
					iszardy = false;
				case 'bob': 
					isbob = false;
				case 'senpai': 
					issenpai = false;
				case 'matt': 
					ismatt = false;
				case 'pico': 
					ispico = false;
				case 'hankchar': 
					ishankchar = false;
				case 'garcello': 
					isgarcello = false;
				case 'shaggy': 
					isshaggy = false;
				case 'ruv': 
					isruv = false;
				case 'hex': 
					ishex = false;

			} 
			if (FlxG.save.data.betacs)
				betacsCheck();

		}
	function betacsCheck() //probably not good for performace lol
	{
		if (!isbf)
			boyfriend.visible = false;
		else if (isbf)
			boyfriend.visible = true;

		if (!iswhitty)
			whitty.visible = false;
		else if (iswhitty)
			whitty.visible = true;

		if (!istricky)
			dad.visible = false;
		else if (istricky)
			dad.visible = true;

		if (!istabi)
			tabi.visible = false;
		else if (istabi)
			tabi.visible = true;

		if (!isagoti)
			agoti.visible = false;
		else if (isagoti)
			agoti.visible = true;

		if (!issky)
			cass.visible = false;
		else if (issky)
			cass.visible = true;

		if (!istordbot)
			tordbot.visible = false;
		else if (istordbot)
			tordbot.visible = true;

		if (!iszardy)
			zardy.visible = false;
		else if (iszardy)
			zardy.visible = true;

		if (!isbob)
			bob.visible = false;
		else if (isbob)
			bob.visible = true;

		if (!issenpai)
		{
			senpai.visible = false;
			senpaiT.visible = false;
		}
		else if (issenpai)
		{
			senpai.visible = true;
			senpaiT.visible = true;
		}
		if (!ismatt)
			matt.visible = false;
		else if (ismatt)
			matt.visible = true;

		if (!ispico)
			pico.visible = false;
		else if (ispico)
			pico.visible = true;

		if (!ishankchar)
			hankchar.visible = false;
		else if (ishankchar)
			hankchar.visible = true;

		if (!isgarcello)
			garcello.visible = false;
		else if (isgarcello)
			garcello.visible = true;

		if (!isshaggy)
		{
			shaggy.visible = false;
			shaggyT.visible = false;
		}
		else if (isshaggy)
		{
			shaggy.visible = true;
			shaggyT.visible = true;
		}
			

		if (!isruv)
			ruv.visible = false;
		else if (isruv)
			ruv.visible = true;

		if (!ishex)
			hex.visible = false;
		else if (ishex)
			hex.visible = true;

	}

	function killplayer() //this is so that dumbass gremlin at the end doesnt ignore when you hit halo notes (its just the death code copied)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}


	function changeMania(newManiaID:Int):Void //something i tried to make
		{
			for (i in 0...keyAmmo[mania])
				{
					// FlxG.log.add(i);
					hudArrows.remove(babyArrow);
					babyArrow.ID = i;
					hudArrXPos.remove(babyArrow.x);
					hudArrYPos.remove(babyArrow.y);
					playerStrums.remove(babyArrow);
					strumLineNotes.remove(babyArrow);		
				}
			mania = newManiaID;
			Note.mania = newManiaID;
			generateStaticArrows(0);
			generateStaticArrows(1);
		}


	function shaggyAngry()
		{
			new FlxTimer().start(0.01, function(tmr5:FlxTimer)
				{
					add(new MansionDebris(-300, -20, 'ceil', 1, 1, -4, -40));
					add(new MansionDebris(0, -20, 'ceil', 1, 1, -4, -5));
					add(new MansionDebris(200, -20, 'ceil', 1, 1, -4, 40));

					FlxG.sound.play(Paths.sound('ascend'));
					boyfriend.playAnim('hit');
					godCutEnd = true;
					camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
					new FlxTimer().start(0.4, function(tmr6:FlxTimer)
					{
						godMoveGf = false;
						boyfriend.playAnim('hit');
					});
					new FlxTimer().start(1, function(tmr9:FlxTimer)
					{
						boyfriend.playAnim('scared', true);
					});
					new FlxTimer().start(0.01, function(tmr7:FlxTimer)
					{
						FlxG.camera.shake(0.1, 0.5);
						dad.playAnim('idle', true);
						FlxG.sound.play(Paths.sound('shagFly'));
						godMoveSh = true;
						exshaggyT = new FlxTrail(dad, null, 5, 7, 0.3, 0.001);
						add(exshaggyT);
					});
				});
		}

	function resetSpookyTextManual():Void
	{
		trace('reset spooky');
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound','clown'));
		resetSpookyText = true;
	}

	function manuallymanuallyresetspookytextmanual()
	{
		remove(spookyText);
		spookyRendered = false;
		tstatic.alpha = 0;
	}

	var stepOfLast = 0;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}
		

		// EX TRICKY HARD CODED EVENTS + Character switching events
	

		if (curStage == 'auditorHell' && curStep != stepOfLast)
		{
			switch(curStep)
			{
				case 5:
					switchCharacter('tricky');
					dad.visible = true;
				case 94:
					resetCharacters();
					switchCharacter('whitty');
				case 124:
					resetCharacters();
					switchCharacter('zardy');
				case 191:
					resetCharacters();
					switchCharacter('tricky');
				case 222:
					resetCharacters();
					switchCharacter('cass');
				case 255:
					switchCharacter('bf');
					switchCharacter('tricky');
				case 320:
					removeCharacter('bf');
					removeCharacter('cass');
					switchCharacter('senpai');
					switchCharacter('bob');
				case 350: 
					if (FlxG.save.data.effects)
						Bobismad();
				case 384:
					doStopSign(0);
					removeCharacter('senpai');
					removeCharacter('tricky');
					switchCharacter('shaggy');
				case 447:
					resetCharacters();
					switchCharacter('hankchar');
					switchCharacter('tricky');
				case 511:
					doStopSign(2);
					doStopSign(0);
					removeCharacter('tricky');
				case 575:
					resetCharacters();
					switchCharacter('tricky');
					switchCharacter('senpai');
					switchCharacter('tordbot');
					switchCharacter('bf');
					switchCharacter('pico');
				case 607:
					resetCharacters();
					switchCharacter('pico');
				case 610:
					doStopSign(3);
				case 671:
					resetCharacters();
					switchCharacter('tricky');
					switchCharacter('tordbot');
					switchCharacter('bf');
				case 720:
					doStopSign(2);
				case 735:
					switchCharacter('hex');
					removeCharacter('tordbot');
					removeCharacter('bf');
				case 752:
					removeCharacter('tricky');
					switchCharacter('whitty');
				case 768:
					switchCharacter('tabi');
					removeCharacter('whitty');
				case 799:
					switchCharacter('tricky');
					switchCharacter('bf');
					removeCharacter('hex');
				case 831:
					removeCharacter('tabi');
				case 863: 
					removeCharacter('bf');
					switchCharacter('ruv');
				case 991:
					doStopSign(3);
					resetCharacters();
					switchCharacter('senpai');
					switchCharacter('matt');
				case 1056: 
					removeCharacter('senpai');
				case 1119: 
					resetCharacters();
					switchCharacter('tricky');
					switchCharacter('hex');
					switchCharacter('pico');
				case 1183: 
					removeCharacter('tricky');
					removeCharacter('pico');
					switchCharacter('matt');
					switchCharacter('shaggy');
				case 1184:
					doStopSign(2);
				case 1200:
					doStopSign(3);
				case 1218:
					doStopSign(0);
				case 1235:
					doStopSign(0, true);
				case 1247: 
					resetCharacters();
					switchCharacter('tabi');
					switchCharacter('agoti');
				case 1311: 
					resetCharacters();
					switchCharacter('zardy');
					switchCharacter('cass');		
				case 1328:
					doStopSign(0, true);
					doStopSign(2);
				case 1375: 
					resetCharacters();
					switchCharacter('bf');
					switchCharacter('tricky');
				case 1439:
					doStopSign(3, true);
					resetCharacters();
					switchCharacter('zardy');
					switchCharacter('hankchar');
				case 1503: 
					resetCharacters();
					switchCharacter('tricky');
					switchCharacter('ruv');
				case 1567:
					doStopSign(0);
					resetCharacters();
					switchCharacter('zardy');
					switchCharacter('senpai');
				case 1584:
					doStopSign(0, true);
				case 1600:
					doStopSign(2);
				case 1631: 
					removeCharacter('zardy');
					switchCharacter('tricky');
				case 1663: 
					removeCharacter('senpai');
					switchCharacter('tabi');
				case 1695: 
					removeCharacter('tabi');
					//hellclown up animation here 
					dad.curCharacter = 'trickyHUp';// dont  work stupid code
				case 1706:
					doStopSign(3);
				case 1727: 
					//remove hellclown animation
					dad.curCharacter = 'exTricky';
					//whitty animation
					switchCharacter('whitty');
				case 1760: 
					//remove whitty animation
					removeCharacter('whitty');
					switchCharacter('bf');
				case 1887: 
					removeCharacter('bf');
					switchCharacter('matt');
					switchCharacter('tordbot');
					switchCharacter('pico');
				case 1917:
					doStopSign(0);
				case 1923:
					doStopSign(0, true);
				case 1927:
					doStopSign(0);
				case 1932:
					doStopSign(0, true);
				case 2015: 
					removeCharacter('tordbot');
					removeCharacter('pico');
					switchCharacter('tricky');
					switchCharacter('bf');
				case 2032:
					doStopSign(2);
					doStopSign(0);
					removeCharacter('tricky');
					removeCharacter('bf');
					switchCharacter('whitty');
				case 2036:
					doStopSign(0, true);
				case 2047: 
					removeCharacter('whitty');
					switchCharacter('tricky');
				case 2064: 
					removeCharacter('tricky');
					switchCharacter('tabi');
				case 2079:
					removeCharacter('tabi');
					switchCharacter('hex');
					switchCharacter('tricky');
				case 2083: 
					switchCharacter('cass');
				case 2087: 
					removeCharacter('cass');
				case 2091: 
					switchCharacter('zardy');
				case 2095: 
					removeCharacter('zardy');
				case 2099: 
					switchCharacter('pico');
				case 2103: 
					removeCharacter('pico');
				case 2107: 
					switchCharacter('garcello');
				case 2111: 
					removeCharacter('garcello');
				case 2119: 
					switchCharacter('tabi');
				case 2129: 
					if (FlxG.save.data.effects)
						Bobismad();
				case 2143: 
					resetCharacters();
					switchCharacter('senpai');
					switchCharacter('bob');
					switchCharacter('shaggy');
				case 2162:
					doStopSign(2);
					doStopSign(3);
				case 2193:
					doStopSign(0);
				case 2202:
					doStopSign(0,true);
				case 2239:
					doStopSign(2,true);
				case 2258:
					doStopSign(0, true);
				case 2271: 
					resetCharacters();
					switchCharacter('tricky');
					switchCharacter('tabi');
					switchCharacter('hankchar');
				case 2304:
					doStopSign(0, true);
					doStopSign(0);	
				case 2326:
					doStopSign(0, true);
				case 2336:
					doStopSign(3);
				case 2395: 
					switchCharacter('zardy');
					if (FlxG.save.data.effects)
					{
						FlxG.camera.shake(0.05, 0.05);
						zardy.alpha = 0.4;
					}
				case 2399: 
					resetCharacters();
					switchCharacter('zardy');
					switchCharacter('agoti');
					switchCharacter('ruv');
				case 2447:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);	
				case 2480:
					doStopSign(0, true);
					doStopSign(0);	
				case 2512:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);
				case 2527: 
					resetCharacters();
					switchCharacter('tordbot');
					switchCharacter('bf');
					switchCharacter('cass');
					switchCharacter('pico');
				case 2544:
					doStopSign(0, true);
					doStopSign(0);	
				case 2575:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);
				case 2608:
					doStopSign(0, true);
					doStopSign(0);	
				case 2604:
					doStopSign(0, true);
				case 2655:
					doGremlin(20,13,true);
					removeCharacter('tordbot');
					removeCharacter('cass');
					removeCharacter('pico');
					switchCharacter('tricky');
					switchCharacter('senpai');
				case 2687: 
					removeCharacter('senpai');
					switchCharacter('pico');
				case 2719: 
					removeCharacter('pico');
					switchCharacter('tabi');
				case 2751: 
					removeCharacter('tabi');
					switchCharacter('shaggy');
				case 2783:
					removeCharacter('shaggy');
					switchCharacter('tordbot');
				case 2815: 
					removeCharacter('tordbot');
					switchCharacter('hankchar');
				case 2847: 
					removeCharacter('hankchar');
					switchCharacter('bob');
				case 2861: 
					if (FlxG.save.data.effects)
						Bobismad();
				case 2879: 
					switchCharacter('whitty');
			}
			stepOfLast = curStep;
		}

		else if (curStage == 'shaggyHell' && curStep != stepOfLast) //coulnt be bother to seperate them
			{
				switch(curStep)
				{
					case 319: 
						FlxTween.tween(FlxG.camera, {zoom: 0.35}, 0.25);
						FlxTween.tween(camHUD, {zoom: 0.5}, 0.3);
						new FlxTimer().start(0.3, function(tmr7:FlxTimer)
							{
								//camHUD.zoom = 0.9;
								//FlxG.camera.zoom = 0.55;
								FlxTween.tween(FlxG.camera, {zoom: 0.55}, 0.1);
								FlxTween.tween(camHUD, {zoom: 0.9}, 0.1);
							});
					case 384:
						doStopSign(0);
					case 511:
						doStopSign(2);
						doStopSign(0);
					case 610:
						doStopSign(3);
					case 720:
						doStopSign(2);
					case 991:
						doStopSign(3);
					case 1184:
						doStopSign(2);
					case 1218:
						doStopSign(0);
					case 1235:
						doStopSign(0, true);
					case 1200:
						doStopSign(3);
					case 1328:
						doStopSign(0, true);
						doStopSign(2);
					case 1423: 
						if (FlxG.save.data.effects)
							cameragocrazy = true;

						if (FlxG.save.data.effects)
							spinnyboi = true;
					case 1439:
						doStopSign(3, true);
					case 1441: 
						cameragocrazy = false;
					case 1567:
						doStopSign(0);
					case 1584:
						doStopSign(0, true);
					case 1600:
						doStopSign(2);
					case 1631: 
						if (FlxG.save.data.effects)
							cameragocrazy = true;
						
						spinnyboi = false;
					case 1706:
						doStopSign(3);
					case 1917:
						doStopSign(0);
					case 1923:
						doStopSign(0, true);
					case 1927:
						doStopSign(0);
					case 1932:
						doStopSign(0, true);
					case 2032:
						doStopSign(2);
						doStopSign(0);
					case 2036:
						doStopSign(0, true);
					case 2127: 
						shaggyAngry();
					case 2162:
						doStopSign(2);
						doStopSign(3);
					case 2193:
						doStopSign(0);
					case 2202:
						doStopSign(0,true);
					case 2239:
						doStopSign(2,true);
					case 2258:
						doStopSign(0, true);
					case 2304:
						doStopSign(0, true);
						doStopSign(0);	
					case 2326:
						doStopSign(0, true);
					case 2336:
						doStopSign(3);
					case 2447:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);	
					case 2480:
						doStopSign(0, true);
						doStopSign(0);	
					case 2512:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2544:
						doStopSign(0, true);
						doStopSign(0);	
					case 2575:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2608:
						doStopSign(0, true);
						doStopSign(0);	
					case 2604:
						doStopSign(0, true);
					case 2655:
						doGremlin(20,13,true);
						remove(exshaggyT);
						cameragocrazy = false;
					case 2727: 
						//camHUD.angle
						if (FlxG.save.data.effects)
							{
								FlxTween.tween(camHUD, {angle: 25}, 1);
								FlxTween.tween(camHUD, {zoom: 0.7}, 1);
							}
					case 2792:
						if (FlxG.save.data.effects)
							FlxTween.tween(camHUD, {angle: -25}, 2);
					case 2873: 
						if (FlxG.save.data.effects)
							FlxTween.tween(camHUD, {angle: 0}, 3);
					case 2920: 
						if (FlxG.save.data.effects)
							FlxTween.tween(camHUD, {zoom: 0.9}, 1);

				}
				stepOfLast = curStep;
			}
		



		if (dad.curCharacter == 'spooky' && curStep % 4 == 2)
		{
			// dad.dance();
		}

		if (spookyRendered && spookySteps + 3 < curStep)
		{
			if (resetSpookyText)
			{
				remove(spookyText);
				spookyRendered = false;
			}
			tstatic.alpha = 0;
			if (curStage == 'auditorHell' || curStage == 'shaggyHell')
				tstatic.alpha = 0.1;
		}

		super.stepHit();
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	var lastBeatT:Int = 0;
	var lastBeatDadT:Int = 0;
	var beatOfFuck:Int = 0;

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}

		if (curStage == 'nevedaSpook')
			hank.animation.play('dance');

		if (SONG.notes[Math.floor(curStep / 16)] != null)
			{
				if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
				{
					Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
					FlxG.log.add('CHANGED BPM!');
				}
				// else
				// Conductor.changeBPM(SONG.bpm);
	
				// Dad doesnt interupt his own notes
				if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
				{
					dad.dance();
				}
			}
			
		if (curStage == 'auditorHell' && FlxG.save.data.characters && (FlxG.save.data.preload))
		{
			if (curBeat % 8 == 4 && beatOfFuck != curBeat)
			{
				beatOfFuck = curBeat;
				if (istricky)
					doClone(FlxG.random.int(0,1));
			}
		}
  
		if (curStage == 'shaggyHell' && FlxG.save.data.characters && (FlxG.save.data.preload))
			{
				if (curBeat % 8 == 4 && beatOfFuck != curBeat && !godCutEnd)
				{
					beatOfFuck = curBeat;
					doscoobClone(FlxG.random.int(0,1));
				}
			}

		/*if (cameragocrazy && curBeat % 4 == 2 && beatOfFuck != curBeat)
			{
				beatOfFuck = curBeat;
				FlxTween.tween(FlxG.camera, {zoom: 0.45}, 0.15);
				FlxTween.tween(camHUD, {zoom: 0.8}, 0.1);
				new FlxTimer().start(0.1, function(tmr7:FlxTimer)
					{
						//camHUD.zoom = 0.9;
						//FlxG.camera.zoom = 0.55;
						FlxTween.tween(FlxG.camera, {zoom: 0.55}, 0.1);
						FlxTween.tween(camHUD, {zoom: 0.9}, 0.1);
					});

			}*/




		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0 && curBeat != lastBeatT)
		{
			lastBeatT = curBeat;
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && !godCutEnd)
		{
			boyfriend.playAnim('idle');
		}
		else
			{
				boyfriend.playAnim('scared');
			}


		if (curBeat == 532 && curSong.toLowerCase() == "improbable-chaos")
		{
			dad.playAnim('Hank', true);
		}

		if (curBeat == 536 && curSong.toLowerCase() == "improbable-chaos")
		{
			dad.playAnim('idle', true);
		}

	}

	var curLight:Int = 0;
}