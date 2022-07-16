import 'package:flutter/material.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';

class AndroidSettingsScrollSection extends StatelessWidget {
  const AndroidSettingsScrollSection({
    required this.tiles,
    required this.margin,
    this.color,
    this.title,
    Key? key,
  }) : super(key: key);

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return buildSectionBody(context);
  }

  Widget buildSectionBody(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final tileList = buildTileList();

    if (title == null) {
      return tileList;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 24 * scaleFactor,
            bottom: 10 * scaleFactor,
            start: 24,
            end: 24,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: theme.themeData.titleTextColor,
            ),
            child: title!,
          ),
        ),
        Container(
          color: color ?? theme.themeData.settingsSectionBackground,
          child: tileList,
        ),
      ],
    );
  }

  Widget buildTileList() {

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
        List.generate(tiles.length, (index) {
          return tiles[index];
        }),

      ),
    );
  }
}
