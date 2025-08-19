class Ayah {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;
  Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> ayahJson) {
    return Ayah(
      number: ayahJson['number'],
      text: ayahJson['text'],
      numberInSurah: ayahJson['numberInSurah'],
      juz: ayahJson['juz'],
      page: ayahJson['page'],
      ruku: ayahJson['ruku'],
      hizbQuarter: ayahJson['hizbQuarter'],
      sajda: ayahJson['sajda'] == true,
    );
  }
}
