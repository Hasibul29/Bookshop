import 'package:flutter/material.dart';

import '../../../common/default_text.dart';

AppBar appBar({required String title}) {
  return AppBar(
    title: DefaultText(
      text: title,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
  );
}
