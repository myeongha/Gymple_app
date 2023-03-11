import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_gym/gymScreen/src/myScrollBehavior.dart';
import 'package:realtime_gym/gymScreen/src/mySnackBar.dart';
import 'dart:async';
import 'package:realtime_gym/gymScreen/gymPageContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'localNotification.dart';
import 'model.dart';

class GymPage extends StatefulWidget {
  const GymPage({Key? key, required this.gym, required this.pref}) : super(key: key);

  final Gym gym;
  final SharedPreferences pref;
  static List<String> timeList = [
    "06:00 ~ 08:00", "08:00 ~ 10:00",
    "10:00 ~ 12:00", "12:00 ~ 14:00",
    "14:00 ~ 16:00", "16:00 ~ 18:00",
    "18:00 ~ 20:00", "20:00 ~ 22:00",
    "22:00 ~ 00:00"
  ];

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> with WidgetsBindingObserver {
  static int pastDay = 0;
  DateTime now = DateTime.now();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBookInfo(widget.gym.name, widget.pref),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Gymple',
                  style: GoogleFonts.permanentMarker(
                    textStyle: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w400,
                      fontSize: 28,),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Colors.black),
              ),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SizedBox(
                        height: 55,
                        child: Center(
                          child: Text("${widget.gym.name}"
                          ,style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.black
                            ),)
                        ),
                      ),
                    ),
                    Container(
                      height: 530,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: ScrollConfiguration(
                          behavior: MyScrollBehavior(),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              child: Wrap(
                                runSpacing: 5,
                                children: GymPage.timeList.map((time) {
                                  int index = GymPage.timeList.indexOf(time);
                                  return (pastDay != now.day) ? GymPageContainer(
                                    time: time,
                                    userCount: widget.gym.userCount[index],
                                    todayBooked: false,
                                    bookedTimeNum: -1,
                                  ) : GymPageContainer(
                                    time: time,
                                    userCount: widget.gym.userCount[index],
                                    todayBooked: snapshot.data![0],
                                    bookedTimeNum: snapshot.data![1],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            left: 0.0,
                            bottom: 0.0,
                            child: Divider(
                              color: Colors.white,
                              thickness: 5,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 250,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade100
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          if (GymPageContainer.clickedTimeNum >= 0 &&
                                              snapshot.data![0] == false) {
                                            getBooked(widget.gym, widget.pref);
                                            showPopup(context, "완료", widget.gym.name);
                                          } else if (snapshot.data![0] == true) {
                                            MySnackBar.showMySnackBar(
                                                context, "예약은 하루 한 번만 가능합니다."
                                                "\n기존 예약을 취소해주세요.");
                                          }
                                          else {
                                            MySnackBar.showMySnackBar(
                                                context, "먼저 시간대를 선택해주세요.");
                                          }
                                        },
                                        child: Text("  예약",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15
                                          ),),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white,
                                        thickness: 4,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (snapshot.data![0] == true
                                              && widget.gym.userCount[snapshot.data![1]] > 0) {
                                            widget.gym.userCount[snapshot.data![1]] -= 1;
                                            GymPageContainer.canceledTimeNum =
                                            snapshot.data![1];
                                            getUnBooked(widget.gym, widget.pref);
                                            showPopup(context, "취소", widget.gym.name);
                                          } else {
                                            MySnackBar.showMySnackBar(
                                                context, "취소할 예약이 없습니다.");
                                          }
                                        },
                                        child: Text(
                                          "예약취소",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return CupertinoActivityIndicator();
        });
  }



  @override
  @mustCallSuper
  @protected
  void dispose() {
    GymPageContainer.anotherClicked = false;
    GymPageContainer.isClicked = false;
    GymPageContainer.clickedTimeNum = -1;
    GymPageContainer.canceledTimeNum = -1;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> getBooked(Gym gym, SharedPreferences pref) async {
    int bookHour =
    int.parse(GymPage.timeList[GymPageContainer.clickedTimeNum].substring(0, 2));

    gym.userCount[GymPageContainer.clickedTimeNum] += 1;
    ref.child(gym.name).set(gym.userCount);
    pref.setBool(gym.name, true);
    pref.setInt("${gym.name}TimeNum", GymPageContainer.clickedTimeNum);
    LocalNotification.bookNotification(bookHour);
  }

  Future<void> getUnBooked(Gym gym, SharedPreferences pref) async {
    GymPageContainer.clickedTimeNum = -1;
    GymPageContainer.isClicked = false;
    GymPageContainer.anotherClicked = false;
    ref.child(gym.name).set(gym.userCount);
    pref.setBool(gym.name, false);
    pref.setInt("${gym.name}TimeNum", -1);
    LocalNotification.cancelNotification();
  }

  Future<List<dynamic>> getBookInfo(String gymName, SharedPreferences pref) async {
    await setDayChange();
    if (pref.getBool(gymName) == null) {
      return [false, -1];
    } else {
      return [pref.getBool(gymName), pref.getInt("${gymName}TimeNum")];
    }
  }

  void showPopup(context, String bookStatus, String gymName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green.shade100,
              actionsAlignment: MainAxisAlignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              titlePadding: EdgeInsets.only(top: 20),
              title: Text("$gymName\n예약이 $bookStatus되었습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2,
                    fixedSize: const Size(75, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
        });
  }

  Future<void> getDayInfo() async {
    pastDay = widget.pref.getInt("todayInfo") ?? 0;
  }

  Future<void> setDayChange() async {
    await getDayInfo();
    if (pastDay != now.day) {
      GymPageContainer.clickedTimeNum = -1;
      GymPageContainer.isClicked = false;
      GymPageContainer.anotherClicked = false;
      GymPageContainer.canceledTimeNum = -1;
      LocalNotification.cancelNotification();
      await resetBookInfo(widget.gym.name, widget.pref);
    }
  }

  Future<void> resetBookInfo(String gymName, SharedPreferences pref) async {
    pref.remove(gymName);
    pref.remove("${gymName}TimeNum");
    pref.setInt("todayInfo", now.day);
    pastDay = now.day;
  }
}
