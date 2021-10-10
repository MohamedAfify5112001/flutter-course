import 'package:course_flutter/modules/shop_app/login_screen/login_screen.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title1;
  final String title2;

  BoardingModel(
      {required this.image, required this.title1, required this.title2});
}

class BoardingScreen extends StatelessWidget {
  var boardingController = PageController();
  bool isLast = false;
  List<BoardingModel> models = [
    BoardingModel(
        image: "assets/images/undraw_shopping_app_flsj.png",
        title1: "Now shopping in this app",
        title2: "There are more offers"),
    BoardingModel(
        image: "assets/images/monitor.png",
        title1: "There are more categories",
        title2: "you can watch it"),
    BoardingModel(
        image: "assets/images/camera.png",
        title1: "more electronics in our shop",
        title2: "There is more offers for electronics"),
    BoardingModel(
        image: "assets/images/smart.png",
        title1: "Our shop is Successful ",
        title2: "There are more good reviews about us"),
    BoardingModel(
        image: "assets/images/undraw_web_shopping_re_owap.png",
        title1: "Now you can do web shopping",
        title2: "We hope our shop that help you"),
    BoardingModel(
        image: "assets/images/add_to_cart.png",
        title1: "you can add cart easily",
        title2: "Thanks for you"),
  ];

  void submit(context)
  {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value)
    {
      if(value){
        pushAndRemoveUntilPageTo(context, LoginScreen());
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit(context);
              },
              child: Text(
                "SKIP",
                style: TextStyle(color: Colors.deepPurple, fontSize: 15.0),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(models[index]),
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemCount: models.length,
                onPageChanged: (index){
                  if(index == models.length - 1){
                    isLast = true;
                  }else{
                    isLast = false;
                  }
                },
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: models.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepPurple,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    spacing: 7.0
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit(context);
                    }else{
                      boardingController.nextPage(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.chevron_right,
                    size: 35.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel models) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage('${models.image}')),
          ),
          Text(
            '${models.title1}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            '${models.title2}',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey,
            ),
          ),
        ],
      );
}
