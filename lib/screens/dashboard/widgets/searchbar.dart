import 'package:flutter/material.dart';
import 'package:photopond/constants/colors.dart';
import 'package:photopond/constants/strings.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final void Function()? onTap;
  const SearchBar({Key? key, required this.controller, this.onTap, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
          color: BrandColors.searchbar,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50.w,
            height: 40,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: BrandColors.iconAndText,
                ),
                hintText: Strings.hintText,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  color: BrandColors.grey,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          InkWell(
              child: Container(
                height: 10.h,
                width: 12.w,
                margin: EdgeInsets.symmetric(vertical: 0.4.h),
                decoration: BoxDecoration(
                    color: BrandColors.pureWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  Strings.buttonText,
                  style: TextStyle(color: BrandColors.iconAndText),
                )),
              ),
              onTap: onTap),
        ],
      ),
    );
  }
}
