import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_info.dart';

/// Common icons for both cupertino and material
class CommonPlatformIcons {
  CommonPlatformIcons._();

  static final _isCupertino = PlatformInfo.isCupertino;

  static IconData get ok =>
      _isCupertino ? CupertinoIcons.check_mark : Icons.done;

  static IconData get cancel =>
      _isCupertino ? CupertinoIcons.clear : Icons.cancel;

  static IconData get clear =>
      _isCupertino ? CupertinoIcons.xmark_circle_fill : Icons.clear;

  static IconData get bold =>
      _isCupertino ? CupertinoIcons.bold : Icons.format_bold;

  static IconData get italic =>
      _isCupertino ? CupertinoIcons.italic : Icons.format_italic;

  static IconData get underlined =>
      _isCupertino ? CupertinoIcons.underline : Icons.format_underline;

  static IconData get strikethrough =>
      _isCupertino ? CupertinoIcons.strikethrough : Icons.format_strikethrough;

  static IconData get info => _isCupertino ? CupertinoIcons.info : Icons.info;
}
