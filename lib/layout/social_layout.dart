import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/layout/cubit/states.dart';
import 'package:social_application/screens/new_post/new_post_screen.dart';
import 'package:social_application/shared/components/components.dart';

import '../shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
   // ignore: prefer_const_constructors_in_immutables
   SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context  , state){},
      builder: (context  , state){
        var cibut = SocialCubit.get(context);
        return Scaffold(
          key: cibut.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(cibut.titles[cibut.currentIndex],style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification,color: Colors.black,),
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Search,color: Colors.black),
              ),
            ],
          ),
          body:cibut.screen[cibut.currentIndex],

          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cibut.currentIndex,
            onTap: (index){
              cibut.changeBottomNav(index);
            },
            items: cibut.bottomItem,


            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: Colors.white,
          ),
          );
      },
    );
  }
}
