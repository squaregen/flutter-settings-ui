import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
import 'package:settings_ui/src/utils/automatic_keep_alive_setting_section.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';
import 'package:settings_ui/src/utils/theme_provider.dart';

enum ApplicationType {
  /// Use this parameter is you are using the MaterialApp
  material,

  /// Use this parameter is you are using the CupertinoApp
  cupertino,

  /// Use this parameter is you are using the MaterialApp for Android
  /// and the CupertinoApp for iOS.
  both,
}

class SettingsList extends StatelessWidget {
  const SettingsList({
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
      decoration: BoxDecoration(color: themeData.settingsListBackground, gradient: themeData.settingListGradientBackground),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 810),
        child: SettingsTheme(
          themeData: themeData,
          child: ListView.builder(
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
