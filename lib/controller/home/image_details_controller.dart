import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_world/src/widgets/toast_msg_widget.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';

class ImageDetailsController extends GetxController {
  shareImage({@required String? gifUrl}) async {
    try {
      ToastMessages().flutterToast('Sharing...');

      final imageId = await ImageDownloader.downloadImage(gifUrl!);
      final path = await ImageDownloader.findPath(imageId!);

      Share.shareFiles([path!],
          text:
              'Hey, get interesting all type of GIFs easily from App.\n\nDownload from here,\nAndroid - https://play.google.com/store/apps/details?id=com.jsk.gifsworld\niOS - https://apps.apple.com/us/app/gif-world-free/id1602370275');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  saveVideo({@required String? gifUrl}) async {
    debugPrint(gifUrl);
    ToastMessages().flutterToast('Downloding...');
    final imageId = await ImageDownloader.downloadImage(gifUrl!);

    if (imageId!.isNotEmpty) {
      ToastMessages().flutterToast('Download Successful');
    } else {
      ToastMessages().flutterToast('Something went wrong!');
    }
  }
}
