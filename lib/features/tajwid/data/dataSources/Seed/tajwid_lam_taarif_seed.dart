import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';
import 'package:uuid/uuid.dart';

final _uuid = const Uuid();

final tajwidLamTaarifSeed = [
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c5',
    title: 'Al-Qamariyyah (الْقَمَرِيَّة)',
    explanation:
        '**Al-Qamariyyah** artinya *huruf qamariyyah (huruf bulan)*.\n\n'
        '- Terjadi ketika **Lam Ta’rif (ال)** bertemu dengan salah satu huruf **qamariyyah**: '
        '**أ، ب، ج، ح، خ، ع، غ، ف، ق، ك، م، هـ، و، ي**.\n'
        '- Cara baca: **lam dibaca jelas (idhhar)** tanpa dilebur ke huruf setelahnya.\n'
        '- Huruf setelah “al” dibaca dengan **sukun**, seperti: *al-qamaru* (ٱلْقَمَرُ).\n'
        '- Contoh: الْقَمَرُ، الْكِتَابُ، الْمَلَكُ.\n',
    letters: 'أ، ب، ج، ح، خ، ع، غ، ف، ق، ك، م، هـ، و، ي',
    examples: {
      'الْقَمَرُ': 'al-qamaru',
      'الْكِتَابُ': 'al-kitābu',
      'الْمَلَكُ': 'al-malaku',
      'الْحَقُّ': 'al-ḥaqq',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c5',
    title: 'Al-Syamsiyyah (الشَّمْسِيَّة)',
    explanation:
        '**Al-Syamsiyyah** artinya *huruf syamsiyyah (huruf matahari)*.\n\n'
        '- Terjadi ketika **Lam Ta’rif (ال)** bertemu dengan salah satu huruf **syamsiyyah**: '
        '**ت، ث، د، ذ، ر، ز، س، ش، ص، ض، ط، ظ، ل، ن**.\n'
        '- Cara baca: **lam tidak dibaca**, huruf setelahnya **ditasydid dan diidghamkan** (dilebur).\n'
        '- Contoh: الشَّمْسُ → *asy-syamsu*, النَّاسُ → *an-nāsu*.\n',
    letters: 'ت، ث، د، ذ، ر، ز، س، ش، ص، ض، ط، ظ، ل، ن',
    examples: {
      'الشَّمْسُ': 'asy-syamsu',
      'النَّاسُ': 'an-nāsu',
      'الرَّحْمٰنُ': 'ar-raḥmān',
      'السَّمَاءُ': 'as-samāʾ',
    },
  ),
];
