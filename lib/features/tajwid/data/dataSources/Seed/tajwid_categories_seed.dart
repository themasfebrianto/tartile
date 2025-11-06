import 'package:tartile/features/tajwid/data/models/tajwid_category.dart';

final tajwidCategoriesSeed = [
  TajwidCategoryModel(
    id: 'c1',
    title: 'Nun Sukun & Tanwin',
    ordering: 1,
    description:
        'Pelajari cara membaca nun mati (nun sukun) dan tanda tanwin dengan benar sesuai hukum tajwid, termasuk izhar, ikhfa, dan idgham.',
    icon: 'نْ ً ٍ ٌ', // nun sukun + tanwin
  ),
  TajwidCategoryModel(
    id: 'c2',
    title: 'Mim Sukun',
    ordering: 2,
    description:
        'Belajar membaca mim mati (mim sukun) dengan hukum ikhfa, idgham, atau izhar sesuai tajwid.',
    icon: 'مْ', // mim + sukun
  ),
  TajwidCategoryModel(
    id: 'c3',
    title: 'Mim & Nun Tasydid',
    ordering: 3,
    description:
        'Pelajari hukum madd dan tafkhim ketika mim atau nun bertasydid agar bacaan jelas dan tegas.',
    icon: 'مّ نّ',
  ),
  TajwidCategoryModel(
    id: 'c4',
    title: 'Macam-Macam Idghom',
    ordering: 4,
    description:
        'Belajar idgham bighunnah dan idgham bilaghunnah agar bacaan nun mati dan tanwin menyatu dengan huruf berikutnya.',
    icon: 'نْ',
  ),
  TajwidCategoryModel(
    id: 'c5',
    title: 'Lam Ta’rif',
    ordering: 5,
    description:
        'Pelajari hukum membaca lam pada al- (Lam Ta’rif) tipis atau tebal sesuai huruf setelahnya.',
    icon: 'ل',
  ),
  TajwidCategoryModel(
    id: 'c6',
    title: 'Huruf Tipis & Tebal',
    ordering: 6,
    description:
        'Pelajari cara membedakan huruf tipis (rafi’) dan tebal (mufakhkham) agar bacaan lebih natural.',
    icon: 'ص ض ط ق ظ',
  ),
  TajwidCategoryModel(
    id: 'c7',
    title: 'Lam Sukun',
    ordering: 7,
    description:
        'Pelajari hukum lam mati (lam sukun) tipis atau tebal saat dibaca dengan alif lam.',
    icon: 'لْ',
  ),
  TajwidCategoryModel(
    id: 'c8',
    title: 'Qolqolah',
    ordering: 8,
    description:
        'Belajar huruf qalqalah (قطب جَد) yang terdengar getaran saat mati untuk bacaan tegas.',
    icon: 'ق ط ب ج د',
  ),
  TajwidCategoryModel(
    id: 'c9',
    title: 'Ha’ & Dhomir',
    ordering: 9,
    description:
        'Pelajari hukum membaca huruf Ha’ dan dhamir (kata ganti) sesuai tempat keluarnya agar tajwid benar.',
    icon: 'ه أ و', // Ha’ + huruf contoh dhomir (alif, waw)
  ),
  TajwidCategoryModel(
    id: 'c10',
    title: 'Mad',
    ordering: 10,
    description:
        'Pelajari berbagai jenis mad (mad thabi’i, mad wajib muttasil, mad jaiz munfashil) agar bacaan panjang sesuai hukum tajwid.',
    icon: 'ا و ي', // alif, waw, ya
  ),
  TajwidCategoryModel(
    id: 'c11',
    title: 'Makharijul Huruf',
    ordering: 11,
    description:
        'Pelajari titik keluarnya huruf (makhraj) agar setiap huruf dibaca jelas dan tepat.',
    icon: 'ح خ ع غ',
  ),
];
