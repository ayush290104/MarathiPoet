import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhanuj/firstpage.dart';
import 'controllerapi.dart';

class Fifthpage extends StatefulWidget {
  const Fifthpage({Key? key}) : super(key: key);

  @override
  State<Fifthpage> createState() => _FifthpageState();
}

class _FifthpageState extends State<Fifthpage> {
  final MyController myController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),

              Obx(() => Text(
                myController.searchpoem.value,
                style: TextStyle(
                  fontFamily: 'Shobhika',
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width * 0.06,
                ),
              ),),
              SizedBox(height: 15),
              Center(
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
        myController.responsesearch['Item']['mytext'].toString(),
        style: TextStyle(
        fontFamily: 'Shobhika',
        fontSize: Get.width * 0.04,
        ),
        ),
        );
        }
        }),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      myController.searchcategory.value,
                      style: TextStyle(
                        fontFamily: 'Shobhika',
                        fontWeight: FontWeight.w600,
                        fontSize: Get.width * 0.05,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: () {
                        myController.data.clear();
                        myController.poet .value = myController.searchpoet.value;
                        myController.fetchData(myController.poet.value);

                        Get.to(Firstpage());

                      },
                      child: Text(
                        myController.searchpoet.value,
                        style: TextStyle(
                          fontFamily: 'Shobhika',
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width * 0.05,
                        ),
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
    );;
  }
}
