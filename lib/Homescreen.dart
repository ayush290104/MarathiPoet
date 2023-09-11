import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhanuj/firstpage.dart';
import 'controllerapi.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final MyController myController = Get.put(MyController());
 @override
  void initState() {
    super.initState();
    myController.data.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              const Center(child: Text("कवींची मांदियाळी",style: TextStyle(
                  fontFamily: 'Shobhika',
                  fontSize: 30,
                  fontWeight: FontWeight.w400
              ),)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Obx(() {
                if (myController.author.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.3,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [

                      ListView.builder(
                        shrinkWrap: true, // Add this line
                        // Add this line
                        itemCount: myController.author.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text("कवी : ${myController.author[index].toString()}",style: TextStyle(fontFamily: 'Shobhika'),),

                                onTap: () {
                                  myController.poet .value = myController.author[index].toString();
                                  Get.to(const Firstpage());

                                },

                              ),
                              const Divider(
                                color: Colors.grey, // You can customize the color here
                                thickness: 1.0,    // You can customize the thickness here
                              ),
                            ],
                          );
                        },
                      ),
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
