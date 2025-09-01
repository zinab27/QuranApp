# 📖 QuranApp

A **Flutter application** to read and listen to the **Holy Quran** with a clean and responsive UI.  

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-success?style=for-the-badge)

---

## ✨ Features

- 📜 **Surah List:** Browse all Surahs with names, numbers & ayah counts.  
- 🕋 **Surah Details:** View full text of each Surah with Arabic ayah numbering.  
- 🕌 **Basmala Display:** Automatically shows Basmala (except Surah 1 & 9).  
- 🎧 **Audio Playback:** Stream recitations with **play, pause, rewind, fast-forward & volume controls**.  
- ⬆️ **Scroll to Top:** Quickly jump back to the top of the Surah list.  
- 📱 **Responsive UI:** Optimized for **mobile** and **desktop**.  

---

## 🚀 Getting Started

1. **Install Flutter:**  
   👉 [Flutter installation guide](https://docs.flutter.dev/get-started/install)

2. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/QuranApp.git
   cd QuranApp
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
lib/
│── main.dart                  # App entry point & theme
│
├── models/
│   ├── surah.dart             # Surah data model
│   └── ayah.dart              # Ayah data model
│
├── widgets/
│   ├── home_page.dart         # Surah list & navigation
│   └── surah_details_page.dart # Surah details & audio playback
│
assets/
└── json/quran.json            # Quran data file
```

---

## 📦 Dependencies

- [flutter](https://pub.dev/packages/flutter)  
- [audioplayers](https://pub.dev/packages/audioplayers)  
- [http](https://pub.dev/packages/http)  

---

## 🌐 Notes

- 🔊 Audio is streamed from [mp3quran.net](https://www.mp3quran.net/).  
- 📡 Requires a **stable internet connection** for audio playback.  
- 🐛 For bugs & feature requests, please open an **issue** on GitHub.  

---

## 🤲 Contributing

Contributions are welcome!  
If you'd like to improve **QuranApp**, feel free to fork this repo, make changes, and submit a **pull request**.  
