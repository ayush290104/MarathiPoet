import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Thirdpage.dart';
import 'controllerapi.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {


  final MyController myController = Get.find();
  @override
  void initState() {
    super.initState();
    myController.poembyauthor.clear();
    myController.poembyauthor.value = func();

  }


  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(child: Text("${myController.poet.value} - ${myController.category.value}",style: TextStyle(
                fontSize: Get.width*0.08,
              ),)),
              SizedBox(
                height: 30,
              ),
             Obx(() =>ListView.builder(
                 // Add this line
               shrinkWrap: true, // Add this line
               physics: const NeverScrollableScrollPhysics(),
               itemCount: myController.poembyauthor.length,
               itemBuilder: (BuildContext context, int index) {
                 return Column(
                   children: [
                     ListTile(
                       title: Text(myController.poembyauthor[index]),

                       onTap: () {
                         myController.poemselected.value = myController.poembyauthor[index];
                         myController.index.value = index;
                         myController.fetchpoem();
                         Get.to(Thirdpage());
                       },
                     ),
                     const Divider(
                       color: Colors.grey, // You can customize the color here
                       thickness: 1.0,    // You can customize the thickness here
                     ),
                   ],
                 );
               },
             ), )
            ],
          ),
        ),
      ),
    );
  }

List<String> func(){
    List<String> s = [];

    for(var item in myController.data2){
      debugPrint("gng inside");
      if(item.author.name.toString().contains(myController.category)&&item.author.name.toString().contains(myController.poet)){
        debugPrint("gng inside2 ${item.group.name.toString()}");
        if(!(s.contains(item.group.name.toString()))) {
          s.add(item.group.name.toString());
        }

      }
    }
    return s;
}

}
