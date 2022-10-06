import('Paths');
import('flixel.FlxSprite');
import('flixel.graphics.frames.FlxAtlasFrames');
import('flixel.addons.display.FlxRuntimeShader');
import('flixel.addons.effects.FlxTrail');
import('openfl.filters.ShaderFilter');
import('openfl.utils.Assets');
import('states.PlayState');

var shader:FlxRuntimeShader;

function create()
{
	PlayState.isPixelAssets = true;

	var bg:FlxSprite = new FlxSprite(400, 200);
	bg.frames = FlxAtlasFrames.fromSparrow(Paths.returnGraphic('stages/schoolEvil/images/animatedEvilSchool'),
		Paths.xml('stages/schoolEvil/images/animatedEvilSchool'));
	bg.animation.addByPrefix('idle', 'background 2', 24);
	bg.animation.play('idle');
	bg.scrollFactor.set(0.8, 0.9);
	bg.scale.set(6, 6);
	PlayState.instance.add(bg);

	PlayState.instance.add(new FlxTrail(PlayState.instance.dad, null, 4, 24, 0.3, 0.069));

	shader = new FlxRuntimeShader(Paths.frag('shaders/vcr-distortion'), null);
	shader.setFloat('iTime', 0);
	shader.setBitmapData('iChannel', Assets.getBitmapData('assets/images/noise.png'));
	PlayState.instance.camHUD.setFilters([new ShaderFilter(shader)]);
}

var shaderTime:Float = 0;
function update(elapsed:Float)
{
	shaderTime += elapsed;
	shader.setFloat('iTime', shaderTime);
}
