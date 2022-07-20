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
    this.platform,
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
  final DevicePlatform? platform;
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
    DevicePlatform platform;
    if (this.platform == null || this.platform == DevicePlatform.device) {
      platform = PlatformUtils.detectPlatform(context);
    } else {
      platform = this.platform!;
    }

    final brightness = calculateBrightness(context);

    final themeData = ThemeProvider.getTheme(
      context: context,
      platform: platform,
      brightness: brightness,
    ).merge(theme: brightness == Brightness.dark ? darkTheme : lightTheme);

    return Container(
      color: themeData.settingsListBackground,
      width: MediaQuery.of(context).size.width,
      alignment: alignment ?? Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 810),
        child: SettingsTheme(
          themeData: themeData,
          platform: platform,
          child:
          SingleChildScrollView(
            controller: controller,
            physics: physics,
            padding: contentPadding ?? calculateDefaultPadding(platform, context),

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
      DevicePlatform platform, BuildContext context) {
    if (MediaQuery.of(context).size.width > 810) {
     // double padding = (MediaQuery.of(context).size.width - 810) / 2;
      switch (platform) {
        case DevicePlatform.android:
        case DevicePlatform.fuchsia:
        case DevicePlatform.linux:
        case DevicePlatform.iOS:
        case DevicePlatform.macOS:
        case DevicePlatform.windows:
          return EdgeInsets.symmetric(horizontal: 0);
        case DevicePlatform.web:
          return EdgeInsets.zero;
        case DevicePlatform.device:
          throw Exception(
            'You can\'t use the DevicePlatform.device in this context. '
            'Incorrect platform: SettingsList.calculateDefaultPadding',
          );
        default:
          return EdgeInsets.symmetric(
            horizontal: 0,
          );
      }
    }
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return EdgeInsets.symmetric(vertical: 0);
      case DevicePlatform.web:
        return EdgeInsets.symmetric(vertical: 20);
      case DevicePlatform.device:
        throw Exception(
          'You can\'t use the DevicePlatform.device in this context. '
          'Incorrect platform: SettingsList.calculateDefaultPadding',
        );
    }
  }

  Brightness calculateBrightness(BuildContext context) {
    final materialBrightness = Theme.of(context).brightness;
    final cupertinoBrightness = CupertinoTheme.of(context).brightness ??
        MediaQuery.of(context).platformBrightness;

    switch (applicationType) {
      case ApplicationType.material:
        return materialBrightness;
      case ApplicationType.cupertino:
        return cupertinoBrightness;
      case ApplicationType.both:
        return platform != DevicePlatform.iOS
            ? materialBrightness
            : cupertinoBrightness;
    }
  }
}
