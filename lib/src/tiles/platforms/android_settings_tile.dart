import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class AndroidSettingsTile extends StatelessWidget {
  const AndroidSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
    this.color,
    this.onDoublePressed,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;
  final Color? color;
  final Function(BuildContext context)? onDoublePressed;
  final Function(BuildContext context)? onLongPress;
  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;
    double leftPadding=24;
    double rightPadding=24;
    if (MediaQuery.of(context).size.width < 600){
      leftPadding = 8;
      rightPadding = 8;
    }
    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: color ?? Colors.transparent,
        child: InkWell(
          onTap: cantShowAnimation
              ? null
              : () {
                  if (tileType == SettingsTileType.switchTile) {
                    onToggle?.call(!initialValue);
                  } else {
                    onPressed?.call(context);
                  }
                },
          onDoubleTap: onDoublePressed!=null ? (){
            onDoublePressed?.call(context);
          } : null,
          onLongPress: onLongPress!=null ? (){
            onLongPress?.call(context);
          } : null,
          highlightColor: theme.themeData.tileHighlightColor,
          child: Container(
            child: Row(
              children: [
                if (leading != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: leftPadding),
                    child: IconTheme(
                      data: IconTheme.of(context).copyWith(
                        color: enabled
                            ? theme.themeData.leadingIconsColor
                            : theme.themeData.inactiveTitleColor,
                      ),
                      child: leading!,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: leftPadding,
                      end: leftPadding,
                      bottom: 19 * scaleFactor,
                      top: 19 * scaleFactor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(
                            color: enabled
                                ? theme.themeData.settingsTileTextColor
                                : theme.themeData.inactiveTitleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          child: title ?? Container(),
                        ),
                        if (value != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: enabled
                                    ? theme.themeData.tileDescriptionTextColor
                                    : theme.themeData.inactiveSubtitleColor,
                              ),
                              child: value!,
                            ),
                          )
                        else if (description != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: enabled
                                    ? theme.themeData.tileDescriptionTextColor
                                    : theme.themeData.inactiveSubtitleColor,
                              ),
                              child: description!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (trailing != null && tileType == SettingsTileType.switchTile)
                  Row(
                    children: [
                      trailing!,
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: Switch(
                          value: initialValue,
                          onChanged: onToggle,
                          activeColor: enabled
                              ? activeSwitchColor
                              : theme.themeData.inactiveTitleColor,
                        ),
                      ),
                    ],
                  )
                else if (tileType == SettingsTileType.switchTile)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 16, end: 8),
                    child: Switch(
                      value: initialValue,
                      onChanged: onToggle,
                      activeColor: enabled
                          ? activeSwitchColor
                          : theme.themeData.inactiveTitleColor,
                    ),
                  )
                else if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: trailing!,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
