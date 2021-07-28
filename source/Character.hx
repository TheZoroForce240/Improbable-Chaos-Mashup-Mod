package;

import flixel.animation.FlxAnimationController;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var animations:Array<FlxAnimationController> = [];

	public var exSpikes:FlxSprite;

	public var otherFrames:Array<Character>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false, ?isDebug:Bool = false)
	{
		super(x, y);

		trace('creating ' + character);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		if (FlxG.save.data.aa)
			antialiasing = true;
		else if (!FlxG.save.data.aa)
			antialiasing = false;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-hell':
				tex = Paths.getSparrowAtlas('hellclwn/GF/gf_phase_3','clown');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			
			case 'gf-tied':
				tex = Paths.getSparrowAtlas('fourth/EX Tricky GF','clown');
				frames = tex;

				trace(frames.frames.length);

				animation.addByIndices('danceLeft','GF Ex Tricky',[0,1,2,3,4,5,6,7,8], "", 24, false);
				animation.addByIndices('danceRight','GF Ex Tricky',[9,10,11,12,13,14,15,16,17,18,19], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				trace(animation.curAnim);

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');
			///////////////////////////////////////////////////////////////
			//left side characters
			case 'tabi':
				tex = Paths.getSparrowAtlas('characters/Left/MadTabi');
				frames = tex;
				animation.addByPrefix('idle', 'MadTabiIdle', 24);
				animation.addByPrefix('singUP', 'MadTabiUp', 24);
				animation.addByPrefix('singRIGHT', 'MadTabiRight', 24);
				animation.addByPrefix('singDOWN', 'MadTabiDown', 24);
				animation.addByPrefix('singLEFT', 'MadTabiLeft', 24);

				addOffset('idle');
				addOffset("singUP", 44, 100);
				addOffset("singRIGHT", 110, -13);
				addOffset("singLEFT", 230, 10);
				addOffset("singDOWN", 60, -60);
				
				playAnim('idle');
				
			case 'agoti':
				tex = Paths.getSparrowAtlas('characters/Left/Alt_Agoti_Sprites_B');
				frames = tex;
				animation.addByPrefix('idle', 'Angry_Agoti_Idle', 24);
				animation.addByPrefix('singUP', 'Angry_Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Angry_Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Angry_Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Angry_Agoti_Left', 24);

				addOffset('idle');
				addOffset("singUP", 84, 150);
				addOffset("singRIGHT", 40, -4);
				addOffset("singLEFT", 150, -40);
				addOffset("singDOWN", 22, -120);
				
				playAnim('idle');
		
			case 'cass':
				if (!FlxG.save.data.usesunday)
				{
					tex = Paths.getSparrowAtlas('characters/Left/cass');
					frames = tex;
					animation.addByPrefix('idle', 'Mom Idle', 24);
					animation.addByPrefix('singUP', 'Mom Up Pose', 24);
					animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24);
					animation.addByPrefix('singDOWN', 'MOM DOWN POSE', 24);
					animation.addByPrefix('singLEFT', 'Mom Left Pose', 24);

					addOffset('idle');
					addOffset("singUP", 24, 61);
					addOffset("singRIGHT", 30, -53);
					addOffset("singLEFT", 230, -20);
					addOffset("singDOWN", 1, -138);
					
					playAnim('idle');
				}

				else if (FlxG.save.data.usesunday)
				{
					tex = Paths.getSparrowAtlas('characters/Left/sunday_assets');
					frames = tex;
					animation.addByPrefix('idle', 'sunday idle', 24, true);
					animation.addByPrefix('singUP', 'sunday up', 24, false);
					animation.addByPrefix('singDOWN', 'sunday down', 24, false);
					animation.addByPrefix('singLEFT', 'sunday left', 24, false);
					animation.addByPrefix('singRIGHT', 'sunday right', 24, false);
	
					addOffset('idle',1,1);
					addOffset("singDOWN", 157, -27);
					addOffset("singRIGHT", -71,-10);
					addOffset("singUP", 137, 147);
					addOffset("singLEFT", 39,-1);
					
					playAnim('idle');
				}
					
			
			case 'tordbot':
				tex = Paths.getSparrowAtlas('characters/Left/tordbot_assets');
				frames = tex;
				animation.addByPrefix('idle', 'tordbot idle', 24);
				animation.addByPrefix('singUP', 'tordbot up', 24);
				animation.addByPrefix('singRIGHT', 'tordbot right', 24);
				animation.addByPrefix('singDOWN', 'tordbot down', 24);
				animation.addByPrefix('singLEFT', 'tordbot left', 24);

				addOffset('idle');
				addOffset("singUP", 174, 80);
				addOffset("singRIGHT", 150, 27);
				addOffset("singLEFT", 100, 35);
				addOffset("singDOWN", 180, 50);
				
				playAnim('idle');

			case 'bob':
				tex = Paths.getSparrowAtlas('characters/Left/hellbob_assets');
				frames = tex;
				animation.addByPrefix('idle', 'bobismad', 24);
				animation.addByPrefix('singUP', 'bobismad', 24);
				animation.addByPrefix('singRIGHT', 'bobismad', 24);
				animation.addByPrefix('singDOWN', 'bobismad', 24);
				animation.addByPrefix('singLEFT', 'bobismad', 24);

				addOffset('idle');
				
				playAnim('idle');
				flipX = true;

			case 'zardy':
				tex = Paths.getSparrowAtlas('characters/Left/Zardy');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", -187, 100);
				addOffset("singRIGHT", -30, -13);
				addOffset("singLEFT", 203, -10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');

			case 'senpai':
				tex = Paths.getSparrowAtlas('characters/Left/Senpai_Spirit');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');

			//right side characters
			case 'whitty':
				tex = Paths.getSparrowAtlas('characters/Right/WhittyCrazy');
				frames = tex;
				animation.addByPrefix('idle', 'Whitty idle dance', 24);
				animation.addByPrefix('singUP', 'Whitty Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'whitty sing note right', 24);
				animation.addByPrefix('singDOWN', 'Whitty Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Whitty Sing Note LEFT', 24);
				animation.addByPrefix('firstDeath', "Whitty Dies", 24, false);
				animation.addByPrefix('deathLoop', "Whitty Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "Whitty Retry", 24, false);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", 53, 10);
				addOffset("singDOWN", 90, -170);
				
				playAnim('idle');

				flipX = true;
			case 'matt':
				tex = Paths.getSparrowAtlas('characters/Right/matt');
				frames = tex;
				animation.addByPrefix('idle', 'matt idle', 24);
				animation.addByPrefix('singUP', 'matt up note', 24);
				animation.addByPrefix('singRIGHT', 'matt right note', 24);
				animation.addByPrefix('singDOWN', 'matt down note', 24);
				animation.addByPrefix('singLEFT', 'matt left note', 24);
				animation.addByPrefix('firstDeath', "matt dies", 24, false);
				animation.addByPrefix('deathLoop', "Matt dead loop", 24, true);
				animation.addByPrefix('deathConfirm', "Matt Retry", 24, false);

				addOffset('idle');
				addOffset("singUP", -46, 10);
				addOffset("singRIGHT", -40, -23);
				addOffset("singLEFT", 30, -40);
				addOffset("singDOWN", -70, -30);
				
				playAnim('idle');
				flipX = true;	
				
			case 'garcello':
				tex = Paths.getSparrowAtlas('characters/Right/garcellodead_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');
				flipX = true;
			case 'hex':
				tex = Paths.getSparrowAtlas('characters/Right/Hex_Virus');
				frames = tex;
				animation.addByPrefix('idle', 'Hex crazy idle', 24);
				animation.addByPrefix('singUP', 'Hex crazy up', 24);
				animation.addByPrefix('singRIGHT', 'Hex crazy right', 24);
				animation.addByPrefix('singDOWN', 'Hex crazy down', 24);
				animation.addByPrefix('singLEFT', 'Hex crazy left', 24);

				addOffset('idle');
				addOffset("singUP", 114, 100);
				addOffset("singRIGHT", 110, -13);
				addOffset("singLEFT", 190, 60);
				addOffset("singDOWN", 80, -60);
				
				playAnim('idle');
				flipX = true;
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Right/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);		
				animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);


				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singLEFT", -68, -7);
				addOffset("singRIGHT", 65, 9);
				addOffset("singDOWN", 200, -70);
				
				playAnim('idle');
			case 'shaggy':
				tex = Paths.getSparrowAtlas('characters/Right/pshaggy');
				frames = tex;
				animation.addByPrefix('idle', 'pshaggy_idle', 24);
				animation.addByPrefix('singUP', 'pshaggy_up', 24);
				animation.addByPrefix('singRIGHT', 'pshaggy_right', 24);
				animation.addByPrefix('singDOWN', 'pshaggy_down', 24);
				animation.addByPrefix('singLEFT', 'pshaggy_left', 24);

				addOffset('idle');
				addOffset("singUP", 74, 80);
				addOffset("singRIGHT", 40, -5);
				addOffset("singLEFT", -20, -10);
				addOffset("singDOWN", 150, -80);
				
				playAnim('idle');
				flipX = true;
			case 'hankchar':
				tex = Paths.getSparrowAtlas('characters/Right/TrickyMask');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", -54, 10);
				addOffset("singLEFT", 10, 0);
				addOffset("singRIGHT", 230, 20);
				addOffset("singDOWN", 20, -60);
				
				playAnim('idle');
				flipX = true;

			case 'ruv':
				tex = Paths.getSparrowAtlas('characters/Right/ruv_sheet');
				frames = tex;
				animation.addByPrefix('idle', 'RuvIdle', 24);
				animation.addByPrefix('singUP', 'RuvUp', 24);
				animation.addByPrefix('singRIGHT', 'RuvRight', 24);
				animation.addByPrefix('singDOWN', 'RuvDown', 24);
				animation.addByPrefix('singLEFT', 'RuvLeft', 24);

				addOffset('idle');
				addOffset("singUP", 14, 0);
				addOffset("singRIGHT", 33, 5);
				addOffset("singLEFT", 50, -60);
				addOffset("singDOWN", 80, 0);
				
				playAnim('idle');
				flipX = true;

			case '':
				tex = Paths.getSparrowAtlas('characters/Right/');
				frames = tex;
				animation.addByPrefix('idle', '', 24);
				animation.addByPrefix('singUP', '', 24);
				animation.addByPrefix('singRIGHT', '', 24);
				animation.addByPrefix('singDOWN', '', 24);
				animation.addByPrefix('singLEFT', '', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				
				playAnim('idle');


			///////////////////////////////////////////////////
					
			case 'tricky':
				tex = Paths.getSparrowAtlas('tricky','clown');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');
				
			case 'trickyH':
				tex = CachedFrames.cachedInstance.fromSparrow('idle','hellclwn/Tricky/Idle');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Phase 3 Tricky Idle', 24);
				
				// they have to be left right up down, in that order.
				// cuz im too lazy to dynamicly get these names
				// cry about it

				otherFrames = new Array<Character>();

				
				otherFrames.push(new Character(100, 100, 'trickyHLeft'));
				otherFrames.push(new Character(100, 100, 'trickyHRight'));
				otherFrames.push(new Character(100, 100, 'trickyHUp'));
				otherFrames.push(new Character(100, 100, 'trickyHDown'));

				animations.push(animation);
				for (i in otherFrames)
					animations.push(animation);

				trace('poggers');

				addOffset("idle", 325, 0);
				playAnim('idle');
			case 'trickyHDown':
				tex = CachedFrames.cachedInstance.fromSparrow('down','hellclwn/Tricky/Down');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Down', 24);

				addOffset("idle",475, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHUp':
				tex = CachedFrames.cachedInstance.fromSparrow('up','hellclwn/Tricky/Up');


				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Up', 24);

				addOffset("idle", 575, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHRight':
				tex = CachedFrames.cachedInstance.fromSparrow('right','hellclwn/Tricky/right');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Right', 24);

				addOffset("idle",485, -300);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHLeft':
				tex = CachedFrames.cachedInstance.fromSparrow('left','hellclwn/Tricky/Left');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Left', 24);

				addOffset("idle", 516, 25);

				y -= 2000;
				x -= 1400;
				
				playAnim('idle');

			case 'trickyMask':
				tex = Paths.getSparrowAtlas('TrickyMask','clown');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -117);
				addOffset("singUP", 93, -100);
				addOffset("singRIGHT", 16, -164);
				addOffset("singLEFT", 194, -95);
				addOffset("singDOWN", 32, -168);

				playAnim('idle');
			
			case 'bf':
				if (!FlxG.save.data.regbf)
				{
					var tex = Paths.getSparrowAtlas('characters/Right/BF_post_exp');
					frames = tex;
					animation.addByPrefix('idle', 'BF idle dance', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
					animation.addByPrefix('hey', 'BF HEY', 24, false);

					animation.addByPrefix('firstDeath', "BF dies", 24, false);
					animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
					animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

					animation.addByPrefix('scared', 'BF idle shaking', 24);

					animation.addByPrefix('stunned', 'BF hit', 24, false);

					addOffset('idle', -5);
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -38, -7);
					addOffset("singLEFT", 12, -6);
					addOffset("singDOWN", -10, -50);
					addOffset("singUPmiss", -29, 27);
					addOffset("singRIGHTmiss", -30, 21);
					addOffset("singLEFTmiss", 12, 24);
					addOffset("singDOWNmiss", -11, -19);
					addOffset("hey", 7, 4);
					addOffset('firstDeath', 37, 11);
					addOffset('deathLoop', 37, 5);
					addOffset('deathConfirm', 37, 69);
					addOffset('scared', -4);
					addOffset('stunned', 31, 22);

					playAnim('idle');

					flipX = true;
				}
				else 
				{
					var tex = Paths.getSparrowAtlas('BOYFRIEND');
					frames = tex;
					animation.addByPrefix('idle', 'BF idle dance', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
					animation.addByPrefix('hey', 'BF HEY', 24, false);

					animation.addByPrefix('firstDeath', "BF dies", 24, false);
					animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
					animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

					animation.addByPrefix('scared', 'BF idle shaking', 24);

					animation.addByPrefix('stunned', 'BF hit', 24, false);

					addOffset('idle', -5);
					addOffset("singUP", -29, 27);
					addOffset("singRIGHT", -38, -7);
					addOffset("singLEFT", 12, -6);
					addOffset("singDOWN", -10, -50);
					addOffset("singUPmiss", -29, 27);
					addOffset("singRIGHTmiss", -30, 21);
					addOffset("singLEFTmiss", 12, 24);
					addOffset("singDOWNmiss", -11, -19);
					addOffset("hey", 7, 4);
					addOffset('firstDeath', 37, 11);
					addOffset('deathLoop', 37, 5);
					addOffset('deathConfirm', 37, 69);
					addOffset('scared', -4);
					addOffset('stunned', 31, 22);

					playAnim('idle');

					flipX = true;
				}
					
					

				
			
			case 'bf-hell':
				var tex = Paths.getSparrowAtlas('hellclwn/BF/BF_3rd_phase','clown');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('stunned', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;

			case 'signDeath':
				frames = Paths.getSparrowAtlas('signDeath','clown');
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				
				playAnim('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop');
				addOffset('deathConfirm', 0, 40);

				animation.pause();

				updateHitbox();
				antialiasing = false;
				flipX = true;
			
			case 'exTricky':
				frames = Paths.getSparrowAtlas('fourth/EXTRICKY','clown');
				exSpikes = new FlxSprite(x - 350,y - 170);
				exSpikes.frames = Paths.getSparrowAtlas('fourth/FloorSpikes','clown');
				exSpikes.visible = false;

				exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');
		}

		if (FlxG.save.data.aa)
			antialiasing = true;
		else if (!FlxG.save.data.aa)
			antialiasing = false;

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf') && !curCharacter.toLowerCase().contains('death'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function addOtherFrames()
	{
		
		for (i in otherFrames)
			{
				PlayState.staticVar.add(i);
				i.visible = false;
			}
	}

	override function update(elapsed:Float)
		{
			if (!curCharacter.startsWith('bf') && animation.curAnim != null)
			{
				if (animation.curAnim.name.startsWith('sing'))
				{
					holdTimer += elapsed;
				}
	
				var dadVar:Float = 4;
	
				if (curCharacter == 'dad')
					dadVar = 6.1;
				if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
				{
					if (curCharacter != 'trickyHLeft' && curCharacter != 'trickyHRight' && curCharacter != 'trickyHDown' && curCharacter != 'trickyHUp')
					{
						dance();
						holdTimer = 0;
					}
				}
			}
	
			switch (curCharacter)
			{
				case 'gf':
					if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
						playAnim('danceRight');
				case 'exTricky':
					if (exSpikes.animation.frameIndex >= 3 && animation.curAnim.name == 'singUP')
					{
						trace('paused');
						exSpikes.animation.pause();
					}
			}
	
			super.update(elapsed);
		}
	
		private var danced:Bool = false;
	
		/**
		 * FOR GF DANCING SHIT
		 */
		public function dance()
		{
			if (!debugMode)
			{
				switch (curCharacter)
				{
					case 'gf':
						if (!animation.curAnim.name.startsWith('hair'))
						{
							danced = !danced;

							if (danced)
								playAnim('danceRight');
							else
								playAnim('danceLeft');
						}

					case 'gf-hell':
						if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
					case 'gf-tied':
						if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
					default:
						playAnim('idle');
				}
			}
		}
	
		// other frames implementation is messy but who cares lol!

		public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
		{

			if (debugMode && otherFrames != null)
				{
					/*if (AnimationDebug.dad != null)
					{
						trace('debug play anim ' + AnimName);
						AnimationDebug.dad.alpha = 0.6;
						for(i in otherFrames)
						{
							i.visible = false;
						}

						
						switch(AnimName)
						{
							case 'singLEFT':
								otherFrames[0].visible = true;
								otherFrames[0].playAnim('idle', Force, Reversed, Frame);
							case 'singRIGHT':
								otherFrames[1].visible = true;
								otherFrames[1].playAnim('idle', Force, Reversed, Frame);
							case 'singUP':
								otherFrames[2].visible = true;
								otherFrames[2].playAnim('idle', Force, Reversed, Frame);
							case 'singDOWN':
								otherFrames[3].visible = true;
								otherFrames[3].playAnim('idle', Force, Reversed, Frame);
							default:
								AnimationDebug.dad.alpha = 1;
								animation.play('idle', Force, Reversed, Frame);
						}
					}*/
				}
				else if (otherFrames != null && PlayState.dad != null && PlayState.generatedMusic)
					{
						visible = false;
						for(i in otherFrames)
						{
							i.visible = false;
							i.x = x;
							i.y = y + 60;
						}

						switch(AnimName)
						{
							case 'singLEFT':
								otherFrames[0].visible = true;
								otherFrames[0].playAnim('idle', Force, Reversed, Frame);
							case 'singRIGHT':
								otherFrames[1].visible = true;
								otherFrames[1].playAnim('idle', Force, Reversed, Frame);
							case 'singUP':
								otherFrames[2].visible = true;
								otherFrames[2].playAnim('idle', Force, Reversed, Frame);
								otherFrames[2].y += 20;
							case 'singDOWN':
								otherFrames[3].visible = true;
								otherFrames[3].playAnim('idle', Force, Reversed, Frame);
							default:
								visible = true;

								animation.play(AnimName, Force, Reversed, Frame);

								var daOffset = animOffsets.get(AnimName);
								if (animOffsets.exists(AnimName))
									offset.set(daOffset[0], daOffset[1]);
								else
									offset.set(0, 0);
						}
					}
					else if (otherFrames != null && PlayState.dad != null)
					{
						visible = true;
						animation.play('idle', Force, Reversed, Frame);
						
						var daOffset = animOffsets.get('idle');
						if (animOffsets.exists('idle'))
							offset.set(daOffset[0], daOffset[1]);
						else
							offset.set(0, 0);
					}
			else
			{
				animation.play(AnimName, Force, Reversed, Frame);

				if (curCharacter == 'exTricky')
				{
					if (AnimName == 'singUP')
					{
						trace('spikes');
						exSpikes.visible = true;
						if (exSpikes.animation.finished)
							exSpikes.animation.play('spike');
					}
					else if (!exSpikes.animation.finished)
					{
						exSpikes.animation.resume();
						trace('go back spikes');
						exSpikes.animation.finishCallback = function(pog:String) {
							trace('finished');
							exSpikes.visible = false;
							exSpikes.animation.finishCallback = null;
						}
					}
				}

				var daOffset = animOffsets.get(AnimName);
				if (animOffsets.exists(AnimName))
				{
					offset.set(daOffset[0], daOffset[1]);
				}
				else
					offset.set(0, 0);
				if (curCharacter == 'gf')
				{
					if (AnimName == 'singLEFT')
					{
						danced = true;
					}
					else if (AnimName == 'singRIGHT')
					{
						danced = false;
					}
		
					if (AnimName == 'singUP' || AnimName == 'singDOWN')
					{
						danced = !danced;
					}
				}
			}
		}
	
		public function addOffset(name:String, x:Float = 0, y:Float = 0)
		{
			animOffsets[name] = [x, y];
		}
}
