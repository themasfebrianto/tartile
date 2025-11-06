import 'package:tartile/features/tajwid/data/models/tajwid_rule.dart';

final tajwidNunSukunTanwinSeed = [
  TajwidRuleModel(
    id: 'r1',
    categoryId: 'c1',
    title: 'Idhar Halqi',
    explanation:
        '**Idhar Halqi** – artinya *menjelaskan*.\n\n'
        '- Terjadi ketika nun sukun atau tanwin bertemu huruf halqi: **ء, ه, ع, ح, خ, غ**.\n'
        '- Cara baca: suara nun/tanwin terdengar jelas tanpa dengungan.\n',
    letters: 'ء, ه, ع, ح, خ, غ',
    examples:
        '- أَنْهَ\n'
        '- أَنْهَا\n'
        '- أَنْهُم\n'
        '- أَنْتَ\n'
        '- أَنْتِ',
  ),
  TajwidRuleModel(
    id: 'r2',
    categoryId: 'c1',
    title: 'Idghom Bighunnah',
    explanation:
        '**Idghom Bighunnah** – artinya *memasukkan dengan dengung*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf: **ي, ن, م, و**.\n'
        '- Cara baca: nun/tanwin dihubungkan ke huruf berikutnya dengan dengungan ringan.\n',
    letters: 'ي, ن, م, و',
    examples:
        '- مِنْ وَجْهِ\n'
        '- مِنْ نَفْسٍ\n'
        '- مِنْ مَكَانٍ\n'
        '- مِنْ وَرَقٍ\n'
        '- مِنْ يَدٍ',
  ),
  TajwidRuleModel(
    id: 'r3',
    categoryId: 'c1',
    title: 'Idghom Bila Ghunnah',
    explanation:
        '**Idghom Bila Ghunnah** – artinya *memasukkan tanpa dengung*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf: **ل, ر**.\n'
        '- Cara baca: suara nun/tanwin langsung menyatu ke huruf berikutnya tanpa dengungan.\n',
    letters: 'ل, ر',
    examples:
        '- مِنْ لَدُنْ\n'
        '- مِنْ لَيْلٍ\n'
        '- مِنْ رَبٍّ\n'
        '- مِنْ رَجُلٍ\n'
        '- مِنْ رَسُولٍ',
  ),
  TajwidRuleModel(
    id: 'r4',
    categoryId: 'c1',
    title: 'Iqlab',
    explanation:
        '**Iqlab** – artinya *menukar*.\n\n'
        '- Terjadi saat nun sukun atau tanwin bertemu huruf **ب**.\n'
        '- Cara baca: nun/tanwin berubah menjadi mim dengan merapatkan bibir disertai dengungan.\n',
    letters: 'ب',
    examples:
        '- أَنْبِئْ\n'
        '- أَنْبَتْ\n'
        '- أَنْبَهْ\n'
        '- أَنْبَرْ\n'
        '- أَنْبَغْ',
  ),
  TajwidRuleModel(
    id: 'r5',
    categoryId: 'c1',
    title: 'Ikhfa',
    explanation:
        '**Ikhfa** – artinya *menyamar*.\n\n'
        '- Terjadi ketika nun sukun atau tanwin bertemu huruf selain halqi, idghom bighunnah, idghom bila ghunnah, atau iqlab.\n'
        '- Huruf: **ت, ث, ج, د, ذ, ز, س, ش, ص, ض, ط, ظ, ف, ق, ك**.\n'
        '- Cara baca: suara nun/tanwin samar, terdengar seperti *NG* atau *NY* tergantung huruf.\n',
    letters: 'ت, ث, ج, د, ذ, ز, س, ش, ص, ض, ط, ظ, ف, ق, ك',
    examples:
        '- مِنْ شَرٍّ\n'
        '- مِنْ تَمْرٍ\n'
        '- مِنْ ثَمَرٍ\n'
        '- مِنْ جَمَلٍ\n'
        '- مِنْ دَارٍ',
  ),
];
