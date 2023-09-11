import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllerapi.dart';

class Thirdpage extends StatefulWidget {
  const Thirdpage({Key? key}) : super(key: key);

  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  final MyController myController = Get.find();
  double zoomLevel = 1.0; // Initial zoom level
  double maxZoomLevel = 1.3; // Maximum zoom level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),

              Obx(() => Text(
                myController.poemselected.value,
                style: TextStyle(
                  fontFamily: 'Shobhika',
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.06,
                ),
              ),),
              SizedBox(height: 15),
              Center(
                child:  GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      // Swiped right
                      myController.poemselected.value = myController.poembyauthor[(myController.index.value-1)%myController.poembyauthor.length];
                      myController.index.value= (myController.index.value-1)%myController.poembyauthor.length;
                      myController.fetchpoem();

                    } else if(details.primaryVelocity! < 0 ) {
                      // Swiped left
                      myController.poemselected.value = myController.poembyauthor[(myController.index.value+1)%myController.poembyauthor.length];
                      myController.index.value= (myController.index.value+1)%myController.poembyauthor.length;
                      myController.fetchpoem();
                    }
                  },



                  child:Obx(() {
                    if (myController.isload.value) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: Get.height * 0.5),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          myController.responseData['Item']['mytext'].toString(),
                          style: TextStyle(
                            fontFamily: 'Shobhika',
                            fontSize: Get.width * 0.04,
                          ),
                        ),
                      );
                    }
                  }),

                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      myController.category.value,
                      style: TextStyle(
                        fontFamily: 'Shobhika',
                        fontWeight: FontWeight.w600,
                        fontSize: Get.width * 0.05,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      myController.poet.value,
                      style: TextStyle(
                        fontFamily: 'Shobhika',
                        fontWeight: FontWeight.w600,
                        fontSize: Get.width * 0.05,
                      ),
                    ),
                  ),
                ],
              )
              ,



              // Add more widgets as needed
              ],
          ),
        ),
      ),
    );
  }
}
