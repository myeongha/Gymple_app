import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'navigationPage.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static int totalHealthCount = 0;
  static List<String> months = [
    '1월',
    '2월',
    '3월',
    '4월',
    '5월',
    '6월',
    '7월',
    '8월',
    '9월',
    '10월',
    '11월',
    '12월',
  ];
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static List<String> gymName = [
    "아주대학교 체육관(2층)",
    "M짐(24H)",
    "나이스짐(24H)",
    "마이짐",
    "마이짐 2호점",
    "몸빼짐",
    "사운드짐",
    "석세스짐",
    "휘트니스S"
  ];
  static List<List<dynamic>> gymUserCount = [];
  late List<Gym> gymData;
  var tileCounts = List.filled(12, 0);
  DateTime now = DateTime.now();
  int checkYear = 0; // 연도 바뀌는거 체크변수
  int currentYear = 0;


  @override
  void initState() {
    currentYear = now.year;
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: deviceWidth - 400,
            bottom: deviceHeight - 1205,
            child: Container(
              height: 1100,
              width: 1100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
            ),
          ),
          Positioned(
            left: deviceWidth - 400,
            bottom: deviceHeight - 1205,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: deviceWidth - 400,
            bottom: deviceHeight - 1205,
            child: Container(
              height: 900,
              width: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade100,
              ),
            ),
          ),
          Positioned(
            left: deviceWidth - 255,
            bottom: deviceHeight - 665,
            child: Text(
              'Gym',
              style: GoogleFonts.permanentMarker(
                textStyle: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
            ),
          ),
          Positioned(
            left: deviceWidth - 205, //190
            bottom: deviceHeight - 735,
            child: RichText(
              text: TextSpan(
                  text: 'Sim',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'ple',
                      style: GoogleFonts.permanentMarker(
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            left: deviceWidth - 220,
            bottom: deviceHeight - 625,
            child: Image.asset(
              'image/barbell.png',
              width: 270,
              height: 270,
            ),
          ),
          Positioned(
            left: deviceWidth - 230,
            bottom: deviceHeight - 380,
            child: Text("Loading...",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade400,
    );
  }

  _getTileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoadingPage.totalHealthCount = 0;
    checkYear = (prefs.getInt('checkYear') ??
        currentYear); // 기기에 저장된 check변수 불러옴, 아무 값 없으면 현재 연도 대입
    if (currentYear != checkYear) {
      // 1월 1일 되면 데이터 초기화
      prefs.clear();
    } else {
      for (int index = 0; index < 12; index++) {
        // 각 월에 해당하는 타일 카운트
        tileCounts[index] = (prefs.getStringList(LoadingPage.months[index]) ??
            List.filled(31, 'false'))
            .toList()
            .where((element) => element == 'true')
            .length;

        LoadingPage.totalHealthCount += tileCounts[index]; //년도 총 운동 회수
      }
    }
    checkYear = currentYear;
    prefs.setInt('checkYear', checkYear);
  }

  void loading() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final now = DateTime.now();

    for (int i = 0; i < 9; i++) {                             // 헬스장 데이터 매핑
      final snapshot = await ref.child(gymName[i]).get();
        gymUserCount.add(snapshot.value as List<dynamic>);
    }
    gymData = List.generate(gymName.length, (index) =>
        Gym(gymName[index], gymUserCount[index]));
    if (pref.getInt("today") == null) {
      pref.setInt("today", now.day);
    }
    pref.setInt("today", now.day);
    await _getTileData();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NavigationPage(
          gymData: gymData,
          pref: pref,
          tileCounts: tileCounts,
        )));
  }
}
