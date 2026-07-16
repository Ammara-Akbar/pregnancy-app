import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';

enum SymptomKind { sickness, illness, pain }

enum PainLevel {
  mild(1, 'Mild'),
  mildModerate(2, 'Mild–Moderate'),
  moderate(3, 'Moderate'),
  moderateHigh(4, 'Moderate–High'),
  variable(2, 'Variable');

  const PainLevel(this.score, this.label);
  final int score;
  final String label;
}

class PregnantSymptom {
  const PregnantSymptom({
    required this.title,
    required this.kind,
    required this.painLevel,
    required this.howCommon,
    required this.whatItFeelsLike,
    required this.whatHelps,
    required this.seekCareIf,
  });

  final String title;
  final SymptomKind kind;
  final PainLevel painLevel;
  final String howCommon;
  final String whatItFeelsLike;
  final String whatHelps;
  final String seekCareIf;

  String get kindLabel {
    switch (kind) {
      case SymptomKind.sickness:
        return 'Sickness';
      case SymptomKind.illness:
        return 'Illness risk';
      case SymptomKind.pain:
        return 'Pain';
    }
  }

  IconData get kindIcon {
    switch (kind) {
      case SymptomKind.sickness:
        return Icons.sick_outlined;
      case SymptomKind.illness:
        return Icons.coronavirus_outlined;
      case SymptomKind.pain:
        return Icons.healing_outlined;
    }
  }
}

class PregnantTrimesterSymptoms {
  const PregnantTrimesterSymptoms({
    required this.index,
    required this.label,
    required this.weekRange,
    required this.focusTitle,
    required this.focusBody,
    required this.comfortNote,
    required this.symptoms,
    required this.redFlags,
  });

  final int index;
  final String label;
  final String weekRange;
  final String focusTitle;
  final String focusBody;
  final String comfortNote;
  final List<PregnantSymptom> symptoms;
  final List<String> redFlags;

  static int trimesterIndexForWeek(int weeks) {
    if (weeks <= 13) return 0;
    if (weeks <= 27) return 1;
    return 2;
  }

  static List<PregnantTrimesterSymptoms> all() {
    return UserPreferences.instance.isDesi ? _desi() : _intl();
  }

  static PregnantTrimesterSymptoms forWeek(int weeks) {
    final plans = all();
    return plans[trimesterIndexForWeek(weeks).clamp(0, plans.length - 1)];
  }

  static List<PregnantTrimesterSymptoms> _desi() => const [
        PregnantTrimesterSymptoms(
          index: 0,
          label: '1st Trimester',
          weekRange: 'Weeks 1–13',
          focusTitle: 'Nausea, tiredness & early aches',
          focusBody:
              'Hormones rise quickly. Mild sickness and fatigue are common. Rest, small meals, and hydration help most women.',
          comfortNote:
              'Try lemon water, ginger tea, light khichdi, and short rests. Avoid empty stomach for long hours.',
          symptoms: [
            PregnantSymptom(
              title: 'Morning sickness / nausea',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Queasy stomach, food aversions, occasional vomiting — often worse in the morning or with smells.',
              whatHelps:
                  'Small frequent meals, rusks/toast, ginger tea, lemon scent, prenatal vitamins with food.',
              seekCareIf:
                  'Cannot keep fluids down, lose weight, feel dizzy or faint — ask about hyperemesis.',
            ),
            PregnantSymptom(
              title: 'Extreme fatigue',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Heavy tiredness even after light work; need for more naps.',
              whatHelps:
                  'Short daytime rests, iron-rich foods, early bedtime, ask doctor about hemoglobin.',
              seekCareIf:
                  'Sudden weakness with pale skin, breathlessness, or racing heartbeat.',
            ),
            PregnantSymptom(
              title: 'Breast tenderness',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Sore, fuller breasts; sensitive nipples.',
              whatHelps:
                  'Supportive cotton bra, soft clothing, warm compress if needed.',
              seekCareIf:
                  'Hard red hot area, fever, or unusual discharge — get checked.',
            ),
            PregnantSymptom(
              title: 'Mild cramping / pulling',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Light period-like twinges as uterus grows (ligament stretch).',
              whatHelps:
                  'Rest, hydration, gentle walking; avoid heavy lifting.',
              seekCareIf:
                  'Strong pain, bleeding, shoulder pain, or fainting — seek urgent care.',
            ),
            PregnantSymptom(
              title: 'Headache / dizziness',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Fairly common',
              whatItFeelsLike:
                  'Dull headache, light-headedness when standing quickly.',
              whatHelps:
                  'Water, snacks, rest in cool room; limit strong chai on empty stomach.',
              seekCareIf:
                  'Severe headache, vision changes, swelling of face/hands — call your doctor.',
            ),
            PregnantSymptom(
              title: 'Constipation / gas',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Bloating, hard stools, abdominal discomfort.',
              whatHelps:
                  'Water, fruit, sabzi, walking; ask before using laxatives.',
              seekCareIf:
                  'Severe pain, vomiting, or no stool/gas for days.',
            ),
          ],
          redFlags: [
            'Heavy bleeding or soaking pads',
            'Severe one-sided pain or fainting',
            'High fever with chills',
            'Persistent vomiting with no fluids for 24 hours',
            'Painful urination with fever',
          ],
        ),
        PregnantTrimesterSymptoms(
          index: 1,
          label: '2nd Trimester',
          weekRange: 'Weeks 14–27',
          focusTitle: 'Back pain, round ligament & energy shifts',
          focusBody:
              'Many women feel better as nausea eases. Growing belly can bring back, hip, and ligament pain.',
          comfortNote:
              'Supportive footwear, pregnancy pillow, light stretches, and warm (not hot) compresses often help.',
          symptoms: [
            PregnantSymptom(
              title: 'Round ligament pain',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Sharp pull in lower belly or groin when you stand, sneeze, or turn quickly.',
              whatHelps:
                  'Move slowly, support belly when coughing, rest on your side, gentle stretch.',
              seekCareIf:
                  'Pain that does not ease with rest, or comes with bleeding/fever.',
            ),
            PregnantSymptom(
              title: 'Lower back / hip ache',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Dull ache in lower back or hips after standing or sitting long.',
              whatHelps:
                  'Side sleeping with pillow between knees, short walks, good posture, maternity belt if advised.',
              seekCareIf:
                  'Sudden severe back pain with fever, or pain shooting with numbness in legs.',
            ),
            PregnantSymptom(
              title: 'Heartburn / acidity',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Burning in chest after meals; worse when lying down.',
              whatHelps:
                  'Smaller meals, sit upright after eating, avoid very spicy/oily late dinners; ask doctor for safe antacid.',
              seekCareIf:
                  'Chest pain with shortness of breath — treat as emergency until proven otherwise.',
            ),
            PregnantSymptom(
              title: 'Leg cramps at night',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Sudden calf squeeze, often at night.',
              whatHelps:
                  'Stretch before bed, hydrate, light evening walk; discuss calcium/magnesium with clinician.',
              seekCareIf:
                  'One leg swollen, red, warm, or painful — rule out clot.',
            ),
            PregnantSymptom(
              title: 'Urinary tract discomfort',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'More frequent in pregnancy',
              whatItFeelsLike:
                  'Burning while peeing, urgency, lower tummy ache.',
              whatHelps:
                  'Drink water, do not hold urine; see doctor promptly — UTIs need proper treatment.',
              seekCareIf:
                  'Fever, back pain, chills, or blood in urine — urgent care.',
            ),
            PregnantSymptom(
              title: 'Nasal congestion / mild colds',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mild,
              howCommon: 'Fairly common',
              whatItFeelsLike:
                  'Stuffy nose, mild sore throat without high fever.',
              whatHelps:
                  'Steam, saline drops, rest, warm fluids; ask before any medicine or kadha.',
              seekCareIf:
                  'High fever, trouble breathing, chest pain, or symptoms lasting over a week.',
            ),
          ],
          redFlags: [
            'Reduced baby movements (once you feel them regularly)',
            'Vaginal bleeding or fluid leak',
            'Severe headache, vision changes, or sudden swelling',
            'Painful calf with swelling/redness',
            'Fever above 38°C (100.4°F) with chills',
          ],
        ),
        PregnantTrimesterSymptoms(
          index: 2,
          label: '3rd Trimester',
          weekRange: 'Weeks 28–40',
          focusTitle: 'Pressure, Braxton Hicks & sleep strain',
          focusBody:
              'Baby is heavier — expect pelvic pressure, more heartburn, swelling, and practice contractions. Track pain patterns.',
          comfortNote:
              'Frequent rest, side sleeping, light snacks, and timing contractions helps you know normal vs labor.',
          symptoms: [
            PregnantSymptom(
              title: 'Braxton Hicks (practice) contractions',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Belly tightens for ~30–60 seconds then softens; irregular, often after activity or dehydration.',
              whatHelps:
                  'Rest, drink water, change position; note if they become regular.',
              seekCareIf:
                  'Regular, stronger, closer contractions before 37 weeks — call your hospital.',
            ),
            PregnantSymptom(
              title: 'Pelvic / pubic pressure',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Heavy, aching pressure low in pelvis; walking may feel wobbly.',
              whatHelps:
                  'Sit often, avoid straddling/wide steps, support belt if advised, sleep on side.',
              seekCareIf:
                  'Sudden inability to walk, or pain with bleeding/fever.',
            ),
            PregnantSymptom(
              title: 'Shortness of breath',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Getting winded climbing stairs; baby presses on lungs.',
              whatHelps:
                  'Sit upright, slow breathing, elevate head while resting.',
              seekCareIf:
                  'Sudden severe breathlessness, chest pain, or blue lips — emergency.',
            ),
            PregnantSymptom(
              title: 'Swelling (feet / ankles)',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike:
                  'Puffy feet by evening; rings may feel tight.',
              whatHelps:
                  'Elevate legs, reduce salt, drink water, comfortable shoes.',
              seekCareIf:
                  'Sudden face/hand swelling, severe headache, or vision changes.',
            ),
            PregnantSymptom(
              title: 'Stronger heartburn & sleep trouble',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.moderate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Burning chest at night; hard to find a comfortable position.',
              whatHelps:
                  'Early light dinner, extra pillows, left-side sleep; safe antacid if prescribed.',
              seekCareIf:
                  'Vomiting blood or chest pain with arm/jaw pain.',
            ),
            PregnantSymptom(
              title: 'Itching (skin / palms)',
              kind: SymptomKind.illness,
              painLevel: PainLevel.variable,
              howCommon: 'Sometimes',
              whatItFeelsLike:
                  'Itchy belly stretch; or intense itch on palms/soles especially at night.',
              whatHelps:
                  'Moisturizer for stretch itch; report palm/sole itch to doctor (cholestasis check).',
              seekCareIf:
                  'Severe palm/sole itch with dark urine or pale stools — same-day medical advice.',
            ),
          ],
          redFlags: [
            'Regular painful contractions before 37 weeks',
            'Water breaking or constant fluid leak',
            'Baby movements much less than usual',
            'Heavy bleeding',
            'Severe headache, vision change, or sudden swelling',
            'Fever, or pain when peeing with back pain',
          ],
        ),
      ];

  static List<PregnantTrimesterSymptoms> _intl() => const [
        PregnantTrimesterSymptoms(
          index: 0,
          label: '1st Trimester',
          weekRange: 'Weeks 1–13',
          focusTitle: 'Nausea, fatigue & early aches',
          focusBody:
              'Rising hormones often cause morning sickness and tiredness. Mild discomfort is expected; severe symptoms need care.',
          comfortNote:
              'Keep crackers nearby, sip fluids, rest often, and take prenatals with a snack.',
          symptoms: [
            PregnantSymptom(
              title: 'Morning sickness / nausea',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Queasiness, food aversions, vomiting — often triggered by smells.',
              whatHelps:
                  'Small frequent meals, ginger tea, bland snacks, vitamin B6 only if doctor suggests.',
              seekCareIf:
                  'Cannot keep liquids down, signs of dehydration, or rapid weight loss.',
            ),
            PregnantSymptom(
              title: 'Fatigue',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Very common',
              whatItFeelsLike: 'Deep tiredness; need for more sleep.',
              whatHelps:
                  'Naps, iron-rich meals, earlier bedtime; check hemoglobin if advised.',
              seekCareIf:
                  'Fainting, extreme weakness, or breathlessness at rest.',
            ),
            PregnantSymptom(
              title: 'Breast tenderness',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Common',
              whatItFeelsLike: 'Sore, swollen breasts and sensitive nipples.',
              whatHelps: 'Supportive bra, soft fabrics, avoid underwire pressure.',
              seekCareIf: 'Red hot painful area with fever.',
            ),
            PregnantSymptom(
              title: 'Mild cramping',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike: 'Light pulling or period-like twinges.',
              whatHelps: 'Rest, hydrate, avoid heavy lifting.',
              seekCareIf:
                  'Severe pain, bleeding, shoulder-tip pain, or fainting.',
            ),
            PregnantSymptom(
              title: 'Headache / lightheadedness',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Fairly common',
              whatItFeelsLike: 'Dull headache; dizzy on standing.',
              whatHelps: 'Hydration, snacks, rest; limit caffeine.',
              seekCareIf:
                  'Worst headache of your life, vision changes, or facial swelling.',
            ),
            PregnantSymptom(
              title: 'Constipation / bloating',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike: 'Gas, hard stools, abdominal discomfort.',
              whatHelps: 'Fiber, water, walking; ask before laxatives.',
              seekCareIf: 'Severe pain, vomiting, or no bowel movement for days.',
            ),
          ],
          redFlags: [
            'Heavy bleeding',
            'Severe abdominal pain or fainting',
            'High fever',
            'Persistent vomiting with no fluids',
            'Painful urination with fever',
          ],
        ),
        PregnantTrimesterSymptoms(
          index: 1,
          label: '2nd Trimester',
          weekRange: 'Weeks 14–27',
          focusTitle: 'Back pain, ligaments & steadier energy',
          focusBody:
              'Nausea often eases. Growing uterus can cause round-ligament pain, backaches, and heartburn.',
          comfortNote:
              'Good posture, pregnancy pillow, gentle stretching, and supportive shoes help daily comfort.',
          symptoms: [
            PregnantSymptom(
              title: 'Round ligament pain',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Sharp pull in lower abdomen/groin with sudden movement.',
              whatHelps: 'Change positions slowly; brace belly when sneezing.',
              seekCareIf: 'Constant pain with bleeding or fever.',
            ),
            PregnantSymptom(
              title: 'Lower back / hip pain',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike: 'Aching after long standing or sitting.',
              whatHelps:
                  'Side sleep with pillow support, short walks, maternity support if advised.',
              seekCareIf: 'Severe pain with fever or leg numbness/weakness.',
            ),
            PregnantSymptom(
              title: 'Heartburn',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Common',
              whatItFeelsLike: 'Burning chest after meals or at night.',
              whatHelps:
                  'Smaller meals, upright after eating; pregnancy-safe antacid if approved.',
              seekCareIf: 'Chest pain with shortness of breath.',
            ),
            PregnantSymptom(
              title: 'Night leg cramps',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike: 'Sudden calf spasm at night.',
              whatHelps: 'Calf stretches, hydration, evening walk.',
              seekCareIf: 'One-sided swelling, redness, or warmth in the leg.',
            ),
            PregnantSymptom(
              title: 'UTI symptoms',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mildModerate,
              howCommon: 'More common in pregnancy',
              whatItFeelsLike: 'Burning urine, urgency, lower abdominal ache.',
              whatHelps: 'See a clinician promptly; finish prescribed antibiotics.',
              seekCareIf: 'Fever, flank pain, or chills.',
            ),
            PregnantSymptom(
              title: 'Mild colds / congestion',
              kind: SymptomKind.illness,
              painLevel: PainLevel.mild,
              howCommon: 'Fairly common',
              whatItFeelsLike: 'Stuffy nose or mild sore throat.',
              whatHelps: 'Rest, fluids, saline rinse; confirm medicines with your doctor.',
              seekCareIf: 'High fever or breathing difficulty.',
            ),
          ],
          redFlags: [
            'Reduced fetal movement once regular',
            'Bleeding or fluid leaking',
            'Severe headache, vision changes, sudden swelling',
            'Painful swollen calf',
            'Fever with chills',
          ],
        ),
        PregnantTrimesterSymptoms(
          index: 2,
          label: '3rd Trimester',
          weekRange: 'Weeks 28–40',
          focusTitle: 'Pressure, practice contractions & swelling',
          focusBody:
              'Expect pelvic pressure, Braxton Hicks, more heartburn, and ankle swelling. Learn your usual pattern vs labor.',
          comfortNote:
              'Rest often, sleep on your side, hydrate, and time contractions if they become regular.',
          symptoms: [
            PregnantSymptom(
              title: 'Braxton Hicks contractions',
              kind: SymptomKind.pain,
              painLevel: PainLevel.mildModerate,
              howCommon: 'Very common',
              whatItFeelsLike:
                  'Belly tightens briefly then relaxes; irregular timing.',
              whatHelps: 'Rest, water, change activity.',
              seekCareIf:
                  'Regular strengthening contractions before 37 weeks.',
            ),
            PregnantSymptom(
              title: 'Pelvic pressure',
              kind: SymptomKind.pain,
              painLevel: PainLevel.moderate,
              howCommon: 'Common',
              whatItFeelsLike: 'Heavy low pressure; wobbly walk.',
              whatHelps: 'Frequent sitting, support belt if recommended.',
              seekCareIf: 'Sudden inability to walk or bleeding with pain.',
            ),
            PregnantSymptom(
              title: 'Shortness of breath',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike: 'Easily winded with stairs or talking while walking.',
              whatHelps: 'Upright posture, paced breathing.',
              seekCareIf: 'Sudden severe breathlessness or chest pain.',
            ),
            PregnantSymptom(
              title: 'Ankle / foot swelling',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.mild,
              howCommon: 'Common',
              whatItFeelsLike: 'Evening puffiness in feet.',
              whatHelps: 'Elevate legs, reduce salty snacks, stay hydrated.',
              seekCareIf: 'Sudden face/hand swelling with headache.',
            ),
            PregnantSymptom(
              title: 'Heartburn & insomnia',
              kind: SymptomKind.sickness,
              painLevel: PainLevel.moderate,
              howCommon: 'Very common',
              whatItFeelsLike: 'Night burning and restless sleep.',
              whatHelps: 'Earlier dinner, extra pillows, left-side sleep.',
              seekCareIf: 'Chest pain radiating to arm/jaw.',
            ),
            PregnantSymptom(
              title: 'Itching (especially palms/soles)',
              kind: SymptomKind.illness,
              painLevel: PainLevel.variable,
              howCommon: 'Sometimes',
              whatItFeelsLike: 'Stretch-mark itch or intense palm/sole itch at night.',
              whatHelps: 'Moisturizer for stretch itch; report palm/sole itch promptly.',
              seekCareIf: 'Severe itch with dark urine — same-day clinical advice.',
            ),
          ],
          redFlags: [
            'Regular painful contractions before 37 weeks',
            'Water breaking',
            'Noticeably fewer baby movements',
            'Heavy bleeding',
            'Severe headache, vision change, sudden swelling',
            'Fever or UTI with back pain',
          ],
        ),
      ];
}
