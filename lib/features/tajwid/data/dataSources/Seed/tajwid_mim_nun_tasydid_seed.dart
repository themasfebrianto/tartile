import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';
import 'package:uuid/uuid.dart';

final _uuid = const Uuid();
final tajwidMimNunTasydidSeed = [
  TajwidRuleDto(
    id: _uuid.v4(),
    categoryId: 'c3',
    title: 'Ghunnah pada Mim & Nun Tasydid',
    explanation:
        '**Ghunnah** artinya *dengung*.\n\n'
        '- Terjadi ketika ada **mim (م)** atau **nun (ن)** yang bertanda **tasydid (ّ)**.\n'
        '- Cara baca: huruf tersebut dibaca **dengung** selama dua harakat (sekitar dua ketukan).\n'
        '- Dengung keluar dari rongga hidung, bukan dari mulut.\n'
        '- Contoh: إِنَّ، ثُمَّ، عَمَّ، مَنَّا.\n',
    letters: 'مّ , نّ',
    examples: {
      'إِنَّ اللّٰهَ': 'inna Allāh',
      'ثُمَّ أَمَاتَهُ': 'thumma amātahu',
      'عَمَّ يَتَسَاءَلُونَ': 'ʿamma yatasaʾalūn',
      'مَنَّ اللّٰهُ': 'manna Allāh',
    },
  ),
];
