import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme/colors.dart';
import '../../constants/app_constants.dart';

class Links extends StatelessWidget {
  final double? fontSize;
  Links({Key? key, this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GestureDetector getLink(String title, String url) {
      return GestureDetector(
        child: Text(title,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: CustomColors.lighterBlue,
              fontSize: fontSize,
            )),
        onTap: () async {
          // parse url string and convert to Uri
          try {
            var uri = Uri.parse(url);
            launchUrl(uri);
          } catch (e) {
            print("Failed to parse url: $e");
          }
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getLink(FEEDBACK, feedbackLink),
        SizedBox(
          width: 24.0,
        ),
        getLink(FAQ, fagLink),
        SizedBox(
          width: 24.0,
        ),
        getLink(PRIVACY, privacyLink),
        SizedBox(
          width: 24.0,
        ),
        getLink(TERMS, termsLink),
      ],
    );
  }
}
