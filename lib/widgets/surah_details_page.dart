import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran/models/surah.dart';
import 'package:http/http.dart' as http;

class SurahDetailsPage extends StatefulWidget {
  final Surah surahDetails;

  const SurahDetailsPage({super.key, required this.surahDetails});

  @override
  State<SurahDetailsPage> createState() => _SurahDetailsPageState();
}

class _SurahDetailsPageState extends State<SurahDetailsPage> {
  String fullsurah = '';
  String basmala = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _currentVolume = 0.5;
  bool isLoading = true;

  String _convertToArabicNumber(int number) {
    String englishNumber = number.toString();
    const englishToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return englishNumber
        .split('')
        .map((digit) => englishToArabicDigits[digit]!)
        .join();
  }

  _getfullsurah() {
    for (var i = 1; i <= widget.surahDetails.ayahs.length; i++) {
      fullsurah +=
          '${widget.surahDetails.ayahs[i - 1].text} \uFD3F${_convertToArabicNumber(i)}\uFD3E ';
    }
  }

  Future<void> _playAudio() async {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    int surahNumber = widget.surahDetails.number;
    String surahWithZero = surahNumber.toString();
    if (surahNumber < 10) {
      surahWithZero = '00$surahNumber';
    } else if (surahNumber < 100) {
      surahWithZero = '0$surahNumber';
    }

    // API endpoint
    final String apiUrl =
        "https://www.mp3quran.net/api/v3/reciters?language=ar&sura=$surahNumber";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['reciters'] != null && jsonData['reciters'].isNotEmpty) {
          final String serverUrl =
              jsonData['reciters'][0]['moshaf'][0]['server'];

          final String audioUrl = '$serverUrl$surahWithZero.mp3';
          await _audioPlayer.setSourceUrl(audioUrl);
          setState(() {
            isLoading = false;
          });
        } else {
          print("No audio available for this Surah.");
        }
      } else {
        print("Failed to load audio. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching audio: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getfullsurah();
    _playAudio();

    //play , pause , stop
    _audioPlayer.onPlayerStateChanged.listen((state) {
      //print("Player state changed: $state"); // Debug print
      setState(() {
        isPlaying = (state == PlayerState.playing);
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahDetails.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (widget.surahDetails.number != 9 &&
                    widget.surahDetails.number != 1)
                  Text(
                    basmala,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 23,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fullsurah,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 23),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: (val) {
                      _audioPlayer.seek(Duration(seconds: val.toInt()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_position.inHours}:${_position.inMinutes % 60}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                        Text(
                          "${_duration.inHours}:${_duration.inMinutes % 60}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Playback Controls
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.fast_rewind),
                            onPressed: () async {
                              _audioPlayer.seek(const Duration(seconds: 0));
                            },
                          ),
                          CircleAvatar(
                            radius: 24,
                            child: IconButton(
                              icon: isPlaying
                                  ? const Icon(Icons.pause)
                                  : const Icon(Icons.play_arrow),
                              onPressed: () async {
                                if (isPlaying) {
                                  await _audioPlayer.pause();
                                } else {
                                  await _audioPlayer.resume();
                                }
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.fast_forward),
                            onPressed: () async {
                              _audioPlayer.seek(_duration); // Skip to the end
                            },
                          ),
                        ],
                      ),
                      // Volume Controls
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.volume_up),
                            onPressed: () async {
                              if (_currentVolume < 1.0) {
                                setState(() {
                                  _currentVolume +=
                                      0.1; // Increase volume by 10%
                                });
                                await _audioPlayer.setVolume(_currentVolume);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.volume_down),
                            onPressed: () async {
                              if (_currentVolume > 0.0) {
                                setState(() {
                                  _currentVolume -=
                                      0.1; // Decrease volume by 10%
                                });
                                await _audioPlayer.setVolume(_currentVolume);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.volume_mute),
                            onPressed: () async {
                              setState(() {
                                _currentVolume = 0.0; // Mute volume
                              });
                              await _audioPlayer.setVolume(_currentVolume);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
