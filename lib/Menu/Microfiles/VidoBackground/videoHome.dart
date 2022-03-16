import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({Key? key}) : super(key: key);

  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
        'https://media.istockphoto.com/videos/pizza-slice-video-id483233529')
      ..initialize().then((_) {
        controller.play();
        controller.setLooping(true);
        setState(() {});
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 100,
                height: 100,
                child: VideoPlayer(controller),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 270,
                width: Helper.getScreenWidth(context) * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30
                      ),
                      child: Text(
                        "Share your location",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "If we have location,we can do a better job\n     to find what you want and deliver it.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: Container(
                          width: Helper.getScreenWidth(context) * 1,
                          height: 60,
                          child: ApplyButton(
                            buttonname: "Yes,share my location",
                            radius: 12,
                          ),
                        ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "No,choose location manually",
                        style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.w500,fontSize: 15),
                      ),
                    ),




                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
