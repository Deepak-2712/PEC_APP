import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget{
  @override
  SplashScreenState createState() => SplashScreenState();
    
} //class

class SplashScreenState extends State<SplashScreen>{
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller= VideoPlayerController.asset('splashvid/pec.mp4')..initialize().then((_){
      controller.play();

        controller.addListener((){
          if(controller.value.position== controller.value.duration){
            Navigator.pushReplacementNamed(context, '/main');
          }
           setState(() {

            }); //listener
        }
        );
      }); //setstate
    } //controller

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold( body:controller.value.isInitialized? Center(
        child: Transform.scale(
          scale: controller.value.aspectRatio/0.44,
          child: AspectRatio(aspectRatio: controller.value.aspectRatio,
           child: VideoPlayer(controller),),
        ),
        ): Center(child: CircularProgressIndicator() //if_false
    )
    );
  }
} //cls_state