package;

class Rank
{
	public static var accuracyArray:Array<Float> = [
		99.9935, 99.980, 99.950, 99.90, 99.80, 99.70, 99.50, 99, 96.50, 93, 90, 85, 80, 70, 60,
	];

	public static var gradeArray:Array<String> = [
		"P", "X", "X-", "SS+", "SS", "SS-", "S+", "S", "S-", "A+", "A", "A-", "B", "C", "D"
	];

	public static function accuracyToGrade(accuracy:Float):String
	{
		var grade:String = '';

		for (i in 0...accuracyArray.length)
		{
			trace(accuracyArray[i]);
			if (accuracy >= accuracyArray[i])
			{
				grade = gradeArray[i];
				trace(gradeArray[i]);
				break;
			}
		}

		trace(grade);
		return grade;
	}

	public static function ratingToHit(rating:String):Float
	{
		var hit:Float = 0;

		switch (rating)
		{
			case 'shit':
				hit = 0.1;
			case 'bad':
				hit = 0.35;
			case 'good':
				hit = 0.75;
			case 'sick':
				hit = 1;
		}

		return hit;
	}
}
