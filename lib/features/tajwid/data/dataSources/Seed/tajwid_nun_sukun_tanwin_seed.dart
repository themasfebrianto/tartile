import 'package:tartile/features/tajwid/data/models/tajiwd_rule_dto.dart';

final tajwidNunSukunTanwinSeed = [
  TajwidRuleDto(
    id: 'r1',
    categoryId: 'c1',
    title: 'Idhar Halqi',
    explanation:
        '**Idhar Halqi** – artinya *menjelaskan*.\n\n'
        '- Terjadi ketika nun sukun atau tanwin bertemu huruf halqi: **ء, ه, ع, ح, خ, غ**.\n'
        '- Cara baca: suara nun/tanwin terdengar jelas tanpa dengungan.\n',
    letters: 'ء, ه, ع, ح, خ, غ',
    examples: {
      'مِنْ كِتَابٍ': 'min kitāb',
      'مِنْ سَبِيلٍ': 'min sabīl',
      'مِنْ عِلْمٍ': 'min ilm',
      'مِنْ هُدًى': 'min hudā',
    },
  ),
  TajwidRuleDto(
    id: 'r2',
    categoryId: 'c1',
    title: 'Idghom Bighunnah',
    explanation:
        '**Idghom Bighunnah** – artinya *memasukkan dengan dengung*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf: **ي, ن, م, و**.\n'
        '- Cara baca: nun/tanwin dihubungkan ke huruf berikutnya dengan dengungan ringan.\n',
    letters: 'ي, ن, م, و',
    examples: {
      'مِنْ يَدٍ': 'miy yad',
      'مِنْ نَفْسٍ': 'min nafs',
      'مِنْ مَكَانٍ': 'mim makān',
      'مِنْ وَرَقٍ': 'muw waraq',
    },
  ),
  TajwidRuleDto(
    id: 'r3',
    categoryId: 'c1',
    title: 'Idghom Bila Ghunnah',
    explanation:
        '**Idghom Bila Ghunnah** – artinya *memasukkan tanpa dengung*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf: **ل, ر**.\n'
        '- Cara baca: suara nun/tanwin langsung menyatu ke huruf berikutnya tanpa dengungan.\n',
    letters: 'ل, ر',
    examples: {
      'مِنْ لَدُنْ': 'mil ladun',
      'مِنْ لَيْلٍ': 'mil laylin',
      'مِنْ رَبٍّ': 'mir rabb',
      'مِنْ رَجُلٍ': 'mir rajul',
    },
  ),
  TajwidRuleDto(
    id: 'r4',
    categoryId: 'c1',
    title: 'Iqlab',
    explanation:
        '**Iqlab** – artinya *menukar*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf **ب**.\n'
        '- Cara baca: nun/tanwin berubah menjadi mim dengan merapatkan bibir disertai dengungan.\n',
    letters: 'ب',
    examples: {
      'أَنْبِئْ': 'ambī',
      'أَنْبَتْ': 'ambat',
      'أَنْبَهْ': 'ambah',
      'أَنْبَرْ': 'ambar',
    },
  ),
  TajwidRuleDto(
    id: 'r5',
    categoryId: 'c1',
    title: 'Ikhfa',
    explanation:
        '**Ikhfa** – artinya *menyamar*.\n\n'
        '- Terjadi ketika nun sukun atau tanwin bertemu huruf selain halqi, idghom bighunnah, idghom bila ghunnah, atau iqlab.\n'
        '- Huruf: **ت, ث, ج, د, ذ, ز, س, ش, ص, ض, ط, ظ, ف, ق, ك**.\n'
        '- Cara baca: suara nun/tanwin samar, terdengar seperti *NG* atau *NY* tergantung huruf.\n',
    letters: 'ت, ث, ج, د, ذ, ز, س, ش, ص, ض, ط, ظ, ف, ق, ك',
    examples: {
      'مِنْ شَرٍّ': 'ming sharr',
      'مِنْ تَمْرٍ': 'ming tamr',
      'مِنْ ثَمَرٍ': 'ming thamar',
      'مِنْ جَمَلٍ': 'ming jamal',
    },
  ),
];
