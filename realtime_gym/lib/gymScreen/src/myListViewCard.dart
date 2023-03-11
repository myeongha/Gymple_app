import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gymPage.dart';
import '../model.dart';

class ListViewCard extends StatefulWidget {
  const ListViewCard({
    Key? key,
    required this.gymData,
    required this.index,
    required this.pref
  }) : super(key: key);

  final List<Gym> gymData;
  final int index;
  final SharedPreferences pref;

  @override
  State<ListViewCard> createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {
    late String bannerImage;
    bannerImage = getBanner(widget.gymData, widget.index);
    return Card(
      // shadowColor: Colors.lightGreen.shade500,
      elevation: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
            title: Text(
                "    ${widget.gymData[widget.index].name}",
                style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GymPage(gym: widget.gymData[widget.index], pref: widget.pref))).then((_) {
                    setState(() {
                      bannerImage = getBanner(widget.gymData, widget.index);
                    });
              });
            },
        ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Image.asset(
                bannerImage,
            width: 50,
            height: 50,
            ),
          )
      ]),
    );
  }

  String getBanner(List<Gym> gymData, int index) {
    if (DateTime.now().hour >= 6) {
      if (gymData[index].userCount[(DateTime.now().hour - 6)~/2] < 5) {
        return "image/blue_banner.png";
      }
      else if (gymData[index].userCount[(DateTime.now().hour - 6)~/2] < 10) {
        return "image/orange_banner.png";
      }
      else {
        return "image/red_banner.png";
      }
    }
    else {
      return "image/blue_banner.png";
    }
  }
}