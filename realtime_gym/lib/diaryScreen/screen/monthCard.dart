import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Month.dart';
import 'stampScreen.dart';

class MonthCard extends StatefulWidget {
  const MonthCard({super.key, required this.month, required this.tileCount, required this.notifyParent});
  final Function() notifyParent;
  final Month month;
  final tileCount;
  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  late final Month month = widget.month; //monthScreen에서 받아오는 값
  var tileColors = List.filled(5, Colors.white);
  int count = 0; // tile count

  _tileColorCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      count = (prefs.getStringList(month.name) ?? List.filled(31, 'false'))
          .toList()
          .where((element) => element == 'true')
          .length; // list에 true 값이 몇개 있는지 세는 코드
    });

  }

  _tileColorSet() {
    tileColors = List.filled(5, Colors.white);
    setState(() {
      if (count < 7) {
        tileColors[0] = Colors.green.shade100;
      } else if (count < 13) {
        tileColors[0] = Colors.green.shade100;
        tileColors[1] = Colors.green.shade200;
      } else if (count < 19) {
        tileColors[0] = Colors.green.shade100;
        tileColors[1] = Colors.green.shade200;
        tileColors[2] = Colors.green.shade300;
      } else if (count < 25) {
        tileColors[0] = Colors.green.shade100;
        tileColors[1] = Colors.green.shade200;
        tileColors[2] = Colors.green.shade300;
        tileColors[3] = Colors.green.shade400;
      } else {
        tileColors[0] = Colors.green.shade100;
        tileColors[1] = Colors.green.shade200;
        tileColors[2] = Colors.green.shade300;
        tileColors[3] = Colors.green.shade400;
        tileColors[4] = Colors.green.shade500;
      }
    });
  }

  _initTileColorCount() {
    count = widget.tileCount;
  }

  @override
  void initState() {
    // TODO: implement initState
    count = widget.tileCount; // 맨 처음에 불러온 카운터 데이터 (한번만 실행됨)

    super.initState();
  }

  // 여기 잘 봐야함

  @override
  Widget build(BuildContext context) {
    _tileColorSet();

    return Card(
      shadowColor: Colors.lightGreen.shade600,
      margin: const EdgeInsets.all(5),
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StampScreen(
                month: month,
                notifyParent: widget.notifyParent,
              ),
            ),
          ).then(
            (value) {
              setState(() {
                _tileColorCount(); // stampScreen에서 다시 돌아올 때 tileColorCount 다시세기

                //_tileColorSet();
              });// loadingPage로 감
            },
          );
        },
        title: Row(
          children: [
            Text(
              month.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: tileColors[0],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: tileColors[1],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: tileColors[2],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: tileColors[3],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: tileColors[4],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
