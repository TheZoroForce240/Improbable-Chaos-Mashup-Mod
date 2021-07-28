package;

import openfl.Lib;
import Credits;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class CreditsPage2Menu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var credits:Array<CreditCatagory> = [
		new CreditCatagory("VS Zardy Link", [
			new ZardyModLinkCredit("the credit"),
			new ZardyReanimatedModLinkCredit("the credit")
		]),
		new CreditCatagory("VS Monika Link", [
			new MonikaModLinkCredit("the credit")
		]),	
		new CreditCatagory("God-Eater x Expurgation Mechanics Link", [
			new GExEModLinkCredit("the credit")
		]),	
		new CreditCatagory("Salty Sunday Nights Link", [
			new SSNModLinkCredit("the credit")
		]),	
		new CreditCatagory("Hank over Tricky Link", [
			new HankModLinkCredit("the credit")
		]),	
		new CreditCatagory("FNF HD Link", [
			new HDModLinkCredit("the credit")
		]),	
		new CreditCatagory("HD Senpai Link", [
			new HDSenpaiModLinkCredit("the credit")
		]),	
		new CreditCatagory("VS Cassandra Link", [
			new CassModLinkCredit("the credit")
		]),	
		new CreditCatagory("VS Sunday Link", [
			new SundayModLinkCredit("the credit")
		]),	
		new CreditCatagory("Tabi Note Skin Link", [
			new NoteSkinModLinkCredit("the credit")
		]),
		new CreditCatagory("Shaggy x Matt Link", [
			new ShaggyMattModLinkCredit("the credit")
		])
	];

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<OptionText>;
	public static var versionShit:FlxText;

	public var currentCredits:Array<FlxText> = [];

	var targetY:Array<Float> = [];

	var currentSelectedCat:CreditCatagory;

	var menuShade:FlxSprite;

	var offsetPog:FlxText;

	override function create()
	{
		var bg:FlxSprite = new FlxSprite(-10,-10).loadGraphic(Paths.image('menu/freeplay/RedBG','clown'));
		add(bg);
		var hedge:FlxSprite = new FlxSprite(-810,-335).loadGraphic(Paths.image('menu/freeplay/hedge','clown'));
		hedge.setGraphicSize(Std.int(hedge.width * 0.65));
		add(hedge);
		var shade:FlxSprite = new FlxSprite(-205,-100).loadGraphic(Paths.image('menu/freeplay/Shadescreen','clown'));
		shade.setGraphicSize(Std.int(shade.width * 0.65));
		add(shade);
		var bars:FlxSprite = new FlxSprite(-225,-395).loadGraphic(Paths.image('menu/freeplay/theBox','clown'));
		bars.setGraphicSize(Std.int(bars.width * 0.65));
		add(bars);



		
		for (i in 0...credits.length)
		{
			var credit:CreditCatagory = credits[i];

			var text:FlxText = new FlxText(125,(40 * i) + 100, 0, credit.getName(),34);
			text.color = FlxColor.fromRGB(255,0,0);
			text.setFormat("tahoma-bold.ttf", 25, FlxColor.RED);
			add(text);
			currentCredits.push(text);

			targetY[i] = i;

			trace('option king ' );
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		currentDescription = "none";

		currentCredits[0].color = FlxColor.WHITE;

		offsetPog = new FlxText(125,600,0,"Offset: " + FlxG.save.data.offset);
		offsetPog.setFormat("tahoma-bold.ttf",42,FlxColor.RED);

		menuShade = new FlxSprite(-1350,-1190).loadGraphic(Paths.image("menu/freeplay/Menu Shade","clown"));
		menuShade.setGraphicSize(Std.int(menuShade.width * 0.7));
		add(menuShade);
		super.create();
	}

	var isCat:Bool = false;
	

	function resyncVocals():Void
		{
			MusicMenu.Vocals.pause();
	
			FlxG.sound.music.play();
			MusicMenu.Vocals.time = FlxG.sound.music.time;
			MusicMenu.Vocals.play();
		}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (MusicMenu.Vocals != null)
		{
			if (MusicMenu.Vocals.playing)
			{
				if (FlxG.sound.music.time > MusicMenu.Vocals.time + 20 || FlxG.sound.music.time < MusicMenu.Vocals.time - 20)
                    resyncVocals();
			}
		}


			if (controls.BACK && !isCat)
				FlxG.switchState(new CreditsMenu());
			else if (controls.BACK)
			{
				isCat = false;
				for (i in currentCredits)
					remove(i);
				currentCredits = [];
				for (i in 0...credits.length)
					{
						// redo shit
						var credit:CreditCatagory = credits[i];
					
						var text:FlxText = new FlxText(125,(40 * i) + 100, 0, credit.getName(),34);
						text.color = FlxColor.fromRGB(255,0,0);
						text.setFormat("tahoma-bold.ttf", 25, FlxColor.RED);
						add(text);
						currentCredits.push(text);
					}
				remove(menuShade);
				add(menuShade);
				curSelected = 0;
				currentCredits[curSelected].color = FlxColor.WHITE;
			}
			if (FlxG.keys.justPressed.UP)
				changeSelection(-1);
			if (FlxG.keys.justPressed.DOWN)
				changeSelection(1);
			
			if (isCat)
			{
				if (currentSelectedCat.getCredits()[curSelected].getAccept())
				{
					if (FlxG.keys.pressed.SHIFT)
						{
							if (FlxG.keys.pressed.RIGHT)
							{
								currentSelectedCat.getCredits()[curSelected].right();
								currentCredits[curSelected].text = currentSelectedCat.getCredits()[curSelected].getDisplay();
							}
							if (FlxG.keys.pressed.LEFT)
							{
								currentSelectedCat.getCredits()[curSelected].left();
								currentCredits[curSelected].text = currentSelectedCat.getCredits()[curSelected].getDisplay();
							}
						}
					else
					{
						if (FlxG.keys.justPressed.RIGHT)
						{
							currentSelectedCat.getCredits()[curSelected].right();
							currentCredits[curSelected].text = currentSelectedCat.getCredits()[curSelected].getDisplay();
						}
						if (FlxG.keys.justPressed.LEFT)
						{
							currentSelectedCat.getCredits()[curSelected].left();
							currentCredits[curSelected].text = currentSelectedCat.getCredits()[curSelected].getDisplay();
						}
					}
				}
				else
				{
					
				}
			}	
			else
			{
		
			}


			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound("confirm",'clown'));
				if (isCat)
				{
					if (currentSelectedCat.getCredits()[curSelected].press()) {
						// select thingy and redo itself
						for (i in currentCredits)
							remove(i);
						currentCredits = [];
						for (i in 0...currentSelectedCat.getCredits().length)
							{
								// clear and redo everything else
								var credit:Credit = currentSelectedCat.getCredits()[i];

								trace(credit.getDisplay());

								var text:FlxText = new FlxText(125,(55 * i) + 100, 0, credit.getDisplay(),34);
								text.color = FlxColor.fromRGB(255,0,0);
								text.setFormat("tahoma-bold.ttf", 30, FlxColor.RED);
								add(text);
								currentCredits.push(text);
							}
							remove(menuShade);
							add(menuShade);
							trace('done');
							currentCredits[curSelected].color = FlxColor.WHITE;
					}
				}
				else
				{
					currentSelectedCat = credits[curSelected];
					isCat = true;
					for (i in currentCredits)
						remove(i);
					currentCredits = [];
					for (i in 0...currentSelectedCat.getCredits().length)
						{
							// clear and redo everything else
							var credit:Credit = currentSelectedCat.getCredits()[i];

							trace(credit.getDisplay());

							var text:FlxText = new FlxText(125,(55 * i) + 100, 0, credit.getDisplay(),34);
							text.color = FlxColor.fromRGB(255,0,0);
							text.setFormat("tahoma-bold.ttf", 30, FlxColor.RED);
							add(text);
							currentCredits.push(text);
						}
						remove(menuShade);
						add(menuShade);
					curSelected = 0;
					currentCredits[curSelected].color = FlxColor.WHITE;
				}
			}
		FlxG.save.flush();
	}


	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent("Fresh");
		#end
		
		FlxG.sound.play(Paths.sound("Hover",'clown'));

		currentCredits[curSelected].color = FlxColor.fromRGB(255,0,0);

		curSelected += change;

		if (curSelected < 0)
			curSelected = currentCredits.length - 1;
		if (curSelected >= currentCredits.length)
			curSelected = 0;


		currentCredits[curSelected].color = FlxColor.WHITE;

		var bullShit:Int = 0;
	}
}