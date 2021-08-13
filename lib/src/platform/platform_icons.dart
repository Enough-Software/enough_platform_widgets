import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Common icons for both cupertino and material
class CommonPlatformIcons {
  CommonPlatformIcons._();

  static final isCupertino = Platform.isIOS || Platform.isMacOS;

  static IconData get ok =>
      isCupertino ? CupertinoIcons.check_mark : Icons.done;

  static IconData get cancel =>
      isCupertino ? CupertinoIcons.clear : Icons.cancel;

  static IconData get clear =>
      isCupertino ? CupertinoIcons.xmark_circle_fill : Icons.clear;

  static IconData get bold =>
      isCupertino ? CupertinoIcons.bold : Icons.format_bold;

  static IconData get italic =>
      isCupertino ? CupertinoIcons.italic : Icons.format_italic;

  static IconData get underlined =>
      isCupertino ? CupertinoIcons.underline : Icons.format_underline;

  static IconData get strikethrough =>
      isCupertino ? CupertinoIcons.strikethrough : Icons.format_strikethrough;
}
