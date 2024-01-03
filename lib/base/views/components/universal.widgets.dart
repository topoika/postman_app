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
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
