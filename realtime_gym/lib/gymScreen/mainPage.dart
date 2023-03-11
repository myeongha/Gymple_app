import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:realtime_gym/gymScreen/src/myListViewCard.dart';
import 'package:realtime_gym/gymScreen/src/myScrollBehavior.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.gymData, required this.pref}) : super(key: key);

  final List<Gym> gymData;
  final SharedPreferences pref;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  bool isNotyPermitted = false;
  final BannerAd myBanner = BannerAd(
      adUnitId: "ca-app-pub-4020243685018412/9322593692", // 샘플 광고ID ca-app-pub-3940256099942544/6300978111
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener()
  );
  late AdWidget adWidget;
  late Container adContainer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getNotyPermitInfo();   // 알림 권한 받기

    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
    adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () => exit(0),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
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
            // actions: [
            //   Container(
            //     child: Padding(
            //       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
            //       child: IconButton(
            //         onPressed: () {
            //           // TODO: 위치 관련 정보 표시
            //         },
            //         icon: Icon(Icons.near_me_outlined,
            //         color: Colors.green.shade300,
            //         size: 30),
            //       ),
            //     )
            //   )],
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                  child: ScrollConfiguration(
                    behavior: MyScrollBehavior(),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.gymData.length,
                      itemBuilder: (context, index) {
                        return ListViewCard(gymData: widget.gymData, index: index, pref: widget.pref);
                      },
                    ),
                  ),
                ),
              ),
              adContainer
            ],
          ),
        ),
      );
  }

  Future<void> getNotyPermitInfo() async {
    isNotyPermitted = widget.pref.getBool("noty") ?? false;
    if (!isNotyPermitted) {
      getPermssionNotificiation();
    }
  }

  Future<void> getPermssionNotificiation() async {
    var status = await Permission.notification.status;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final deviceData = await deviceInfoPlugin.androidInfo;
    final version = deviceData.version.sdkInt;

    if (status != PermissionStatus.granted) {
      await showDialog(context: context,
          builder: (_) => AlertDialog(
            title: Text("알림 권한 요청"),
            content: Text("운동 예약 알림기능을 위해\n알림 권한이 필요합니다."
                "\n설정 창으로 이동하시겠습니까?",
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                child: Text("예",
                  style: TextStyle(
                      color: Colors.teal
                  ),),
                onPressed: () {
                  AppSettings.openAppSettings();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                  onPressed: () {
                    widget.pref.setBool("noty", true);
                    Navigator.pop(context);
                  },
                  child: Text("아니오(다시 묻지 않기)",
                  style: TextStyle(
                    color: Colors.teal
                  ),))
            ],
          ));
    }
  }
}

