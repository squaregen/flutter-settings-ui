import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/src/list/settings_list.dart';
import 'package:settings_ui/src/sections/abstract_settings_section.dart';
import 'package:settings_ui/src/utils/automatic_keep_alive_setting_section.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';
import 'package:settings_ui/src/utils/theme_provider.dart';
class SettingsScroll extends StatelessWidget {
  const SettingsScroll({
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
    this.alignment,
    this.width,
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
  final Alignment? alignment;
  ///dimensione orizzontale, lasciare null usare tutto lo spazio disponibile.
  final double? width;

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
      alignment: alignment ?? Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: SettingsTheme(
            themeData: themeData,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                [
                  Expanded(child:
                  SingleChildScrollView(
                      controller: controller,
                      physics: physics,
                      padding: contentPadding ?? calculateDefaultPadding(context),

                      child:

                      ConstrainedBox(
                        constraints: width!=null ? BoxConstraints(maxWidth: width!) : BoxConstraints(),
                        child: Column(

                          children: List.generate(sections.length, (index) {
                            if (automaticKeepAlive ?? false) {
                              return AutomaticKeepAliveProxy(child: sections[index]);
                            }
                            return sections[index];
                          }
                          ),
                        ),
                      ))),
                ])

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
/*class SettingsScroll extends StatelessWidget {
  const SettingsScroll({
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
    this.alignment,
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
  final Alignment? alignment;

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
      alignment: alignment ?? Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: SettingsTheme(
          themeData: themeData,
          child:
          SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: contentPadding ?? calculateDefaultPadding(context),

            child:
            Column(
              children: List.generate(sections.length, (index) {
                if (automaticKeepAlive ?? false) {
                  return AutomaticKeepAliveProxy(child: sections[index]);
                }
                return sections[index];
              }
              ),
            ),
          )

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

}*/
