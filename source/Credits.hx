package;

import lime.app.Application;
import lime.system.DisplayMode;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;

class CreditCatagory
{
	private var _credits:Array<Credit> = new Array<Credit>();
	public final function getCredits():Array<Credit>
	{
		return _credits;
	}

	public final function addCredit(opt:Credit)
	{
		_credits.push(opt);
	}

	
	public final function removeCredit(opt:Credit)
	{
		_credits.remove(opt);
	}

	private var _name:String = "New Catagory";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, credits:Array<Credit>)
	{
		_name = catName;
		_credits = credits;
	}
}

class Credit
{
	public function new()
	{
		display = updateDisplay();
	}
	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	
	// Returns whether the label is to be updated.
	public function press():Bool { return throw "stub!"; }
	private function updateDisplay():String { return throw "stub!"; }
	public function left():Bool { return throw "stub!"; }
	public function right():Bool { return throw "stub!"; }
}


class TestCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://www.youtube.com/channel/UCjXs9mcE531CrmaQrf0OkOw"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "TheZoroForce240 - made this mess (Link)";
	}
}

class HeckinLeBorkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://www.youtube.com/channel/UC8pdZkhQIhd8s0nJT60e3Ww"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "HeckinLeBork - made the Improbable Chaos Mashup (Link)";
	}
}

class LogManCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://www.youtube.com/channel/UCnGg-cLnXuQNfSzIq6xF8hw"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Log Man - made most of the 4k IC Rechart (Link)";
	}
}

class DaveCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://www.youtube.com/channel/UCog7mcapNPlf9sUlCQ0v48g"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Dave Suss Moggus - helped with the 4k IC Rechart (Link)";
	}
}

class ReqNGCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://www.youtube.com/channel/UCJ1EkFIysHUmkhGXveyGcNg"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "ReqNG - made some death sprites (Link)";
	}
}

class TrickyModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/44334"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class BanbudsCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Banbuds";
	}
}

class RozebudCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rosebud";
	}
}

class KadeCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Kade Dev";
	}
}

class CvalCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Cval";
	}
}

class YingYang48Credit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "YingYang48";
	}
}
class JADSCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "JADS";
	}
}

class MoroCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Moro";
	}
}

class SockClipCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Sock.Clip";
	}
}
class NateAnimCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Nate Anim8";
	}
}

class BbpanzuCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "bbpnazu";
	}
}

class ShaggyModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/284121"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class PerezCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "srPerez";
	}
}

class SEOSModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/166531"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class AtsuoverCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "atsuover";
	}
}

class RageminerCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rageminer";
	}
}

class DokkidoodlezCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Dokki.doodlez";
	}
}

class MikeGenoCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mike Geno";
	}
}

class KuroaoAnomalCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "kuroao_anomal";
	}
}

class TabiModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/286388"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class HomskiyCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Homskiy";
	}
}

class GWebDevCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "GWebDev";
	}
}

class BrightFyreCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "BrightFyre";
	}
}

class TenzubushiCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Tenzubushi";
	}
}

class DaDrawingLadCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "DaDrawingLad";
	}
}

class HexModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/44225"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class DjCatCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "DjCat";
	}
}

class AgotiModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/284934"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class TheInnuendoCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "The Innuendo";
	}
}

class SugarRatioCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "SugarRatio";
	}
}

class KullixCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Kullix";
	}
}
class BobModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/285296"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class WildyCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "wildythomas";
	}
}

class PhloxCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Phlox";
	}
}

class AetherDXCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "AetherDX";
	}
}



class Page2Credit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.switchState(new CreditsPage2Menu());
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Go to Page 2 (this is just the way it works, deal with it)";
	}
}
class GenoXCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "GenoX";
	}
}
class CarolModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/42811"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class MattModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/44511"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class OGTordModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/44406"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Original Mod Link";
	}
}
class NewTordModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/183165"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Remastered Version Mod Link";
	}
}

class ZardyModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/44366"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class ZardyReanimatedModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/183664"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Zardy Reanimated Mod Link";
	}
}
class MonikaModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/47364"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class GExEModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/292556"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class SSNModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/43252"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}
class HankModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/183655"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class HDModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/166446"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class HDSenpaiModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/185587"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class CassModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/286853"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class SundayModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/300849"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class NoteSkinModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/308757"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}

class ShaggyMattModLinkCredit extends Credit
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		var website:Array<String>;
		website = ["https://gamebanana.com/mods/301499"];
		FlxG.openURL(website[0]);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mod Link";
	}
}