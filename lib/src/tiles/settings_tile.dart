import 'package:flutter/material.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/tiles/platforms/web_settings_tile.dart';


enum SettingsTileType { simpleTile, switchTile, navigationTile }

class SettingsTile extends AbstractSettingsTile {
  SettingsTile({
    this.leading,
    this.trailing,
    this.value,
    this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.color,
    this.onLongPress,
    this.onDoublePressed,
    this.duration = 1000,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.simpleTile;
  }

  SettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.color,
    this.onLongPress,
    this.onDoublePressed,
    this.duration = 1000,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.navigationTile;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.color,
    this.onLongPress,
    this.onDoublePressed,
    this.duration = 1000,
    Key? key,
  }) : super(key: key) {
    value = null;
    tileType = SettingsTileType.switchTile;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  final Widget? trailing;

  /// The widget at the center of the tile
  final Widget? title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  /// A function that is called by tap on a tile
  final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool value)? onToggle;
  late final SettingsTileType tileType;
  late final bool? initialValue;
  late final bool enabled;
  late final Color? color;
  late final Color? borderColor;
  final Function(BuildContext context)? onDoublePressed;
  final Function(BuildContext context)? onLongPress;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return WebSettingsTile(
      description: description,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onDoublePressed: onDoublePressed,
      onToggle: onToggle,
      tileType: tileType,
      value: value,
      leading: leading,
      title: title,
      enabled: enabled,
      trailing: trailing,
      activeSwitchColor: activeSwitchColor,
      initialValue: initialValue ?? false,
      color: color,
      borderColor: borderColor,
      duration: duration,
    );
  }
}
