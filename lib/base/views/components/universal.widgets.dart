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
