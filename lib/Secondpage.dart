import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Fourthpage.dart';
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
              Center(child: Text("${myController.poet.value} - ${myController.category.value}",style: TextStyle(
                  fontFamily: 'Shobhika',
                  fontSize: Get.width*0.08,
                  fontWeight: FontWeight.w400
              ),)),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
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
