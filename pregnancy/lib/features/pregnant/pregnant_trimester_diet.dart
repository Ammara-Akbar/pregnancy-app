import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';

class PregnantTrimesterDiet {
  const PregnantTrimesterDiet({
    required this.index,
    required this.label,
    required this.weekRange,
    required this.focusTitle,
    required this.focusBody,
    required this.nutrients,
    required this.meals,
    required this.includeFoods,
    required this.tips,
    required this.avoidItems,
  });

  final int index;
  final String label;
  final String weekRange;
  final String focusTitle;
  final String focusBody;
  final List<(IconData, String, String)> nutrients;
  final List<(IconData, String, String)> meals;
  final List<String> includeFoods;
  final List<(String, String)> tips;
  final List<String> avoidItems;

  static int trimesterIndexForWeek(int weeks) {
    if (weeks <= 13) return 0;
    if (weeks <= 27) return 1;
    return 2;
  }

  static List<PregnantTrimesterDiet> all() {
    return UserPreferences.instance.isDesi ? _desiPlans() : _intlPlans();
  }

  static PregnantTrimesterDiet forWeek(int weeks) {
    final plans = all();
    return plans[trimesterIndexForWeek(weeks).clamp(0, plans.length - 1)];
  }

  static List<PregnantTrimesterDiet> _desiPlans() => const [
        PregnantTrimesterDiet(
          index: 0,
          label: '1st Trimester',
          weekRange: 'Weeks 1–13',
          focusTitle: 'Settle nausea & build foundations',
          focusBody:
              'Small frequent meals, folic acid, and gentle hydration help you and baby through early weeks.',
          nutrients: [
            (Icons.eco_outlined, 'Folic acid', 'Leafy greens, daal, citrus, fortified atta'),
            (Icons.water_drop_outlined, 'Fluids', 'Water, ORS if needed, coconut water, lemon water'),
            (Icons.favorite_outline, 'Gentle protein', 'Eggs, yogurt, soft chicken, moong daal'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Banana oats porridge with almonds & a boiled egg'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Khichdi with yogurt, or roti + soft daal + spinach'),
            (Icons.apple, 'Snack', 'Roasted chana, fruit chaat, or plain yogurt with honey'),
            (Icons.nightlife_outlined, 'Dinner', 'Light chicken soup or fish with soft sabzi & roti'),
          ],
          includeFoods: [
            'Spinach, methi, bathua',
            'Lentils & chickpeas',
            'Dates, oranges, guava',
            'Curd / lassi (pasteurized)',
            'Whole-wheat roti & oats',
          ],
          tips: [
            ('Nausea tip', 'Keep dry toast, rusks, or ginger tea nearby. Eat before getting out of bed.'),
            ('Iron start', 'Add lemon to daal/saag so iron absorbs better.'),
            ('Prenatal', 'Take folic acid as advised by your doctor.'),
          ],
          avoidItems: [
            'Raw papaya & unwashed produce',
            'Unpasteurized milk / soft cheeses',
            'Street-food chaat with ice of unknown source',
            'Excess caffeine (limit chai/coffee)',
            'Alcohol & smoking',
          ],
        ),
        PregnantTrimesterDiet(
          index: 1,
          label: '2nd Trimester',
          weekRange: 'Weeks 14–27',
          focusTitle: 'Iron, calcium & steady energy',
          focusBody:
              'Appetite often returns — focus on iron-rich meals, calcium, and balanced plates for growth.',
          nutrients: [
            (Icons.bloodtype_outlined, 'Iron', 'Spinach, red meat (well cooked), dates, jaggery'),
            (Icons.opacity_outlined, 'Calcium', 'Milk, yogurt, paneer, sesame, ragi'),
            (Icons.bolt_outlined, 'Protein', 'Eggs, daal, chicken, fish, beans'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Egg omelette, whole-wheat toast & seasonal fruit'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Roti, chicken/daal, mixed sabzi, salad & yogurt'),
            (Icons.apple, 'Snack', 'Dates + handful of walnuts, or paneer tikka'),
            (Icons.nightlife_outlined, 'Dinner', 'Brown rice, fish curry or daal, and steamed veggies'),
          ],
          includeFoods: [
            'Palak, beetroot, pomegranate',
            'Milk, paneer, yogurt',
            'Eggs & lean meat',
            'Nuts & seeds',
            'Seasonal fruits',
          ],
          tips: [
            ('Anemia watch', 'Pair iron foods with citrus; avoid tea right after meals.'),
            ('Constipation', 'Add fiber (fruit, sabzi, water) and gentle walks.'),
            ('Calcium', 'Aim for 2–3 dairy servings daily if you tolerate them.'),
          ],
          avoidItems: [
            'High-mercury fish (shark, swordfish)',
            'Undercooked meat or eggs',
            'Excess fried / oily street snacks',
            'Herbal “detox” teas without doctor OK',
            'Raw sprouts from unsafe sources',
          ],
        ),
        PregnantTrimesterDiet(
          index: 2,
          label: '3rd Trimester',
          weekRange: 'Weeks 28–40',
          focusTitle: 'Small meals, omega-3 & comfort',
          focusBody:
              'Baby is gaining weight — keep meals smaller and frequent, rich in protein, calcium, and healthy fats.',
          nutrients: [
            (Icons.psychology_outlined, 'Omega-3', 'Fish (safe types), walnuts, flax seeds'),
            (Icons.restaurant_outlined, 'Protein', 'Eggs, daal, chicken, paneer for growth'),
            (Icons.local_drink_outlined, 'Hydration', 'Water, coconut water, soups — avoid excess salt'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Vegetable poha or oats with milk, nuts & fruit'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Roti, soft daal, sabzi, yogurt — smaller portions'),
            (Icons.apple, 'Snack', 'Fruit + yogurt, or roasted makhana with light salt'),
            (Icons.nightlife_outlined, 'Dinner', 'Grilled fish/chicken, mashed potato or soft rice, veggies'),
          ],
          includeFoods: [
            'Soft cooked veggies & soups',
            'Dates (if advised near term)',
            'Walnuts, flax / chia',
            'Milk & yogurt',
            'Lean proteins',
          ],
          tips: [
            ('Heartburn', 'Eat slowly, sit upright after meals, avoid very spicy/oily food at night.'),
            ('Swelling', 'Cut excess salt; keep legs elevated and drink water.'),
            ('Energy', 'Frequent small snacks beat one heavy meal.'),
          ],
          avoidItems: [
            'Very spicy, fried late-night meals',
            'Excess salt and packaged namkeen',
            'Unpasteurized juices',
            'Leftover food stored too long',
            'Any alcohol or smoking',
          ],
        ),
      ];

  static List<PregnantTrimesterDiet> _intlPlans() => const [
        PregnantTrimesterDiet(
          index: 0,
          label: '1st Trimester',
          weekRange: 'Weeks 1–13',
          focusTitle: 'Ease nausea & support early growth',
          focusBody:
              'Prioritize folate, gentle protein, and frequent small meals while your body adjusts.',
          nutrients: [
            (Icons.eco_outlined, 'Folate', 'Leafy greens, lentils, citrus, fortified cereals'),
            (Icons.water_drop_outlined, 'Hydration', 'Water, electrolyte drinks if nauseous'),
            (Icons.favorite_outline, 'Gentle protein', 'Eggs, yogurt, soft chicken, tofu'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Overnight oats with banana, berries & almond butter'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Chicken soup with whole-grain toast & salad'),
            (Icons.apple, 'Snack', 'Greek yogurt with honey, or crackers with cheese'),
            (Icons.nightlife_outlined, 'Dinner', 'Baked white fish with mashed potato & steamed greens'),
          ],
          includeFoods: [
            'Spinach, broccoli, kale',
            'Lentils & beans',
            'Oranges, berries, avocado',
            'Pasteurized dairy',
            'Whole grains & oats',
          ],
          tips: [
            ('Nausea tip', 'Keep crackers by the bed; try ginger tea or cold foods.'),
            ('Folate', 'Take prenatal vitamins with folic acid as prescribed.'),
            ('Smell triggers', 'Choose cooler, blander meals when smells bother you.'),
          ],
          avoidItems: [
            'Alcohol & smoking',
            'Unpasteurized milk / soft cheeses',
            'Raw or undercooked eggs & meat',
            'High-mercury fish',
            'Excess caffeine (limit coffee/tea)',
          ],
        ),
        PregnantTrimesterDiet(
          index: 1,
          label: '2nd Trimester',
          weekRange: 'Weeks 14–27',
          focusTitle: 'Iron, calcium & balanced plates',
          focusBody:
              'Energy often returns — build iron stores, support bone growth, and keep protein steady.',
          nutrients: [
            (Icons.bloodtype_outlined, 'Iron', 'Lean red meat, spinach, beans, fortified cereal'),
            (Icons.opacity_outlined, 'Calcium', 'Milk, yogurt, cheese, fortified plant milks'),
            (Icons.bolt_outlined, 'Protein', 'Eggs, poultry, fish, legumes, tofu'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Veggie omelette, whole-grain toast & fruit'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Quinoa bowl with chicken, greens & citrus dressing'),
            (Icons.apple, 'Snack', 'Apple with peanut butter, or cheese stick + fruit'),
            (Icons.nightlife_outlined, 'Dinner', 'Salmon, sweet potato & roasted vegetables'),
          ],
          includeFoods: [
            'Leafy greens & colorful veggies',
            'Dairy or fortified alternatives',
            'Lean meats & legumes',
            'Nuts & seeds',
            'Whole fruits',
          ],
          tips: [
            ('Iron tip', 'Pair plant iron with vitamin C; skip tea/coffee with meals.'),
            ('Constipation', 'Add fiber + water + daily walking.'),
            ('Calcium', 'Aim for ~3 dairy (or fortified) servings daily.'),
          ],
          avoidItems: [
            'Shark, swordfish, king mackerel',
            'Deli meats unless heated steaming hot',
            'Raw sprouts',
            'Unwashed produce',
            'Herbal supplements without clinician OK',
          ],
        ),
        PregnantTrimesterDiet(
          index: 2,
          label: '3rd Trimester',
          weekRange: 'Weeks 28–40',
          focusTitle: 'Small meals, omega-3 & comfort',
          focusBody:
              'Baby gains weight quickly — favor frequent light meals with protein, calcium, and healthy fats.',
          nutrients: [
            (Icons.psychology_outlined, 'Omega-3 (DHA)', 'Salmon, sardines, walnuts, fortified eggs'),
            (Icons.restaurant_outlined, 'Protein', 'Eggs, poultry, beans, Greek yogurt'),
            (Icons.local_drink_outlined, 'Fluids', 'Water and soups; watch excess sodium'),
          ],
          meals: [
            (Icons.wb_sunny_outlined, 'Breakfast', 'Greek yogurt parfait with oats, berries & chia'),
            (Icons.lunch_dining_outlined, 'Lunch', 'Turkey wrap with salad, or lentil soup + bread'),
            (Icons.apple, 'Snack', 'Banana smoothie or handful of mixed nuts'),
            (Icons.nightlife_outlined, 'Dinner', 'Grilled chicken, soft rice or pasta, steamed veggies'),
          ],
          includeFoods: [
            'Fatty fish (2x/week, safe types)',
            'Nuts, seeds, avocado',
            'Dairy or fortified options',
            'Soft cooked vegetables',
            'Lean proteins',
          ],
          tips: [
            ('Heartburn', 'Smaller meals, sit upright after eating, limit spicy late dinners.'),
            ('Swelling', 'Reduce salty packaged foods; elevate feet and hydrate.'),
            ('Sleep energy', 'Keep a light bedtime snack if hunger wakes you.'),
          ],
          avoidItems: [
            'Heavy fried late-night meals',
            'Excess salt & processed snacks',
            'Unpasteurized juices',
            'Undercooked seafood or meat',
            'Alcohol & smoking',
          ],
        ),
      ];
}
