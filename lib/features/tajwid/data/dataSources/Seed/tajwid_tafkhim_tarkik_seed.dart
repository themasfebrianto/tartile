import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';
import 'package:uuid/uuid.dart';

final _uuid = const Uuid();
final tajwidTafkhimTarqiqSeed = [
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c6',
    title: 'Huruf Tafkhim (Tebal)',
    explanation:
        '**Tafkhim** artinya *menebalkan suara huruf*.\n\n'
        '- Huruf yang dibaca **tebal** adalah huruf-huruf isti‘lā: '
        '**خ، ص، ض، غ، ط، ق، ظ**.\n'
        '- Suara keluar dengan mengangkat pangkal lidah mendekati langit-langit.\n'
        '- Jika huruf ini berharakat fathah atau dhammah, tebalnya lebih kuat; jika kasrah, tebalnya berkurang.\n'
        '- Contoh: خَلَقَ، صَبْرٍ، طَيِّبٍ.\n',
    letters: 'خ، ص، ض، غ، ط، ق، ظ',
    examples: {
      'خَلَقَ': 'khalaqa',
      'صَبْرٍ': 'ṣabriŋ',
      'غَفُورٌ': 'ghafūrun',
      'طَيِّبٍ': 'ṭayyibin',
      'قَدَرَ': 'qadara',
      'ظَلَمُوا': 'ẓalamū',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c6',
    title: 'Huruf Tarqiq (Tipis)',
    explanation:
        '**Tarqiq** artinya *menipiskan suara huruf*.\n\n'
        '- Semua huruf selain huruf-huruf tafkhim dibaca **tipis**.\n'
        '- Suara keluar ringan dan datar tanpa mengangkat pangkal lidah.\n'
        '- Termasuk juga **ra (ر)** yang bisa tipis atau tebal tergantung posisi harakatnya.\n'
        '- Contoh: فِي، نِعْمَةٍ، رِزْقٍ.\n',
    letters: 'Selain خ، ص، ض، غ، ط، ق, ظ',
    examples: {
      'فِي': 'fī',
      'نِعْمَةٍ': 'niʿmah',
      'رِزْقٍ': 'rizqin',
      'سَبِيلٍ': 'sabīl',
      'بِسْمِ': 'bismi',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c6',
    title: 'Huruf Ra (ر) – Tipis & Tebal',
    explanation:
        '**Huruf Ra (ر)** bisa dibaca **tebal (tafkhim)** atau **tipis (tarqiq)** tergantung harakat dan posisi.\n\n'
        '- **Dibaca tebal (tafkhim):**\n'
        '  - Jika berharakat fathah (رَ) atau dhammah (رُ).\n'
        '  - Contoh: رَحْمَةٌ → *raḥmah*, رُسُلٌ → *rusulun*.\n\n'
        '- **Dibaca tipis (tarqiq):**\n'
        '  - Jika berharakat kasrah (رِ) atau setelah kasrah tanpa alif/fathah setelahnya.\n'
        '  - Contoh: فِرْعَوْنُ → *firʿawn*, مِرْيَةٍ → *miryah*.\n',
    letters: 'ر',
    examples: {
      'رَحْمَةٌ': 'raḥmah',
      'رُسُلٌ': 'rusulun',
      'فِرْعَوْنُ': 'firʿawn',
      'مِرْيَةٍ': 'miryah',
    },
  ),
];
