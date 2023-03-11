import 'package:flutter/material.dart';
import 'package:realtime_gym/gymScreen/gymPageContainer.dart';

class NormalContainer extends StatelessWidget {
  const NormalContainer({
    Key? key,
    required this.widget,
    required this.countColor,
    required this.foregroundDeco,
  }) : super(key: key);

  final GymPageContainer widget;
  final Color countColor;
  final BoxDecoration foregroundDeco;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [widget.userCount * 0.05, 0],   // 인원 수
            colors: [
              countColor.withOpacity(0.4),   // 인원 색
              Colors.white
            ],
          )
      ),
      foregroundDecoration: foregroundDeco,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.time,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15
              ),),
            Row(
              children: [
                Icon(Icons.person),
                Text(" :"),
                Container(
                  width: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${widget.userCount}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CheckedContainer extends StatelessWidget {
  const CheckedContainer({
    Key? key,
    required this.widget,
    required this.countColor,
    required this.foregroundDeco,
  }) : super(key: key);

  final GymPageContainer widget;
  final Color countColor;
  final BoxDecoration foregroundDeco;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [widget.userCount * 0.05, 0],   // 인원 수
              colors: [
                countColor.withOpacity(0.4),   // 인원 색
                Colors.white
              ],
            ),
        ),
        foregroundDecoration: foregroundDeco,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.time,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),),
              Row(
                children: [
                  Icon(Icons.person),
                  Text(" :"),
                  Container(
                    width: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${widget.userCount}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                          ),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
        Positioned(
          top: 0.0,
          right: 0.0,
          left: 0.0,
          bottom: 0.0,
          child: Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 50,
          )
        )]
    );
  }
}

class LockedContainer extends StatelessWidget {
  const LockedContainer({
    Key? key,
    required this.widget,
    required this.countColor,
    required this.foregroundDeco,
  }) : super(key: key);

  final GymPageContainer widget;
  final Color countColor;
  final BoxDecoration foregroundDeco;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [widget.userCount * 0.05, 0],   // 인원 수
                colors: [
                  countColor.withOpacity(0.4),   // 인원 색
                  Colors.white
                ],
              ),
            ),
            foregroundDecoration: foregroundDeco,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.time,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15
                    ),),
                  Row(
                    children: [
                      Icon(Icons.person),
                      Text(" :"),
                      Container(
                        width: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${widget.userCount}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Icon(
                Icons.horizontal_rule_rounded,
                color: Colors.white,
                size: 50,
              )
          )]
    );
  }
}