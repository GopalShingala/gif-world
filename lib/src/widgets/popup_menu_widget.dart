import 'dart:io';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget({Key? key}) : super(key: key);

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text("Share App     "),
          value: 1,
          onTap: () {
            Share.share(
                'Hey, get interesting all type of GIFs easily from App.\n\nDownload from here,\nAndroid - https://play.google.com/store/apps/details?id=com.jsk.gifsworld\niOS - https://apps.apple.com/us/app/gif-world-free/id1602370275');
          },
        ),
        PopupMenuItem(
          child: const Text("Rate Us"),
          value: 2,
          onTap: () async {
            print('RATE US --------------------------');
            if (Platform.isAndroid) {
              await LaunchReview.launch(
                  androidAppId: 'com.jsk.gifsworld', writeReview: true);
            } else {
              await LaunchReview.launch(
                  iOSAppId: 'id1602370275', writeReview: true);
            }
          },
        ),
      ],
    );
  }
}
