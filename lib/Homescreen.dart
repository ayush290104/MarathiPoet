import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhanuj/Fourthpage.dart';
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
    myController.fetchauthor();
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
               Center(child: Text("कवींची मांदियाळी",style: TextStyle(
                  fontFamily: 'Shobhika',
                  fontSize: Get.width*0.08,
                  fontWeight: FontWeight.w400
              ),)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
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
