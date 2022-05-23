import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoomImage extends StatelessWidget {
  final String? img;
  final String? userName;

  const ZoomImage({Key? key, this.img, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: 1.0,
              child: CachedNetworkImage(
                imageUrl: img!,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                  height: 75,
                  width: Get.width,
                  color: Colors.black26,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // title: Text('$userName'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}