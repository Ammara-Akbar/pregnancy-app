import '../preferences/user_preferences.dart';

class RegionalMeal {
  const RegionalMeal(this.name, this.detail);

  final String name;
  final String detail;
}

abstract final class RegionalContent {
  static bool get _desi => UserPreferences.instance.isDesi;

  static String dietSectionBlurb() => _desi
      ? 'Balanced Desi meals to build energy, glowing skin, and a healthy body before your big day.'
      : 'Balanced international meals to build energy, glowing skin, and a healthy body before your big day.';

  static String dietPlanOverviewLine() => _desi
      ? 'Desi & international diet options to build a healthy body'
      : 'Global diet plans to build a healthy body';

  static List<(String, String)> brideHomeMeals() => _desi
      ? const [
          ('Breakfast', 'Oats with milk, almonds & dates'),
          ('Lunch', 'Roti, daal, spinach & yogurt'),
          ('Evening Snack', 'Fruit chaat or roasted chana'),
          ('Dinner', 'Grilled chicken with veggies'),
        ]
      : const [
          ('Breakfast', 'Greek yogurt with berries & granola'),
          ('Lunch', 'Grilled chicken salad with quinoa'),
          ('Evening Snack', 'Apple with peanut butter'),
          ('Dinner', 'Baked salmon with roasted vegetables'),
        ];

  static List<
      ({
        String day,
        String focus,
        List<(String, String)> meals,
      })> brideMealPlans() {
    if (_desi) {
      return const [
        (
          day: 'Today',
          focus: 'Iron & energy',
          meals: [
            ('Breakfast', 'Oats with milk, almonds & dates'),
            ('Lunch', 'Roti, daal, spinach & yogurt'),
            ('Evening Snack', 'Fruit chaat or roasted chana'),
            ('Dinner', 'Grilled chicken with veggies'),
          ],
        ),
        (
          day: 'Tomorrow',
          focus: 'Glow & hydration',
          meals: [
            ('Breakfast', 'Egg omelette with whole wheat toast'),
            ('Lunch', 'Brown rice, mixed sabzi & raita'),
            ('Evening Snack', 'Handful of walnuts & green tea'),
            ('Dinner', 'Fish curry with salad'),
          ],
        ),
        (
          day: 'Day 3',
          focus: 'Folic acid rich',
          meals: [
            ('Breakfast', 'Banana smoothie with flax seeds'),
            ('Lunch', 'Chickpea salad with lemon dressing'),
            ('Evening Snack', 'Carrot sticks with hummus'),
            ('Dinner', 'Lentil soup with whole grain roti'),
          ],
        ),
      ];
    }

    return const [
      (
        day: 'Today',
        focus: 'Iron & energy',
        meals: [
          ('Breakfast', 'Overnight oats with berries & almonds'),
          ('Lunch', 'Turkey wrap with leafy greens'),
          ('Evening Snack', 'Trail mix or fruit cup'),
          ('Dinner', 'Grilled chicken with sweet potato'),
        ],
      ),
      (
        day: 'Tomorrow',
        focus: 'Glow & hydration',
        meals: [
          ('Breakfast', 'Avocado toast with boiled eggs'),
          ('Lunch', 'Quinoa bowl with roasted veggies'),
          ('Evening Snack', 'Greek yogurt with honey'),
          ('Dinner', 'Baked fish with steamed broccoli'),
        ],
      ),
      (
        day: 'Day 3',
        focus: 'Folic acid rich',
        meals: [
          ('Breakfast', 'Spinach smoothie with banana'),
          ('Lunch', 'Lentil soup with whole-grain bread'),
          ('Evening Snack', 'Carrot sticks with hummus'),
          ('Dinner', 'Chickpea salad with citrus dressing'),
        ],
      ),
    ];
  }

  static List<(String, String, String)> brideNutritionTips() => _desi
      ? const [
          (
            'Stay hydrated',
            'Aim for 8–10 glasses of water daily for glowing skin.',
            'water',
          ),
          (
            'Folic acid foods',
            'Include spinach, lentils, citrus and fortified cereals.',
            'eco',
          ),
          (
            'Iron boosters',
            'Pair iron-rich meals like saag and daal with vitamin C.',
            'heart',
          ),
          (
            'Limit junk',
            'Cut fried snacks and sugary drinks before your wedding.',
            'nofood',
          ),
        ]
      : const [
          (
            'Stay hydrated',
            'Aim for 8–10 glasses of water daily for glowing skin.',
            'water',
          ),
          (
            'Folic acid foods',
            'Include leafy greens, beans, citrus and fortified cereals.',
            'eco',
          ),
          (
            'Iron boosters',
            'Pair lean meats, lentils and spinach with vitamin C foods.',
            'heart',
          ),
          (
            'Limit junk',
            'Reduce fried food and sugary drinks before your wedding.',
            'nofood',
          ),
        ];
}
