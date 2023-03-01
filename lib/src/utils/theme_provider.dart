import 'package:flutter/cupertino.dart';
import 'package:settings_ui/src/utils/platform_utils.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';

class ThemeProvider {
  static SettingsThemeData getTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    return _webTheme(context: context, brightness: brightness);

  }

  static SettingsThemeData _webTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    final lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
    final darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

    final lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
    //done
    final darkSettingsListBackground = Color.fromRGBO(32, 33, 36, 1);

    final lightSettingSectionColor = CupertinoColors.white;
    //done
    final darkSettingSectionColor = Color(0xFF292a2d);

    final lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
    //done
    final darkSettingsTitleColor = Color.fromRGBO(232, 234, 237, 1);

    final lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
    final darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

    final lightSettingsTileTextColor = Color.fromARGB(255, 27, 27, 27);
    //done
    final darkSettingsTileTextColor = Color.fromARGB(232, 234, 237, 240);

    final lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
    final darkTileDescriptionTextColor = Color.fromARGB(154, 160, 166, 198);

    final isLight = brightness == Brightness.light;

    final listBackground =
        isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final titleTextColor =
        isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final settingsTileTextColor =
        isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

    final tileHighlightColor =
        isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

    final leadingIconsColor =
        isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final sectionBackground =
        isLight ? lightSettingSectionColor : darkSettingSectionColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      settingsListBackground: listBackground,
      titleTextColor: titleTextColor,
      settingsSectionBackground: sectionBackground,
      settingsTileTextColor: settingsTileTextColor,
      tileDescriptionTextColor: tileDescriptionTextColor,
      leadingIconsColor: leadingIconsColor,
    );
  }
}
