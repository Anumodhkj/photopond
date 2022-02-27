import 'package:flutter/material.dart';
import 'package:photopond/constants/colors.dart';

class ImageView extends StatefulWidget {
  final String photo;
  const ImageView({Key? key, required this.photo}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: BrandColors.searchbar,
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: BrandColors.iconAndText,
                  )),
            ),
          ),
        ),
        body: SizedBox(
            height: height,
            width: width,
            child: InteractiveViewer(child: Image.network(widget.photo))));
  }
}
