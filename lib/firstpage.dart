import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Secondpage.dart';
import 'controllerapi.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final MyController myController = Get.find();
  void initState() {
    super.initState();
    myController.fetchData(myController.poet.value); // Call fetchData in initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                      Center(child: Text(myController.poet.value,style: TextStyle(
                       fontSize: 30,
                     ),)),
                  SizedBox(
                    height: 30,
                  ),


                  Obx(() {
                    if (myController.isload.value) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.5,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if(myController.data.length!=0) {
                      return ListView.builder(
                        shrinkWrap: true, // Add this line
                        physics: NeverScrollableScrollPhysics(), // Add this line
                        itemCount: myController.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(myController.data[index].author.name.toString().substring(myController.poet.value.length+1)),

                                  onTap: () async {
                                    myController.category.value = myController.data[index].author.name.toString().substring(myController.poet.value.length + 1);
                                    await Future.delayed(Duration(milliseconds: 100)); // This ensures that the navigation happens after the current build is complete
                                    Get.to(Secondpage());
                                  },

                              ),
                              const Divider(
                                color: Colors.grey, // You can customize the color here
                                thickness: 1.0,    // You can customize the thickness here
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else{

                      return Column(
                        children: [
                          SizedBox(
                            height: Get.height*0.4,
                          ),
                          TextButton( onPressed: () {
                            myController.fetchData(myController.poet.value);
                          }, child: Text("Retry"),),
                        ],
                      );
                    }
                  }),
                  // Add more widgets as needed
                ],
              ),
            ),
          ),


    );
  }
}
