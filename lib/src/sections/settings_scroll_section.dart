import 'package:flutter/material.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
import 'package:settings_ui/src/sections/platforms/android_settings_scroll_section.dart';
import 'package:settings_ui/src/sections/platforms/android_settings_section.dart';
import 'package:settings_ui/src/sections/platforms/ios_settings_scroll_section.dart';
import 'package:settings_ui/src/sections/platforms/ios_settings_section.dart';
import 'package:settings_ui/src/sections/platforms/web_settings_scroll_section.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';

class SettingsScrollSection extends AbstractSettingsSection {
  const SettingsScrollSection({
    required this.tiles,
    this.margin,
    this.title,
    this.color,
    Key? key,
  }) : super(key: key);

  final List<Widget> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);

    switch (theme.platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return AndroidSettingsScrollSection(
          title: title,
          tiles: tiles,
          margin: margin,
          color: color,
        );
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return IOSSettingsScrollSection(
          title: title,
          tiles: tiles,
          margin: margin,
          color: color,
        );
      case DevicePlatform.web:
        return WebSettingsScrollSection(
          title: title,
          tiles: tiles,
          margin: margin,
          color: color,

        );
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsSection.build',
        );
    }
  }
}
