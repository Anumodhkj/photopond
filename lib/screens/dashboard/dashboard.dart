import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:photopond/constants/colors.dart';
import 'package:photopond/constants/strings.dart';
import 'package:photopond/controllers/get_data_controller.dart';
import 'package:photopond/helper/dialog_helper.dart';
import 'package:photopond/models/get_data_model.dart';
import 'package:photopond/screens/photoview/image_view.dart';
import 'package:photopond/screens/dashboard/widgets/image_card.dart';
import 'package:photopond/screens/dashboard/widgets/searchbar.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int page = 0;
  List<Hit>? hits = [];
  List<Hit>? hitsList = [];
  bool loadmore = false;
  late ScrollController? scrollController;
  late GetDataController dataController = Get.put(GetDataController());
  late final TextEditingController _controller = TextEditingController(text: "");
  void _scrollListener() {
    if (scrollController!.position.pixels ==
        scrollController!.position.maxScrollExtent) {
      log("scrolled....");
      setState(() {
        loadmore = true;
        page = page + 1;
        log("page number passing :" + page.toString());
        dataController.getImages(_controller.text, page);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController!.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
     onTap:()=> FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: BrandColors.pureWhite,
        body: SafeArea(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height:1.h ,),
                SizedBox(
                    width: 5.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black,
                          height: 0.3.h,
                          width: 3.h,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          color: Colors.black,
                          height: 0.3.h,
                          width: 2.h,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 3.h,
                ),
                const Text(
                  Strings.welcomeText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SearchBar(
                  controller: _controller,
                  onTap: () {
                    setState(() {
                      page = 1;
                      hits = [];
                      hitsList = [];
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_controller.text == "") {
                        DialogHelper.showFastmsg(Strings.wariningTitle,Strings.wariningMessage);
                      } else {
                        log("processing ....");
                        dataController.getImages(_controller.text, page);
                      }
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      hits = [];
                      hitsList = [];
                    });
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                Obx(() {
                  if (page == 1) hits = [];
                  if (dataController.getData.value.hits != null) {
                    hitsList = dataController.getData.value.hits;
                    for (var element in hitsList!) {
                      hits!.add(element);
                    }
                  }
                  return dataController.isLoading.value && page == 1
                      ? Expanded(
                          child: ListView.separated(
                              controller: scrollController,
                              itemBuilder: (context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 233, 232, 232),
                                  highlightColor:
                                      const Color.fromARGB(255, 199, 199, 199),
                                  child: Container(
                                    height: 30.h,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, int index) {
                                return SizedBox(height: 2.h);
                              },
                              itemCount: 2),
                        )
                      : dataController.isData.value
                          ? Container(
                              height: 5.h,
                              width: width,
                              alignment: Alignment.topCenter,
                              child: const Center(
                                  child: Text(
                                Strings.result,
                                textAlign: TextAlign.left,
                              )))
                          : Expanded(
                              child: Stack(
                              children: [
                                ListView.separated(
                                    controller: scrollController,
                                    itemBuilder: (context, int index) {
                                      return ImageCard(
                                        imageURL: hits![index]
                                            .largeImageUrl!
                                            .toString(),
                                        onTap: () => Get.to(() => ImageView(photo: hits![index].largeImageUrl!,)),
                                      );
                                    },
                                    separatorBuilder: (context, int index) {
                                      return SizedBox(height: 2.h);
                                    },
                                    itemCount: hits!.length),
                                dataController.isLoading.value && page != 1
                                    ? Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: width,
                                          alignment: Alignment.center,
                                          child: const Center(
                                              child: SizedBox(
                                                  height: 80,
                                                  width: 100,
                                                  child: SpinKitWave(
                                                    color:
                                                        Colors.red,
                                                    size: 35.0,
                                                  ))),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
