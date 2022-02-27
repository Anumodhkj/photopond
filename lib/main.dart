import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photopond/screens/dashboard/dashboard.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, 
    statusBarColor: Colors.white, 
    systemNavigationBarDividerColor:Colors.white,
    systemNavigationBarIconBrightness:Brightness.light,
    systemNavigationBarContrastEnforced:false

  ));
  runApp(const PhotoPond());
}

class PhotoPond extends StatelessWidget {
  const PhotoPond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'photo pond',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor:Colors.white
        ),
        home: const Dashboard(),
      );
    });
  }
}
