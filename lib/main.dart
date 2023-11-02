import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/layout/social_layout.dart';
import 'package:social_application/screens/login/login_screen.dart';
import 'package:social_application/screens/on_boarding/on_boarding.dart';
import 'package:social_application/shared/network/local/cach_helper.dart';

import 'firebase_options.dart';
import 'shared/components/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  if(onBoarding != null)
  {
    if(uId != null)
    {
      widget = SocialLayout();
    }else
    {
      widget = LoginScreen();
    }
  }else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startWidget});

  final Widget? startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)  => SocialCubit()..getUserData()..getPosts()..getStory(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
