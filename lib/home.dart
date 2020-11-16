import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_pip/easy_pip.dart';
import 'package:camera/camera.dart';

import 'main.dart';
List<CameraDescription> cameras;

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final WidgetsFlutterBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth auth = FirebaseAuth.instance;
  var isEnabled = false;
  CameraController controller;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff18203d),
      body: Container(
          alignment: Alignment.center,
          child: PIPStack(
          backgroundWidget:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    signOutGoogle();
                  },
                  textColor: Color(0xff18203d),
                  child: Text(
                    "Sign out",
                  ),
                ),
                Player(
                  videoPlayerController: VideoPlayerController.asset(
                    'videos/six.mp4',
                  ),
                  looping: true,
                ),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                   // controller.initialize();
                    //slo();
                    setState(() {
                      isEnabled = !isEnabled;
                    });
                  },
                )
              ]),
          pipWidget: isEnabled ? Container(color: Colors.pink,):Container(),
            pipEnabled: isEnabled,
          ),
              ),);
  }

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut().whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    });
    // Navigator.pop(context);
    //print("User Signed Out");
  }

   slo() async{
  //  WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

}
