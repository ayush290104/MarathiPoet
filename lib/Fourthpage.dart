import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhanuj/FifthPage.dart';

import 'controllerapi.dart';

class Fourthpage extends StatefulWidget {
   const Fourthpage({Key? key}) : super(key: key);



  @override
  State<Fourthpage> createState() => _FourthpageState();
}

class _FourthpageState extends State<Fourthpage> {
  TextEditingController _searchController = TextEditingController();
  final MyController myController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: _searchController,
                      onChanged: (String s){
                        myController.searched.value = s;
                      },
                      decoration: InputDecoration(
                        hintText: 'शब्द शोधा',
                        border: InputBorder.none,

                        suffixIcon: IconButton(onPressed: () {
                          myController.fetchsearchData(myController.searched.value);
                          _searchController.clear();

                        }, icon:  Icon(Icons.search)),),

                    ),
                  ),
                ),
              ),

              Center(child: Text("शब्द शोधा -> ${myController.searched.toString()}",style: TextStyle(
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
                } else if(myController.searchdata.length!=0) {
                  return ListView.builder(
                    shrinkWrap: true, // Add this line
                    physics: NeverScrollableScrollPhysics(), // Add this line
                    itemCount: myController.searchdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Column(
                        children: [
                          ListTile(
                            title: Text("कवी -> ${myController.searchdata[index]['pname']['author']['S'].toString()}",style: TextStyle(
                              fontSize: Get.width*0.05
                            ),),
                             subtitle: Text("कवितेचे नाव -> ${myController.searchdata[index]['pname']['title']['S'].toString()}",style: TextStyle(
                               fontSize: Get.width*0.04
                             ),),

                            onTap: () {
                                       myController.searchpoet.value = myController.searchdata[index]['pname']['author']['S'].toString();
                                       myController.searchpoem.value = myController.searchdata[index]['pname']['title']['S'].toString();
                                       myController.searchcategory.value = myController.searchdata[index]['cat']['S'].toString().substring(myController.searchpoet.value.length+1);
                                       myController.fetchpoemsearch(myController.searchdata[index]['pname']['author']['S'].toString(),myController.searchdata[index]['pname']['title']['S'].toString() );
                                        Get.to(Fifthpage());
                            },

                          ),
                          Divider(
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
                      const Text("एकही कविता मिळाली नाही",style: TextStyle(fontSize: 20,fontFamily: 'Shobhika'),),
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
