import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/helper/constants.dart';

ImageProvider cachedImage(String url,
    {String placeholderPath = 'assets/placeholder.png'}) {
  return CachedNetworkImageProvider(
    url,

    // placeholder: (context, url) =>
    //     Image.asset(placeholderPath), // Loading placeholder image
    // errorWidget: (context, url, error) =>
    //     Image.asset(placeholderPath), // Error placeholder image
  );
}

showLargeImage(context, img, fl) => showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: userImage(context, img, fl),
        );
      },
    );

Widget emptyWidget(context, double h, String txt) => Container(
      alignment: Alignment.center,
      width: getWidth(context, 100),
      height: h,
      child: Center(
        child: Text(txt,
            textScaleFactor: 1,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            )),
      ),
    );
Widget userImage(context, image, File? fl) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: double.maxFinite,
      height: getWidth(context, 90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: fl != null
            ? DecorationImage(
                image: FileImage(fl),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: cachedImage(image),
                fit: BoxFit.cover,
              ),
      ),
    );

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;

  CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 64,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset("assets/icons/back.png")),
      ),
      centerTitle: true,
      elevation: 0,
      title: Text(
        title,
        textScaleFactor: 1,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// black app bar
// ignore: must_be_immutable
class BlackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  List<Widget>? actions;

  BlackAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 68,
      backgroundColor: scafoldBlack,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: .4, color: Colors.grey)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      title: title,
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
