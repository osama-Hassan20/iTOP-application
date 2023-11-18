import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_application/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_application/screens/login/login_screen.dart';

import '../../shared/network/local/cach_helper.dart';
class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard1.png',
        title: 'SOCIAL',
        body: 'Watch and follow what your friends are doing from my life posts'),
    BoardingModel(
        image: 'assets/images/onboard2.png',
        title: 'COMMENTS',
        body: 'Interact with posts by giving comments'),
    BoardingModel(
        image: 'assets/images/onboard3.png',
        title: 'SEND MESSAGE',
        body: 'Send and share instant messages and photos with friends'),

  ];

  bool isLast = false;
  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value)
    {
      if(value!){

        navigateAndFinish(context, LoginScreen());


      }
    });
  }
  String textButton = 'next';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFfafafa),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultTextButton(
                function: () {
                  submit();
                },
                text: 'SKIP',
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      textButton = 'get started';
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      textButton = 'next';
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.teal,
                      dotColor: Colors.grey,
                      dotHeight: 15,
                      expansionFactor: 3,
                      dotWidth: 10,
                      spacing: 6),
                ),
                Spacer(),
                defaultButton(
                  function: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    }
                  },
                  text: textButton,
                  isUpperCase: true,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}',),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 24,
              // fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),

        ],
      );
}
