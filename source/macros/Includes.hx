package macros;

import haxe.macro.Compiler;
import haxe.macro.Expr;

class Includes
{
	public static macro function run():Expr
	{
		#if !display
		Compiler.include('flixel');
		#if sys
		Compiler.include('sys');
		#end
		Compiler.include('haxe.crypto');
		Compiler.include('spinehaxe');
		#if android
		Compiler.include('android');
		#end
		Compiler.include('haxe.crypto');
		Compiler.include('DateTools');
		Compiler.include('Reflect');
		Compiler.include('EReg');
		Compiler.include('Lambda');
		Compiler.include('StringBuf');
		Compiler.include('StringTools');
		#if cpp
                Compiler.include('cpp.RawPointer');
                Compiler.include('cpp.Pointer');
		#end
		#end
		return macro $v{null};
	}
}
