import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:like_button/like_button.dart';

class ImageCard extends StatefulWidget {
  final String imageURL;
  final void Function()? onTap;
  const ImageCard({Key? key, required this.imageURL, this.onTap}) : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap:widget.onTap,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
              height: 30.h,
              width: width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 232, 232),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(widget.imageURL, fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 233, 232, 232),
                    highlightColor: const Color.fromARGB(255, 199, 199, 199),
                    child: Container(
                      height: 30.h,
                      width: width,
                      color: Colors.grey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  );
                }),
              )),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LikeButton(
                size: 30,
                circleColor: const CircleColor(
                    start: Color.fromARGB(255, 255, 42, 42),
                    end: Color.fromARGB(255, 255, 71, 71)),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color.fromARGB(255, 238, 49, 49),
                  dotSecondaryColor: Color.fromARGB(255, 218, 27, 27),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked
                        ? const Color.fromARGB(255, 255, 24, 24)
                        : const Color.fromARGB(255, 212, 211, 211),
                    size: 30,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
