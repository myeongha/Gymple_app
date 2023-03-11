import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_gym/gymScreen/src/myScrollBehavior.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gymScreen/src/mySnackBar.dart';
import '../Month.dart';
import '../model/greenFitnessImage.dart';
import '../model/greyFitnessImage.dart';

class StampScreen extends StatefulWidget {
  final Month month;
  final Function() notifyParent;
  const StampScreen({super.key, required this.month, required this.notifyParent});

  @override
  State<StampScreen> createState() => _StampScreenState();
}

class _StampScreenState extends State<StampScreen> {
  late final Month month = widget.month;

  List<String> healthStringList = List.filled(31, 'false');
  List<bool> healthBoolList = List.filled(31, false);

  DateTime now = DateTime.now();
  int dayOfMonth = 0;

  @override
  void initState() {
    // TODO: implement initState
    _loadHealthData();
    dayOfMonth = now.day;
    super.initState();
  }

  // @override
  // void dispose() {
  //   MonthCard.streamController.add(true);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    int dayNum = 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            widget.notifyParent();
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  month.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                      _fitnessImage(healthBoolList[dayNum - 1], dayNum++),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                    ),
                    child: const Text(
                      '오운완',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.green.shade100,
                            actionsAlignment: MainAxisAlignment.end,
                            title: const Text(
                              '오늘 운동 완료 ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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
                                  if (now.month == month.monthInt) {
                                    _onDailyHealth();

                                    Navigator.pop(context);
                                  } else {
                                    MySnackBar2.showMySnackBar(
                                        context, "해당 월이 아닙니다.");
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  '오운완',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 2,
                                  fixedSize: const Size(75, 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  '아직..',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  if (now.month == month.monthInt) {
                                    _onDailyHealth2();

                                    Navigator.pop(context);
                                  } else {
                                    MySnackBar2.showMySnackBar(
                                        context, "해당 월이 아닙니다.");
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loadHealthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      healthStringList =
          (prefs.getStringList(month.name) ?? List.filled(31, 'false'));
      healthBoolList = healthStringList.map((str) => str == 'true').toList();
    });
  }

  _onDailyHealth() async {
    // 무조건 true로 변경
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      healthStringList =
          (prefs.getStringList(month.name) ?? List.filled(31, 'false'));
      healthBoolList = healthStringList
          .map((str) => str == 'true')
          .toList(); // 기기에 저장되어있는 StringList를 boollist로 변환
      healthBoolList[dayOfMonth - 1] = true; // 눌렀을때 반대 값으로 저장
      prefs.setStringList(
          month.name,
          healthBoolList
              .map((boolVal) => boolVal.toString())
              .toList()); // 다시 StringList로 변환후 데이터에 저장
    });
  }

  _onDailyHealth2() async {
    // 무조건 false로 변경
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      healthStringList =
          (prefs.getStringList(month.name) ?? List.filled(31, 'false'));
      healthBoolList = healthStringList
          .map((str) => str == 'true')
          .toList(); // 기기에 저장되어있는 StringList를 boollist로 변환
      healthBoolList[dayOfMonth - 1] = false; // 눌렀을때 반대 값으로 저장
      prefs.setStringList(
          month.name,
          healthBoolList
              .map((boolVal) => boolVal.toString())
              .toList()); // 다시 StringList로 변환후 데이터에 저장
    });
  }

  Widget _fitnessImage(bool healthBool, int dayNum) {
    // 버튼 색을 바꿔주는 함수
    if (healthBool == true) {
      return GreenFitnessImage(dayNum: dayNum);
    } else {
      return GreyFitnessImage(dayNum: dayNum);
    }
  }
}
