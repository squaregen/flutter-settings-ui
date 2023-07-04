import 'package:flutter/material.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
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
    this.icon,
    this.elevation = 4,
    Key? key,
  }) : super(key: key);

  final List<Widget> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;
  final Color? color;
  final double elevation;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return WebSettingsScrollSection(
      title: title,
      tiles: tiles,
      margin: margin,
      color: color,
      elevation: elevation,
      icon: icon,
    );
  }
}
