import 'package:flutter/material.dart';
import 'package:realtime_gym/gymScreen/src/boxDecoration.dart';
import 'package:realtime_gym/gymScreen/src/myContainer.dart';
import 'package:realtime_gym/gymScreen/src/mySnackBar.dart';
import 'package:realtime_gym/gymScreen/gymPage.dart';

class GymPageContainer extends StatefulWidget {
  final String time;
  final dynamic userCount;
  final List<String> timeList = GymPage.timeList;
  final bool todayBooked;
  final int bookedTimeNum;

  static bool isClicked = false;
  static bool anotherClicked = false;
  static int clickedTimeNum = -1;
  // 예약 취소 시, 활성화된 버튼을 해제할 때 사용. 예약 취소할 때와 처음 gymPage 들어올 때를 구분하기 위해 생성
  static int canceledTimeNum = -1;

  GymPageContainer({Key? key
    , required this.time
    , required this.userCount
    , required this.todayBooked
    , required this.bookedTimeNum
  }) : super(key: key);

  @override
  State<GymPageContainer> createState() => _GymPageContainerState();
}

class _GymPageContainerState extends State<GymPageContainer> {
  late Color countColor;
  late BoxDecoration foregroundDeco;

  @override
  void initState() {
    foregroundDeco = recoverForegroundBoxDeco();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.userCount < 5) {
      countColor = Colors.blue;
    } else if (widget.userCount < 10) {
      countColor = Colors.orange;
    } else {
      countColor = Colors.red;
    }
    if ((int.parse(widget.time.substring(0, 2))+1) < DateTime.now().hour) {   // 현재 시간 기준 이전 시간대 컨테이너 처리
      foregroundDeco = lockForegroundBoxDeco();
      if (widget.todayBooked == true && widget.time == widget.timeList[widget.bookedTimeNum]) {
        GymPageContainer.clickedTimeNum = widget.timeList.indexOf(widget.time);
        GymPageContainer.anotherClicked = true;
        GymPageContainer.isClicked = true;
      }
    } else {
      if (widget.todayBooked == true && widget.time == widget.timeList[widget.bookedTimeNum]) {
        foregroundDeco = changeForegroundBoxDeco();
        GymPageContainer.clickedTimeNum = widget.timeList.indexOf(widget.time);
        GymPageContainer.anotherClicked = true;
        GymPageContainer.isClicked = true;
      }
      if (GymPageContainer.canceledTimeNum >= 0 && widget.time == widget.timeList[GymPageContainer.canceledTimeNum]) {
        foregroundDeco = recoverForegroundBoxDeco();
        GymPageContainer.isClicked = false;
        GymPageContainer.anotherClicked = false;
        GymPageContainer.clickedTimeNum = -1;
        GymPageContainer.canceledTimeNum = -1;
      }
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if (foregroundDeco == lockForegroundBoxDeco()) {
            MySnackBar.showMySnackBar(context, "예약 가능한 시간대가 아닙니다.");
          } else {
            if (!GymPageContainer.isClicked && widget.todayBooked == false && GymPageContainer.anotherClicked == false) {
              GymPageContainer.clickedTimeNum = widget.timeList.indexOf(widget.time);
              foregroundDeco = changeForegroundBoxDeco();
              GymPageContainer.anotherClicked = true;
              GymPageContainer.isClicked = !GymPageContainer.isClicked;
            }
            else if (GymPageContainer.isClicked
                && widget.todayBooked == false
                && widget.time == widget.timeList[GymPageContainer.clickedTimeNum]
            ) {
              GymPageContainer.clickedTimeNum = -1;
              foregroundDeco = recoverForegroundBoxDeco();
              GymPageContainer.anotherClicked = false;
              GymPageContainer.isClicked = !GymPageContainer.isClicked;
            } else if (widget.todayBooked == true
                && widget.time == widget.timeList[GymPageContainer.clickedTimeNum]) {
              MySnackBar.showMySnackBar(
                  context, "예약은 하루 한 번만 가능합니다."
                  "\n기존 예약을 취소해주세요.");
            }
            else {
              MySnackBar.showMySnackBar(
                  context, "중복선택이 불가능합니다. "
                  "활성화된 버튼을\n해제하거나 기존 예약을 취소해주세요.");
            }
          }
        });
      },
      child: (foregroundDeco == lockForegroundBoxDeco())
          ? (widget.todayBooked && widget.time == widget.timeList[widget.bookedTimeNum])
            ? CheckedContainer(widget: widget, countColor: countColor, foregroundDeco: foregroundDeco)
            : LockedContainer(widget: widget, countColor: countColor, foregroundDeco: foregroundDeco)
          : (widget.todayBooked && widget.time == widget.timeList[widget.bookedTimeNum])
            ? CheckedContainer(widget: widget, countColor: countColor, foregroundDeco: foregroundDeco)
            : NormalContainer(widget: widget, countColor: countColor, foregroundDeco: foregroundDeco));
  }
}

