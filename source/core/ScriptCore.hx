package core;

import hscript.Interp;
import hscript.Parser;
import openfl.Lib;
import openfl.utils.Assets;
import haxe.crypto.Md5;

using StringTools;

/**
 * Class based originaly from Wednesdays-Infidelty Mod.
 * Credits: lunarcleint.
 */
class ScriptCore // (sirox) idk why FlxBasic was there, is useless for hscript though
{
	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

	private var parser:Parser;
	private var interp:Interp;

	public function new(file:String)
	{
		super();

		parser = new Parser();
		parser.allowJSON = true;
		parser.allowTypes = true;
		parser.allowMetadata = true;

		interp = new Interp();

		setVariable('this', this);
		setVariable('import', function(daClass:String)
		{
			final splitClassName:Array<String> = [for (e in daClass.split('.')) e.trim()];
			final className:String = splitClassName.join('.');
			final daClass:Class<Dynamic> = Type.resolveClass(className);
			final daEnum:Enum<Dynamic> = Type.resolveEnum(className);

			if (daClass == null && daEnum == null)
				Lib.application.window.alert('Class / Enum at $className does not exist.', 'Hscript Error!');
			else
			{
				if (daEnum != null)
				{
					for (daConstructor in daEnum.getConstructors())
						Reflect.setField({}, daConstructor, daEnum.createByName(daConstructor));
					setVariable(splitClassName[splitClassName.length - 1], {});
				}
				else
					setVariable(splitClassName[splitClassName.length - 1], daClass);
			}
		});
		setVariable('Function_Stop', Function_Stop);
		setVariable('Function_Continue', Function_Continue);
		setVariable('Reflect', Reflect);
		setVariable('Sys', Sys);
		setVariable('Array', Array);
		setVariable('Type', Type);
		setVariable('Std', Std);
		setVariable('DateTools', DateTools);
		setVariable('Math', Math);
		setVariable('StringTools', StringTools);
		setVariable('Sys', Sys);
		setVariable('Xml', Xml);

		try
		{
			interp.execute(parser.parseString(file.endsWith(".ehx") ? decode(Assets.getText(file)) : Assets.getText(file)));
		}
		catch (e:Dynamic)
			Lib.application.window.alert(e, 'Hscript Error!');

		trace('Script Loaded Succesfully: $file');

		executeFunc('create', []);
	}

	public function setVariable(name:String, val:Dynamic):Void
	{
		if (interp == null)
			return;

		try
		{
			interp.variables.set(name, val);
		}
		catch (e:Dynamic)
			Lib.application.window.alert(e, 'Hscript Error!');
	}

	public function getVariable(name:String):Dynamic
	{
		if (interp == null)
			return null;

		try
		{
			return interp.variables.get(name);
		}
		catch (e:Dynamic)
			Lib.application.window.alert(e, 'Hscript Error!');

		return null;
	}

	public function removeVariable(name:String):Void
	{
		if (interp == null)
			return;

		try
		{
			interp.variables.remove(name);
		}
		catch (e:Dynamic)
			Lib.application.window.alert(e, 'Hscript Error!');
	}

	public function existsVariable(name:String):Bool
	{
		if (interp == null)
			return false;

		try
		{
			return interp.variables.exists(name);
		}
		catch (e:Dynamic)
			Lib.application.window.alert(e, 'Hscript Error!');

		return false;
	}

	public function executeFunc(funcName:String, args:Array<Dynamic>):Dynamic
	{
		if (interp == null)
			return null;

		if (existsVariable(funcName))
		{
			try
			{
				return Reflect.callMethod(this, getVariable(funcName), args);
			}
			catch (e:Dynamic)
				Lib.application.window.alert(e, 'Hscript Error!');
		}

		return null;
	}

	override function destroy()
	{
		super.destroy();
		parser = null;
		interp = null;
	}
	
	private var cryptMap:Map<String, String> = [];
	
	// (sirox) decode this is literally impossible without decode function, pog
	public static function encode(input:String):String {
		var resultThing:String = "";
		if (cryptMap.length < 1) {
			setupCryptMap();
		}
		for (i in 0...input.length) {
			resultThing += cryptMap.get(input.substr(i, 1));
		}
		return resultThing;
	}
	
	private function decode(input:String) {
		var resultThing:String = "";
		if (cryptMap.length < 1) {
			setupCryptMap();
		}
		resultThing = input;
		for (i in cryptMap.keys()) {
			resultThing = resultThing.replace(cryptMap.get(i), i);
		}
		return resultThing;
	}
	
	private function setupCryptMap() { // (sirox) the most encoded thing in my life
		cryptMap = [
		    "a" => Md5.encode("keb3b3kowh3jenenekemenn330s9nxrmej4n"),
		    "b" => Md5.encode("oebejoj3b3enejenb329zjenekeozjdemnne6"),
		    "c" => Md5.encode("e92u3j3i3983me3o9wk2nw9zkjd9keorm3m"),
		    "d" => Md5.encode("q3b3h3oe98sj3m3ne9d9o3m4kedjx9m3i4j3"),
		    "e" => Md5.encode("kejenen3nenmekeoxoxicnen3k3kem3moeme"),
		    "f" => Md5.encode("o2n302skn3ow8dj3k3e73n3k33jsnenro3in3"),
		    "g" => Md5.encode("jen3n3oe9djenenejie8xjsnn33nneirje3nnrnr"),
		    "h" => Md5.encode("ekn3n4m4o39d8ndnen4nek3j4nrn49sjndm3"),
		    "i" => Md5.encode("j3nrb49ei3n4n3ixj83hrbrn3j3n3i3jek3n8nrj"),
		    "j" => Md5.encode("3k3n3n39s9ien3n3din3n383n4n39xihrkenn3"),
		    "k" => Md5.encode("ej3bb4o3ie8xin3n3n9dxjxnei38i3n3n3m3n3"),
		    "l" => Md5.encode("ien3n3k393883j3n3je9dijenn33883j3n3n33"),
		    "m" => Md5.encode("4j4n3n3939833in3n4n49393j3n3n498n3n"),
		    "n" => Md5.encode("394inrn4k4o483j4nn4k49e83j3nri3938j3n"),
		    "o" => Md5.encode("e039o303o2k3n393i3jrn3ne9xi3j3nn3i33n"),
		    "p" => Md5.encode("83iej4n4n4j3i393i3jneneo38383j3n3ne83y"),
		    "q" => Md5.encode("2ij3n4nr8d9e83n4nrkr9338j4n3nrir8ei3jn3"),
		    "r" => Md5.encode("83i3i4jrnrjrk4i8393i38r8e83j4nn3n3k3ij3"),
		    "s" => Md5.encode("uhh7uhj4j4n4j3i3j3n3n3n3n3i3ij3n4nr8djej"),
		    "t" => Md5.encode("3kkeke8e8383nene9d9ekenend9s9i3jenen37"),
		    "u" => Md5.encode("3i3jjebrnrix8z8ekkeneo39393j3nekdid82in3"),
		    "v" => Md5.encode("iej3n3o39393kk3n3e99eo3jenen3i3j3nd8du"),
		    "w" => Md5.encode("en3je89eosken4neo9d8di3jrndk8d8eiej4n4j"),
		    "x" => Md5.encode("3j3je88sizjsmsos99diejeneow939ekejkeo33"),
		    "y" => Md5.encode("wjnenene8e9z9eoeknenek3ie8e83k3nen3i3ne"),
		    "z" => Md5.encode("4j4k399eoekendnxke9o3o3kemekxoe9eoiem"),
		    "A" => Md5.encode("i3kenri39e9eoeknenei3oe9e9eoejdnndoeoeje"),
		    "B" => Md5.encode("iejej39e9e9eo3knenrod9d93oeknek3k3ieoek"),
		    "C" => Md5.encode("rjjeie9e9eo3kenenir8diekdjdoe9ekmekedkk"),
		    "D" => Md5.encode("ejjeej8e9d9x9ekmeneeo9e9e9eoemdnkkene"),
		    "E" => Md5.encode("ejejenenri39d8xiejenen3n3keox8d89eiejen9"),
		    "F" => Md5.encode("ofofofmrmrkoe9soek2j2o29292927380eozj"),
		    "G" => Md5.encode("ekejeo3o3o3j3nn3m3oeodixj3n29290e739ej"),
		    "H" => Md5.encode("rjei389393oeoeksjdnejieiejenekeod9xiididie"),
		    "I" => Md5.encode("eieie88ei3jendnd89xoekeneje9d9dkeneje8eo"),
		    "J" => Md5.encode("ejieieisoekenenxiixieiekenen3nei839292uejej"),
		    "K" => Md5.encode("7eisjsjsozo9sowkenenenrksixoekmenenemenej"),
		    "L" => Md5.encode("eiei8s8ei3jennes89x9wowjeje8s9xekje8eieken"),
		    "M" => Md5.encode("ririri9e93o3kejrn4ji3i3i3o3o939e9d9xoejdj"),
		    "N" => Md5.encode("3ie9e9e9o3kenemsox9z9owkenenem3ieoemm"),
		    "O" => Md5.encode("r83939eokrnrjd8x9soekemnee8e9eoekdndne"),
		    "P" => Md5.encode("sie9e9393iejjenrj3ieieoe9xodoeokenen3j3ie8"),
		    "Q" => Md5.encode("38e839oeo3kejendndkoeoeowkwmem3nkei3k3"),
		    "R" => Md5.encode("eie8e93ok3nenejdix8x9eokememwo29woekeme"),
		    "S" => Md5.encode("eie839k3jenrnekeie9s9osk3m3n3839eo3kn3ne"),
		    "T" => Md5.encode("e883iejenendjxidokemenrnei28wo3kn3ndkdido"),
		    "U" => Md5.encode("ejdid89doeoejenrjei8e9e93k3m3nm3oe9d9doe"),
		    "V" => Md5.encode("ue8e9sodkdnenejwioeo3j3j38e93k3nenek399e"),
		    "W" => Md5.encode("hei3i3k3j3nn3ei8eododkenenjei3kenenejeken"),
		    "X" => Md5.encode("rurie8e8oek3j3nrbdjduidi3i3k3nen4h4u3ii3k3"),
		    "Y" => Md5.encode("3j3heieidoeokenejeieidodkdjjr3ii3o3k3j3j3j3j"),
		    "Z" => Md5.encode("bejeieoeoeknenejejejekekkeneieidodoekmen3n"),
		    "1" => Md5.encode("j3je8e9e93oekendme99e93o3o3kendjid9r9do"),
		    "2" => Md5.encode("ejj38e8d9393iejnejdix8doekenendi8xodkejen"),
		    "3" => Md5.encode("4j4ir89r93i3jrjfic89ekenenduxiiejej39wo2jw9"),
		    "4" => Md5.encode("rj4j488roekdjend8d89eowoeoekenebeud8osiek"),
		    "5" => Md5.encode("373uu3jrhrjrjeieiiej3nrjei38o3kekejekekekenm"),
		    "6" => Md5.encode("jeie9d9doeokeneneod9d9pdodkemeneoo3k3mem"),
		    "7" => Md5.encode("3uie839eoo3kenenene839eodokdkdbej2i2ooeken"),
		    "8" => Md5.encode("iej3heie8d8x8oeowkeneid8x8s9eowoke399ejdo3"),
		    "9" => Md5.encode("eiie9d9dodkenen3kei9eoeoekemeneie9e9odkneoe"),
		    "0" => Md5.encode("k3i3ie9eoekekennr3j8e9e9e9eoeoememei9doekd"),
		    "$" => Md5.encode("jeoe9w9wo2mendjxi8eo2owo2o299wowkdmdm3o"),
		    "#" => Md5.encode("2o2i29keneje9e9wkwmsnziiwowkwkendnei2iwowo"),
		    ";" => Md5.encode("eojeje83929woenenej8e9d9doemn3nex89e9eodkn"),
		    "'" => Md5.encode("eo3nn3939392o2j3nenei83929292o3men3n3io3j3"),
		    ":" => Md5.encode("wjjeneje8e9d9eokenskzow99w92kwnenie8ienje8ne"),
		    "@" => Md5.encode("3j3jie9e9393o3knrnrjroe9e9eoo3k3memem3nei9x"),
		    "&" => Md5.encode("jeje9eoekenenjeie83owkekmeneie9eoekekenebi3en"),
		    "_" => Md5.encode("ejje9e9e9ekenndjeiei39293okeneie9ekdjdje8e939"),
		    "-" => Md5.encode("euie9393o3nrndix89e93o3k3nejei3993o3oek3j3mem"),
		    "+" => Md5.encode("ejje8e93o3o3jenneneid8e93o3okendnxjei39oeoeoem"),
		    "(" => Md5.encode("jejeu38383i3kj4nrix8d8e93o3k3jjrf88r93o3k3kd8"),
		    ")" => Md5.encode("jeje8eoeo3kendndie8o3o3k3neje838e8eieij3nen3i3j"),
		    "/" => Md5.encode("3ueu383iekndjd9d9e93kekennrri8dodo3k3nej8ejf3j"),
		    "*" => Md5.encode("heue8393o3oejjrj338393o3k3nenu38eosksj3nnenej"),
		    "=" => Md5.encode("eueu388393o3kenndxie8o2o3kenrnrj3i38oeoemrnrn"),
		    "!" => Md5.encode("jeieo393o3kneneneie83oeoken3nen3i8eo3ok3nenei3i3"),
		    "?" => Md5.encode("4ir9oekdndnrie8e99393kenen3j3ie9d9orkenen3jn3"),
		    "~" => Md5.encode("jeje8e9eoekrjxjid83939393o3oek3mn3i39e9eoekem"),
		    "`" => Md5.encode("3uie939eodkej3j38e99d9e93k3nenrndid8939393oek"),
		    "|" => Md5.encode("3heue89eo3j3nehe7e8e9oejeneud8diekjejei3i33nn3j"),
		    "^" => Md5.encode("i39eoeodkdndie992o2o3k3n3j2o2k3k3jeieiekenejne"),
		    "{" => Md5.encode("neue8e9393oeirjjx8d92o2k2m2ne89s9eoekenej33i3n"),
		    "}" => Md5.encode("ehue8393o3k3nenei8d9d929eojenenei3838eken3ndnei"),
		    "\" => Md5.encode("jeie8s9sozken2j2892o2keneje8e9eijejejeieoek3neieje"),
		    "%" => Md5.encode("2ji39e9eo3k3k3j388e9eoeoekenekieoekejej38eienn3je"),
		    "[" => Md5.encode("ehei9e9eoekemeje8e9eoekeneneje8e99eoekenendjie8wo"),
		    "]" => Md5.encode("jwue8e93oekennee7x88xowieneneiw82owkennde8jen38"),
		];
	}
}
