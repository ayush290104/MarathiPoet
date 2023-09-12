import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Fourthpage.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Marathi Poet"),

      ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue, // Set the border color to blue
                          width: 2.0, // Set the border width as desired
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8),
                        child: TextField(
                          onChanged: (String s){
                            myController.searched.value = s;
                          },
                          decoration: InputDecoration(
                            hintText: 'शब्द शोधा',
                            border: InputBorder.none,

                            suffixIcon: IconButton(onPressed: () {
                              myController.fetchsearchData(myController.searched.value);
                              Get.to(Fourthpage());
                            }, icon:  Icon(Icons.search)),),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                      Center(child: Text(myController.poet.value,style: TextStyle(
                          fontFamily: 'Shobhika',
                          fontSize: Get.width*0.08,
                          fontWeight: FontWeight.w400
                      ),)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
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
