import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';
import 'package:uuid/uuid.dart';

final _uuid = const Uuid();

final tajwidIdghamTypesSeed = [
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c4',
    title: 'Idgham Mutamatsilain',
    explanation:
        '**Idgham Mutamatsilain** artinya *meleburkan dua huruf yang sama makhraj dan sifatnya*.\n\n'
        '- Terjadi ketika huruf pertama **sukun**, dan huruf kedua **hidup**, serta **keduanya huruf yang sama**.\n'
        '- Cara baca: huruf pertama dilebur ke huruf kedua sehingga terdengar satu huruf saja.\n'
        '- Contoh: قَدْ دَخَلُوا → قَدَّخَلُوا.\n',
    letters: 'Dua huruf yang sama (contoh: د + د, ب + ب, م + م)',
    examples: {
      'قَدْ دَخَلُوا': 'qad dakhalū',
      'إِذْ ذَهَبَ': 'idh dhahaba',
      'ارْكَبْ بِنَا': 'irkab binā',
      'لَهُمْ مَغْفِرَةٌ': 'lahum maghfirah',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c4',
    title: 'Idgham Mutajanisain',
    explanation:
        '**Idgham Mutajanisain** artinya *meleburkan dua huruf yang berdekatan makhrajnya dan mirip sifatnya*.\n\n'
        '- Terjadi antara huruf-huruf yang makhrajnya dekat, seperti:\n'
        '  - **ت dengan ط atau د**\n'
        '  - **ذ dengan ظ atau ث**\n'
        '  - **ب dengan م**\n'
        '- Cara baca: huruf pertama dilebur ke huruf kedua.\n'
        '- Contoh: إِذْ ظَلَمُوا → إِظَّلَمُوا.\n',
    letters: 'Huruf yang mirip makhraj dan sifat (contoh: ت-ط, ذ-ظ, ب-م)',
    examples: {
      'إِذْ ظَلَمُوا': 'idh zhalamū',
      'قَدْ تَّبَيَّنَ': 'qad tabayyana',
      'اذْ ذَهَبَ': 'idh dhahaba',
      'ارْكَبْ مَعَنَا': 'irkab maʿanā',
    },
  ),
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c4',
    title: 'Idgham Mutaqaribain',
    explanation:
        '**Idgham Mutaqaribain** artinya *meleburkan dua huruf yang berdekatan makhraj dan sifatnya hampir sama*.\n\n'
        '- Terjadi antara dua huruf yang **makhrajnya berdekatan**, seperti:\n'
        '  - **ق dengan ك**\n'
        '  - **ل dengan ر**\n'
        '- Cara baca: huruf pertama dilebur ke huruf kedua dengan halus.\n'
        '- Contoh: قَدْ قَدَرَ → قَقَدَرَ, قُلْ رَبِّ → قُرَّبِّ.\n',
    letters: 'Huruf yang berdekatan makhraj (contoh: ق-ك, ل-ر)',
    examples: {
      'قُلْ رَبِّ': 'qurrabbi',
      'قَدْ قَدَرَ': 'qaqadara',
      'يَقْلُبُ': 'yaqlubu',
      'قُلْ رِّزْقِي': 'qurrizqī',
    },
  ),
];
