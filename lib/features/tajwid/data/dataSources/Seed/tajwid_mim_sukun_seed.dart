import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';
import 'package:uuid/uuid.dart';

final _uuid = const Uuid();
final tajwidMimSukunSeed = [
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c2',
    title: 'Idzhar Syafawi',
    explanation:
        '**Idzhar Syafawi** artinya *menjelaskan dengan bibir*.\n\n'
        '- Terjadi ketika **mim sukun (مْ)** bertemu dengan **huruf selain ب dan م**.\n'
        '- Cara baca: mim dibaca **jelas** tanpa dengung.\n'
        '- Contoh: مِنهُم، أَنعَمتَ.\n',
    letters: 'Selain ب dan م',
    examples: {
      'مِنْهُمْ': 'minhum',
      'تَعْلَمْنَا': 'taʿlamnā',
      'عَلَيْهِمْ': 'ʿalayhim',
      'أَنْعَمْتَ': 'anʿamta',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c2',
    title: 'Ikhfa Syafawi',
    explanation:
        '**Ikhfa Syafawi** artinya *menyembunyikan dengan bibir*.\n\n'
        '- Terjadi ketika **mim sukun (مْ)** bertemu dengan **huruf ب**.\n'
        '- Cara baca: mim diucapkan **dengung samar**, bibir tetap tertutup.\n'
        '- Contoh: تَرْمِيهِمْ بِحِجَارَةٍ.\n',
    letters: 'ب',
    examples: {
      'تَرْمِيهِمْ بِحِجَارَةٍ': 'tarmīhim biḥijārah',
      'كُم بِآيَاتٍ': 'kum biāyātin',
      'لَهُمْ بِهِ': 'lahum bihi',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c2',
    title: 'Idgham Mimi',
    explanation:
        '**Idgham Mimi** (atau *Idgham Mitslain Shaghir*) berarti *meleburkan dua mim*.\n\n'
        '- Terjadi ketika **mim sukun (مْ)** bertemu dengan **mim (م)** lagi.\n'
        '- Cara baca: dilebur menjadi satu mim dengan **dengung**.\n'
        '- Contoh: لَهُمْ مَغْفِرَةٌ.\n',
    letters: 'م',
    examples: {
      'لَهُمْ مَغْفِرَةٌ': 'lahum maghfirah',
      'كَمْ مِّنْ فِئَةٍ': 'kam min fiʾah',
      'عَلَيْهِمْ مَّا': 'ʿalayhim mā',
    },
  ),
];
