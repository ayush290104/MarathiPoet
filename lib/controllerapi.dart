import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medhanuj/Poemcategory.dart';

class MyController extends GetxController {
  final RxList<MyData> data = <MyData>[].obs;
  final RxList<MyData> data2 = <MyData>[].obs;// Store the response as a List of Poemcategory
  final RxList<dynamic> author = <dynamic>[].obs;
  final RxString poet = "".obs;
  final RxString category = "".obs;
  final RxList<dynamic> searchdata = <dynamic>[].obs;
  RxBool isload = false.obs;
  final RxString poemselected = "".obs;
  final RxList<String> poem = <String>[].obs;
  final RxList<String> poembyauthor = <String>[].obs;
  final RxInt index = (-1).obs;
  var responseData = RxMap<String, dynamic>({});
  final RxString searchpoet = "".obs;
  final RxString searchcategory = "".obs;
  final RxString searchpoem = "".obs;

  var responsesearch = RxMap<String,dynamic>({});
  final RxString searched = "".obs;

  Future<void> fetchauthor() async {
    debugPrint("came inside");
    final url = Uri.parse(
        'https://x3ceshqp3l4zeh4ogvsv3h3mfm0qoiua.lambda-url.us-east-1.on.aws/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;

        // Clear the existing data
        data.clear();

        // Parse the JSON response into Poemcategory objects and add them to the data list
        for (var item in jsonData) {
author.add(item);
          }


        // Update the data variable with the parsed JSON

      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
  Future<void> fetchData(String string) async {
    isload.value = true;
    debugPrint("came inside");
    final url = Uri.parse(
        'https://ckodyyzpndixmboxhjvht73mdu0adegy.lambda-url.us-east-1.on.aws/?$string');

    try {
      final response = await http.get(url);
      isload.value = false;
      if (response.statusCode == 200) {
        isload.value = false;
        final jsonData = json.decode(response.body) as List<dynamic>;

        // Clear the existing data
        data.clear();

        // Parse the JSON response into Poemcategory objects and add them to the data list
        jsonData.forEach((item) {

          final poemCategory = MyData.fromJson(item);
          data2.add(poemCategory);
          if(data.isEmpty){
            data.add(poemCategory);
          }
          else{
            if(data[data.length-1].author.name!=poemCategory.author.name){
              data.add(poemCategory);
            }
          }

        });

        // Update the data variable with the parsed JSON

      } else {
        isload.value = false;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isload.value = false;
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> fetchpoem() async {
    isload.value = true;
    debugPrint("came inside");
    final url = Uri.parse(
        'https://tpz27nhe7t2l4nhbt3fzq5opaa0lavpg.lambda-url.us-east-1.on.aws/?${poet} ${poemselected}');
debugPrint("url is : ${url}");
    try {

      final response = await http.get(url);
      if (response.statusCode == 200) {
      isload.value = false;

        // Clear the existing data
        responseData.clear();
        responseData.value = json.decode(response.body) as Map<String,dynamic>;
      } else {
        isload.value = false;

        throw Exception('Failed to load data');
      }
    } catch (e) {
      isload.value = false;

      throw Exception('Failed to fetch data: $e');
    }
  }
  Future<void> fetchsearchData(String string) async {
    isload.value = true;
    debugPrint("came inside");
    final url = Uri.parse(
        'https://6ll5hl5syati6eztratur4rdom0washf.lambda-url.us-east-1.on.aws/?${searched.value}');
    searched.value = "";
    debugPrint(url.toString());

    try {
      final response = await http.get(url);
      isload.value = false;
      if (response.statusCode == 200) {
        isload.value = false;
        final jsonData = json.decode(response.body) as List<dynamic>;

        // Clear the existing data
        searchdata.clear();

        // Parse the JSON response into Poemcategory objects and add them to the data list
        jsonData.forEach((item) {
          searchdata.add(item);


        });

        // Update the data variable with the parsed JSON

      } else {
        isload.value = false;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isload.value = false;
      throw Exception('Failed to fetch data: $e');
    }
  }
  Future<void> fetchpoemsearch(String poets,String poems) async {
    isload.value = true;
    debugPrint("came inside");
    final url = Uri.parse(
        'https://tpz27nhe7t2l4nhbt3fzq5opaa0lavpg.lambda-url.us-east-1.on.aws/?${poets} ${poems}');
    debugPrint("url is : ${url}");
    try {

      final response = await http.get(url);
      if (response.statusCode == 200) {
        isload.value = false;

        // Clear the existing data
        responsesearch.clear();
        responsesearch.value = json.decode(response.body) as Map<String,dynamic>;
      } else {
        isload.value = false;

        throw Exception('Failed to load data');
      }
    } catch (e) {
      isload.value = false;

      throw Exception('Failed to fetch data: $e');
    }
  }

}

