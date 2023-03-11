import 'dart:io';
import 'package:flutter/material.dart';
import 'package:realtime_gym/gymScreen/src/myScrollBehavior.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../gymScreen/loadingPage.dart';
import '../Month.dart';
import 'monthCard.dart';

class MonthScreen extends StatefulWidget {
  const MonthScreen({super.key, required this.tileCounts, required this.pref});
  final tileCounts;
  final SharedPreferences pref;

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  final colorsCount = List<int>.filled(12, 0);

  static final List<Month> monthData = List.generate(LoadingPage.months.length,
      (index) => Month(name: LoadingPage.months[index], monthInt: index + 1));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Gymple',
            style: GoogleFonts.permanentMarker(
              textStyle: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w400,
                fontSize: 28,),
            ),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 7, 8, 3),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${DateTime.now().year}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: ' 년',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${LoadingPage.totalHealthCount}",
                          style: GoogleFonts.permanentMarker(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 65,
                            )
                          ),
                          children: const [
                            TextSpan(
                              text: '  일째',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '오운완',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 7,
              thickness: 1.5,
              color: Colors.green.shade200,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 3, right: 3, left: 3, bottom: 7),
                child: ScrollConfiguration(
                  behavior: MyScrollBehavior(),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: monthData.length,
                    itemBuilder: (context, index) {
                      return MonthCard(
                        month: monthData[index],
                        tileCount: widget.tileCounts[index],
                        notifyParent: _monthScreenSetState,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _monthScreenSetState() {
    var tileCounts = List.filled(12, 0);
    LoadingPage.totalHealthCount = 0;
    setState(() {
      for (int index = 0; index < 12; index++) {
        // 각 월에 해당하는 타일 카운트
        tileCounts[index] =
            (widget.pref.getStringList(LoadingPage.months[index]) ??
                List.filled(31, 'false'))
                .toList()
                .where((element) => element == 'true')
                .length;

        LoadingPage.totalHealthCount += tileCounts[index]; //년도 총 운동 회수

      }
    });
  }
}
