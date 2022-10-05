package core;

import flixel.FlxBasic;
import hscript.Interp;
import hscript.Parser;
import openfl.Lib;
import openfl.utils.Assets;

using StringTools;

/**
 * Class based originaly from Wednesdays-Infidelty Mod.
 * Credits: lunarcleint.
 */
class ScriptCore extends FlxBasic
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
			interp.execute(parser.parseString(Assets.getText(file)));
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
}
