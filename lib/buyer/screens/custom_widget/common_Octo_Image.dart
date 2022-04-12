import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

Widget commonOctoImage(
    {String? image,
      double? height,
      double? width,
      bool circleShape = true,
      bool fit = false}) {
  String url = "https://vid-mates.com/abir/beauty-app4/public/";
  return OctoImage(
    image: NetworkImage(url + image!),
    imageBuilder: (context, child) {
      return circleShape
          ? CircleAvatar(
        backgroundImage: NetworkImage(url + image),
      )
          : Container(
        height: 812,
        width: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(url + image),
              fit: fit ? BoxFit.cover : BoxFit.contain),
        ),
      );
    },
    placeholderBuilder: OctoPlaceholder.blurHash(
      'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    ),
    /* progressIndicatorBuilder: (context, progress) {
      double value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes;
      }
      return CircularProgressIndicator(value: value);
    },*/
    errorBuilder: (context, error, stackTrace) {
      return Center(
        child: circleShape
            ? imageNotFound()
            : Text(
          'Image not load',
          textAlign: TextAlign.center,
        ),
      );
    },
    // errorBuilder: OctoError.icon(color: Colors.grey),
    fit: BoxFit.contain,
    height: height,
    width: width,
  );
}

Widget commonProfileOctoImage(
    {String? image,
      double? height,
      double? width,
      bool circleShape = true,
      bool fit = false}) {
  String url = "https://vid-mates.com/abir/beauty-app4/public/";
  return OctoImage(
    image: NetworkImage(url + image!),
    imageBuilder: (context, child) {
      return circleShape
          ? CircleAvatar(
        backgroundImage: NetworkImage(url + image),
      )
          : Container(
        height:812,
        width: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(url + image),
              fit: fit ? BoxFit.cover : BoxFit.contain),
        ),
      );
    },
    placeholderBuilder: OctoPlaceholder.blurHash(
      'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
    ),
    /* progressIndicatorBuilder: (context, progress) {
      double value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes;
      }
      return CircularProgressIndicator(value: value);
    },*/
    errorBuilder: (context, error, stackTrace) {
      return Center(
        child: Image.asset('assets/image/person.jpg'),
      );
    },
    // errorBuilder: OctoError.icon(color: Colors.grey),
    fit: BoxFit.contain,
    height: height,
    width: width,
  );
}

Widget imageNotFound() {
  return CircleAvatar(
    radius: Get.width * 0.075,
    backgroundColor: Colors.white,
    backgroundImage: AssetImage('assets/image/person.jpg'),
  );
}

Container imageNotLoadRectangle() {
  return Container(
    width: Get.width,
    height: Get.height * 0.225,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black26,
    ),
    child: Center(child: Text('Image not load')),
  );
}