import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';

class WebSettingsScrollSection extends StatelessWidget {
  const WebSettingsScrollSection({
    required this.tiles,
    required this.margin,
    required this.title,
    this.color,
    Key? key,
  }) : super(key: key);

  final List<Widget> tiles;
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

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              height: 65 * scaleFactor,
              padding: EdgeInsetsDirectional.only(
                bottom: 5 * scaleFactor,
                start: 6,
                top: 40 * scaleFactor,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: theme.themeData.titleTextColor,
                  fontSize: 15,
                ),
                child: title!,
              ),
            ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            color: color ?? theme.themeData.settingsSectionBackground,
            child: buildTileList(),

          ),
        ],
      ),
    );
  }

  Widget buildTileList() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
        List.generate(tiles.length>0 ?(tiles.length*2)-1 : 0, (index) {
          if (!((index+1) % 2 == 0)){
            return tiles[(index/2).truncate()];
          }
          return Divider(
            height: 0,
            thickness: 1,
          );
        }),

      ),
    );
  }
}
