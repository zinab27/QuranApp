import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/widgets/surah_details_page.dart';
import 'package:quran/models/surah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Surah> _surahList = [];
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  bool isLoading = true;

  Future<void> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json/quran.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    _surahList = (jsonData['data']['surahs'] as List<dynamic>)
        .map((surahJson) => Surah.fromJson(surahJson as Map<String, dynamic>))
        .toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();

    _scrollController.addListener(() {
      //print(_scrollController.offset);
      if (_scrollController.offset >= 5.0) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran App'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('عدد السور : ${_surahList.length}'),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _surahList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: _surahList.isEmpty
                              ? const Icon(Icons.hourglass_empty)
                              : Card(
                                  child: ListTile(
                                    title: Text(
                                      _surahList[index].name,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing:
                                        Text('${_surahList[index].number}'),
                                    leading: Text(
                                        '${_surahList[index].ayahs.length} '),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SurahDetailsPage(
                                            surahDetails: _surahList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: _showScrollToTopButton
          ? Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_circle_up_sharp),
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInCirc,
                      );
                    },
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
