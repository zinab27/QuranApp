import 'package:quran/models/ayah.dart';

class Surah {
  final String name;
  final int number;
  final String englishName;
  final String englishNameTranslation;
  final List<Ayah> ayahs;
  final String revelationType;

  Surah({
    required this.name,
    required this.number,
    required this.englishName,
    required this.englishNameTranslation,
    required this.ayahs,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> surahJson) {
    return (Surah(
      name: surahJson['name'],
      number: surahJson['number'],
      englishName: surahJson['englishName'],
      englishNameTranslation: surahJson['englishNameTranslation'],
      ayahs: (surahJson['ayahs'] as List<dynamic>)
          .map((ayah) => Ayah.fromJson(ayah as Map<String, dynamic>))
          .toList(),
      revelationType: surahJson['revelationType'],
    ));
  }
}
