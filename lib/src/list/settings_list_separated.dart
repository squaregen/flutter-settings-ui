import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
import 'package:settings_ui/src/utils/automatic_keep_alive_setting_section.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';
import 'package:settings_ui/src/utils/theme_provider.dart';

import '../../settings_ui.dart';


class SeparatedSettingsList extends StatelessWidget {
  const SeparatedSettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.lightTheme,
    this.darkTheme,
    this.brightness,
    this.contentPadding,
    this.applicationType = ApplicationType.material,
    this.cacheExtent,
    this.controller,
    this.automaticKeepAlive,
    Key? key,
  }) : super(key: key);

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final SettingsThemeData? lightTheme;
  final SettingsThemeData? darkTheme;
  final Brightness? brightness;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget> sections;
  final ApplicationType applicationType;
  final double? cacheExtent;
  final ScrollController? controller;
  final bool? automaticKeepAlive;

  @override
  Widget build(BuildContext context) {


    final brightness = Theme.of(context).brightness;

    final themeData = ThemeProvider.getTheme(
      context: context,
      brightness: brightness,
    ).merge(theme: brightness == Brightness.dark ? darkTheme : lightTheme);

    return Container(
      color: themeData.settingsListBackground,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 810),
        child: SettingsTheme(
          themeData: themeData,
          child: ListView.separated(
            controller: controller,
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: sections.length,
            cacheExtent: cacheExtent,
            padding: contentPadding ?? calculateDefaultPadding(context),
            itemBuilder: (BuildContext context, int index) {
              if (automaticKeepAlive ?? false){
                return AutomaticKeepAliveProxy(child: sections[index]);
              }
              return sections[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 0,
                thickness: 1,
              );
            },
          ),
        ),
      ),
    );
  }



  EdgeInsets calculateDefaultPadding(
      BuildContext context) {
    if (MediaQuery.of(context).size.width > 810) {
      return EdgeInsets.zero;
    } else {
      return EdgeInsets.symmetric(vertical: 20);
    }


  }

}
