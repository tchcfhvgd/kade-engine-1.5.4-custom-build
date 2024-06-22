package;

import flixel.FlxG;
import flixel.system.FlxSound;
import haxe.display.Display.Package;
import haxe.io.Path;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets as LimeAssets;
import openfl.utils.Assets;
import PlayState;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['Easy', "Normal", "Hard"];

	public static function difficultyFromInt(difficulty:Int):String
	{
		return difficultyArray[difficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	
	public static function coolStringFile(path:String):Array<String>
		{
			var daList:Array<String> = path.trim().split('\n');
	
			for (i in 0...daList.length)
			{
				daList[i] = daList[i].trim();
			}
	
			return daList;
		}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function findFilesInPath(path:String, extns:Array<String>, ?filePath:Bool = false, ?deepSearch:Bool = true):Array<String>
	{
		var files:Array<String> = [];

		if (FileSystem.exists(path))
		{
			for (file in FileSystem.readDirectory(path))
			{
				var path = haxe.io.Path.join([path, file]);
				if (!FileSystem.isDirectory(path))
				{
					for (extn in extns)
					{
						if (file.endsWith(extn))
						{
							if (filePath)
								files.push(path);
							else
								files.push(file);
						}
					}
				}
				else if (deepSearch) // ! YAY !!!! -lunar
				{
					var pathsFiles:Array<String> = findFilesInPath(path, extns);

					for (_ in pathsFiles)
						files.push(_);
				}
			}
		}
		return files;
	}

	public static inline function getFileStringFromPath(file:String):String
	{
		return Path.withoutDirectory(Path.withoutExtension(file));
	}
}
