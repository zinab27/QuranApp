# QuranApp

A Flutter application to read and listen to the Quran.

## Features

- **Surah List:** Browse all Surahs with their names, numbers, and ayah counts.
- **Surah Details:** View full text of each Surah, with ayah numbers in Arabic.
- **Basmala Display:** Shows Basmala at the start of Surahs (except Surah 1 and 9).
- **Audio Playback:** Stream recitation for each Surah with play, pause, rewind, fast-forward, and volume controls.
- **Scroll to Top:** Quickly return to the top of the Surah list.
- **Responsive UI:** Designed for mobile and desktop platforms.

## Getting Started

1. **Install Flutter:**  
   [Flutter installation guide](https://docs.flutter.dev/get-started/install)

2. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/QuranApp.git
   cd QuranApp
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/main.dart` – App entry point and theme setup.
- `lib/widgets/home_page.dart` – Surah list and navigation.
- `lib/widgets/surah_details_page.dart` – Surah details and audio playback.
- `lib/models/surah.dart` – Surah data model.
- `lib/models/ayah.dart` – Ayah data model.
- `assets/json/quran.json` – Quran data (make sure this file exists).

## Dependencies

- [flutter](https://pub.dev/packages/flutter)
- [audioplayers](https://pub.dev/packages/audioplayers)
- [http](https://pub.dev/packages/http)

## Notes

- Audio is streamed from [mp3quran.net](https://www.mp3quran.net/).
- Make sure you have a stable internet connection for audio playback.
- For issues or feature requests, open an issue on GitHub.
