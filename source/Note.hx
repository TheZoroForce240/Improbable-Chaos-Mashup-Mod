package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var burning:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var noteType:Int = 0;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;
	public var mania:Int = 0;

	public static var noteyOff1:Array<Float> = [4, 0, 0, 0, 0, 0];
	public static var noteyOff2:Array<Float> = [0, 0, 0, 0, 0, 0];
	public static var noteyOff3:Array<Float> = [0, 0, 0, 0, 0, 0];

	public static var swagWidth:Float;
	public static var noteScale:Float;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	public static var EX1_NOTE:Int = 4;
	public static var EX2_NOTE:Int = 5;

	public static var tooMuch:Float = 30;

	public var rating:String = "shit";

	public function new(_strumTime:Float, _noteData:Int, ?_prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0, ?_mustPress:Bool = false)
	{
		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		mania = 0;
		if (PlayState.SONG.mania == 1)
		{
			swagWidth = 120 * 0.7;
			noteScale = 0.6;
			mania = 1;
		}
		else if (PlayState.SONG.mania == 2)
		{
			swagWidth = 95 * 0.7;
			noteScale = 0.5;
			mania = 2;
		}
		super();

		if (_prevNote == null)
			_prevNote = this;
		this.noteType = noteType;
		prevNote = _prevNote;
		isSustainNote = sustainNote;

		x += 50;
		if (PlayState.SONG.mania == 2)
		{
			x -= tooMuch;
		}

		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		strumTime = _strumTime + FlxG.save.data.offset;
		if (FlxG.save.data.downscroll && noteType == 1 || FlxG.save.data.downscroll && noteType == 2)
			strumTime += 50;
		else if (!FlxG.save.data.downscroll && noteType == 1 || !FlxG.save.data.downscroll && noteType == 2)
			strumTime -= 50;

		strumTime = strumTime < 0 ? 0 : strumTime;

		burning = _noteData > 8;
		//if(!isSustainNote) { burning = Std.random(3) == 1; } //Set random notes to burning

		//No held fire notes :[ (Part 1)
		//if(isSustainNote && prevNote.burning) { 
			//burning = true;
		//}

		if(isSustainNote && FlxG.save.data.downscroll)
			flipY = true;
		
		noteData = _noteData % 9;

		var addto = FlxG.save.data.offset;
		if (Main.editor) //xd
		{
			addto = 0;
		}
		this.strumTime = strumTime + addto;


		var daStage:String = PlayState.curStage;

		switch (daStage)
		{
			case 'school' | 'schoolEvil':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);

				}

				if(burning){
					
					loadGraphic(Paths.image('NOTE_fire-pixel', "clown"), true, 21, 31);
					
					animation.add('greenScroll', [6, 7, 6, 8], 8);
					animation.add('redScroll', [9, 10, 9, 11], 8);
					animation.add('blueScroll', [3, 4, 3, 5], 8);
					animation.add('purpleScroll', [0, 1 ,0, 2], 8);
					x -= 15;

				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();


			default:
				if(FlxG.save.data.regnoteskin == false && FlxG.save.data.altnoteskin == false)
					{
						frames = Paths.getSparrowAtlas('tabi_NOTE_assets');

						animation.addByPrefix('greenScroll', 'green0');
						animation.addByPrefix('redScroll', 'red0');
						animation.addByPrefix('blueScroll', 'blue0');
						animation.addByPrefix('purpleScroll', 'purple0');
						animation.addByPrefix('whiteScroll', 'white0');
						animation.addByPrefix('yellowScroll', 'yellow0');
						animation.addByPrefix('violetScroll', 'violet0');
						animation.addByPrefix('blackScroll', 'black0');
						animation.addByPrefix('darkScroll', 'dark0');


						animation.addByPrefix('purpleholdend', 'pruple end hold');
						animation.addByPrefix('greenholdend', 'green hold end');
						animation.addByPrefix('redholdend', 'red hold end');
						animation.addByPrefix('blueholdend', 'blue hold end');
						animation.addByPrefix('whiteholdend', 'white hold end');
						animation.addByPrefix('yellowholdend', 'yellow hold end');
						animation.addByPrefix('violetholdend', 'violet hold end');
						animation.addByPrefix('blackholdend', 'black hold end');
						animation.addByPrefix('darkholdend', 'dark hold end');

						animation.addByPrefix('purplehold', 'purple hold piece');
						animation.addByPrefix('greenhold', 'green hold piece');
						animation.addByPrefix('redhold', 'red hold piece');
						animation.addByPrefix('bluehold', 'blue hold piece');
						animation.addByPrefix('whitehold', 'white hold piece');
						animation.addByPrefix('yellowhold', 'yellow hold piece');
						animation.addByPrefix('violethold', 'violet hold piece');
						animation.addByPrefix('blackhold', 'black hold piece');
						animation.addByPrefix('darkhold', 'dark hold piece');
						setGraphicSize(Std.int(width * noteScale));
					}
				else if(FlxG.save.data.altnoteskin == true && FlxG.save.data.regnoteskin == false)
					{
						frames = Paths.getSparrowAtlas('altnoteassets/NOTE_assets');

						animation.addByPrefix('greenScroll', 'green0');
						animation.addByPrefix('redScroll', 'red0');
						animation.addByPrefix('blueScroll', 'blue0');
						animation.addByPrefix('purpleScroll', 'purple0');
						animation.addByPrefix('whiteScroll', 'white0');
						animation.addByPrefix('yellowScroll', 'yellow0');
						animation.addByPrefix('violetScroll', 'violet0');
						animation.addByPrefix('blackScroll', 'black0');
						animation.addByPrefix('darkScroll', 'dark0');


						animation.addByPrefix('purpleholdend', 'pruple end hold');
						animation.addByPrefix('greenholdend', 'green hold end');
						animation.addByPrefix('redholdend', 'red hold end');
						animation.addByPrefix('blueholdend', 'blue hold end');
						animation.addByPrefix('whiteholdend', 'white hold end');
						animation.addByPrefix('yellowholdend', 'yellow hold end');
						animation.addByPrefix('violetholdend', 'violet hold end');
						animation.addByPrefix('blackholdend', 'black hold end');
						animation.addByPrefix('darkholdend', 'dark hold end');

						animation.addByPrefix('purplehold', 'purple hold piece');
						animation.addByPrefix('greenhold', 'green hold piece');
						animation.addByPrefix('redhold', 'red hold piece');
						animation.addByPrefix('bluehold', 'blue hold piece');
						animation.addByPrefix('whitehold', 'white hold piece');
						animation.addByPrefix('yellowhold', 'yellow hold piece');
						animation.addByPrefix('violethold', 'violet hold piece');
						animation.addByPrefix('blackhold', 'black hold piece');
						animation.addByPrefix('darkhold', 'dark hold piece');
						setGraphicSize(Std.int(width * noteScale));
					}
				else{

				
				frames = Paths.getSparrowAtlas('NOTE_assets');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');
				animation.addByPrefix('whiteScroll', 'white0');
				animation.addByPrefix('yellowScroll', 'yellow0');
				animation.addByPrefix('violetScroll', 'violet0');
				animation.addByPrefix('blackScroll', 'black0');
				animation.addByPrefix('darkScroll', 'dark0');


				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');
				animation.addByPrefix('whiteholdend', 'white hold end');
				animation.addByPrefix('yellowholdend', 'yellow hold end');
				animation.addByPrefix('violetholdend', 'violet hold end');
				animation.addByPrefix('blackholdend', 'black hold end');
				animation.addByPrefix('darkholdend', 'dark hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
				animation.addByPrefix('whitehold', 'white hold piece');
				animation.addByPrefix('yellowhold', 'yellow hold piece');
				animation.addByPrefix('violethold', 'violet hold piece');
				animation.addByPrefix('blackhold', 'black hold piece');
				animation.addByPrefix('darkhold', 'dark hold piece');
				setGraphicSize(Std.int(width * noteScale));
				}

				if(noteType == 1){
				
				
					frames = Paths.getSparrowAtlas('fourth/mech/ALL_deathnotes', "clown");
					animation.addByPrefix('greenScroll', 'Green Arrow');
					animation.addByPrefix('redScroll', 'Red Arrow');
					animation.addByPrefix('blueScroll', 'Blue Arrow');
					animation.addByPrefix('purpleScroll', 'Purple Arrow');
					animation.addByPrefix('whiteScroll', 'White Arrow');
					animation.addByPrefix('yellowScroll', 'Green Arrow');
					animation.addByPrefix('violetScroll', 'Red Arrow');
					animation.addByPrefix('blackScroll', 'Blue Arrow');
					animation.addByPrefix('darkScroll', 'Purple Arrow');
					setGraphicSize(Std.int(width * noteScale));
					y -= 1000; //doesnt work for some fucking reason
					updateHitbox();
					if (PlayState.SONG.mania == 1)
						{
							x -= 145;
						}
					else if (PlayState.SONG.mania == 2)
						{
							x -= 120;
						}
					else
						x -= 170;

					
						
				}
				if(noteType == 2){
		
		
					frames = Paths.getSparrowAtlas('fourth/mech/ALL_accnotes', "clown");
					animation.addByPrefix('greenScroll', 'Green Arrow');
					animation.addByPrefix('redScroll', 'Red Arrow');
					animation.addByPrefix('blueScroll', 'Blue Arrow');
					animation.addByPrefix('purpleScroll', 'Purple Arrow');
					animation.addByPrefix('whiteScroll', 'White Arrow');
					animation.addByPrefix('yellowScroll', 'Green Arrow');
					animation.addByPrefix('violetScroll', 'Red Arrow');
					animation.addByPrefix('blackScroll', 'Blue Arrow');
					animation.addByPrefix('darkScroll', 'Purple Arrow');
					setGraphicSize(Std.int(width * noteScale));
					y -= 1000;
					updateHitbox();
					if (PlayState.SONG.mania == 1)
						{
							x -= 145;
						}
					else if (PlayState.SONG.mania == 2)
						{
							x -= 120;
						};
					else
						x -= 170;

					

				}
				if(noteType == 4)
				{
					frames = Paths.getSparrowAtlas('warningNote');
					animation.addByPrefix('greenScroll', 'Green Arrow');
					animation.addByPrefix('redScroll', 'Red Arrow');
					animation.addByPrefix('blueScroll', 'Blue Arrow');
					animation.addByPrefix('purpleScroll', 'Purple Arrow');
					animation.addByPrefix('whiteScroll', 'Blue Arrow');
					animation.addByPrefix('yellowScroll', 'Green Arrow');
					animation.addByPrefix('violetScroll', 'Red Arrow');
					animation.addByPrefix('blackScroll', 'Blue Arrow');
					animation.addByPrefix('darkScroll', 'Purple Arrow');
				}
					/*else
					{
						frames = Paths.getSparrowAtlas('NOTE_fire', "clown");
						if(!FlxG.save.data.downscroll){
							animation.addByPrefix('blueScroll', 'blue fire');
							animation.addByPrefix('greenScroll', 'green fire');
						}
						else{
							animation.addByPrefix('greenScroll', 'blue fire');
							animation.addByPrefix('blueScroll', 'green fire');
						}
						animation.addByPrefix('redScroll', 'red fire');
						animation.addByPrefix('purpleScroll', 'purple fire');
						if(FlxG.save.data.downscroll)
							flipY = true;
						x -= 50;
					}*/

				updateHitbox();
				antialiasing = true;
		}

		if (noteType == 1)
			{
				setGraphicSize(Std.int(width * 0.86));
				//updateHitbox();
			}
		if (noteType == 2)
			{
				setGraphicSize(Std.int(width * 0.86));
				//updateHitbox();
			}
			

		var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
		if (mania == 1) frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
		else if (mania == 2) frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];

		x += swagWidth * noteData;
		animation.play(frameN[noteData] + 'Scroll');

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;
			if (FlxG.save.data.downscroll)
			{
				scale.y *= -1;
			}

			x += width / 2;

			animation.play(frameN[noteData] + 'holdend');



			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;
			if (prevNote.isSustainNote)
				{
					switch (prevNote.noteData)
					{
						case 0:
						//nada
					}
					prevNote.animation.play(frameN[prevNote.noteData] + 'hold');
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed * (0.7 / noteScale);
					prevNote.updateHitbox();
					// prevNote.setGraphicSize();
				}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		//No held fire notes :[ (Part 2)
		//if(isSustainNote && prevNote.burning) { 
			//this.kill(); 
		//}

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit)
				tooLate = true;
		}
					
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}

			
			//mustPress = false;

	}
}