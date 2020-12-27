import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/modal/product_dashbord_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/util/app_constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashBoard(title: ''),
    );
  }
}

class DashBoard extends StatefulWidget {
  DashBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashBoardState createState() => _DashBoardState();
}


class _DashBoardState extends State<DashBoard> {

  List<Category> all_category_list =  List<Category>();
  List<SubCategories> sub_category_list =  List<SubCategories>();

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionListener = ItemPositionsListener.create();
  int currentTab =0;
  bool isLoading = false;
  int page_number = 1;

  @override
  void initState() {
    super.initState();
    _dashboardList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black,
        actions: <Widget>[

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child:  Image.asset('assets/images/filter_icon.png',height: 20,width: 20,),
              )
          ),

          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),

        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // This is top horizontal List View
            Container(
                height: 50,
                child: ScrollablePositionedList.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: all_category_list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: FlatButton(
                        color: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            currentTab = index;
                            if(index == 1 && sub_category_list.length==0) {
                              _subCategoryList(page_number,all_category_list[index].id);
                            }
                          });
                        },
                        child: Text(all_category_list[index].name,
                          style: TextStyle(color: currentTab == index ? Colors.white : Colors.grey, fontSize: currentTab == index ? 20 : 15),
                        ),
                      ),
                    );
                  },
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionListener,
                )),

            // if category list size zero than progress bar shows and wait for api response
            all_category_list.length == 0 ? CircularProgressIndicator() :

            // after getting response from api
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8),
                  ),
                ),

                // Showing name of category
                child: currentTab != 1 ? Container(
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("${all_category_list[currentTab].name} Category", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                          color: Colors.black),),
                    ),
                  ),
                ) :

                // This is use for Pagination
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      // start loading data
                      setState(() {
                        isLoading = true;
                      });
                      _subCategoryList(page_number,all_category_list[currentTab].id);
                    }
                  },

                  // progress bar shows and wait for api response
                  child: sub_category_list.length ==0 ? Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):

                  // set sub category data
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sub_category_list.length,
                      itemBuilder:(context,index) {

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(sub_category_list[index].name.toUpperCase(),
                                    style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold))),


                            Container(
                                height: 160,
                                child:ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: sub_category_list[index].product.length,
                                    itemBuilder:(context,sub_index) {

                                      return Stack(
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network(
                                                sub_category_list[index].product[sub_index].imageName,
                                                fit : BoxFit.fill,
                                                height: 100.0,
                                                width: 100.0,
                                              ),
                                            ),
                                          ),


                                          Container(
                                            margin: const EdgeInsets.only(left: 18.0, top: 18.0),
                                            height: 20,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:8.0, top: 3.0),
                                              child: Text("${sub_category_list[index].product[sub_index].id}",
                                                  style: TextStyle(color: Colors.white, fontSize: 12)),
                                            ),
                                          ),

                                          Padding(
                                              padding: const EdgeInsets.only(top: 120.0,left: 12),
                                              child: Text(sub_category_list[index].product[sub_index].name,
                                                  style: TextStyle(color: Colors.black54, fontSize: 11))),
                                        ],
                                      );
                                    }
                                )
                            ),
                          ],
                        );
                      }
                  ),

                )
              ),
            ),

            // Showing progress bar at bottom
            Container(
              height: isLoading ? 50.0 : 0,
              color: Colors.white,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        )
      ),
    );
  }

  _dashboardList() async {

    var response = await http.Client().post(AppConstants.DashBoard,
        body: {
          AppConstants.CategoryId : "0" ,
          AppConstants.DeviceManufacturer: "0",
          AppConstants.DeviceModel : "Android SDK built for x86",
          AppConstants.DeviceToken: "",
          AppConstants.PageIndex : "1"},
        headers: {"Accept": "application/json"});

    var jsonData = json.decode(response.body);

    setState(() {
      all_category_list.clear();
      if (jsonData['Status'] == 200) {
          var result = jsonData["Result"];
          var category_data = result['Category'] as List;
          for (var model in category_data) {
            all_category_list.add(new Category.fromJson(model));
          }
      }
    });

  }

  _subCategoryList(int pageNo,int cat_id) async {

    var response = await http.Client().post(AppConstants.DashBoard,
        body: {
          AppConstants.CategoryId : "${cat_id}" ,
          AppConstants.PageIndex : "${pageNo}"},
        headers: {"Accept": "application/json"});

    var jsonData = json.decode(response.body);

    setState(() {
      if (jsonData['Status'] == 200) {
        var result = jsonData["Result"];
        var category_data = result['Category'];

        var subCategories_data = category_data[0]["SubCategories"] as List;

        if (subCategories_data != null) {
          for (var model in subCategories_data) {
            sub_category_list.add(new SubCategories.fromJson(model));
          }

          page_number = page_number + 1;

          isLoading = false;
        } else {
          isLoading = false;
        }
      }
    });

  }
}
