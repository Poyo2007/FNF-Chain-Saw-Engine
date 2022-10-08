package;

import states.PlayState;

class Rank
{
	public static function accuracyToGrade(accuracy:Float):String
	{
		var grade:String = '';

		var wifeConditions:Array<Bool> = [
			accuracy >= 99.9935, // P
			accuracy >= 99.980, // X
			accuracy >= 99.950, // X-
			accuracy >= 99.90, // SS+
			accuracy >= 99.80, // SS
			accuracy >= 99.70, // SS-
			accuracy >= 99.50, // S+
			accuracy >= 99, // S
			accuracy >= 96.50, // S-
			accuracy >= 93, // A+
			accuracy >= 90, // A
			accuracy >= 85, // A-
			accuracy >= 80, // B
			accuracy >= 70, // C
			accuracy >= 60, // D
			accuracy < 60 // E
		];

		for (i in 0...wifeConditions.length)
		{
			if (wifeConditions[i])
			{
				switch (i)
				{
					case 0:
						grade = "P";
					case 1:
						grade = "X";
					case 2:
						grade = "X-";
					case 3:
						grade = "SS+";
					case 4:
						grade = "SS";
					case 5:
						grade = "SS-";
					case 6:
						grade = "S+";
					case 7:
						grade = "S";
					case 8:
						grade = "S-";
					case 9:
						grade = "A+";
					case 10:
						grade = "A";
					case 11:
						grade = "A-";
					case 12:
						grade = "B";
					case 13:
						grade = "C";
					case 14:
						grade = "D";
					case 15:
						grade = "E";
				}

				break;
			}
		}

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
