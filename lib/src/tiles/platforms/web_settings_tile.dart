import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class WebSettingsTile extends StatelessWidget {
  const WebSettingsTile({
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
    this.onDoublePressed,
    this.onLongPress,
    this.color,
    this.duration =1000,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(BuildContext context)? onDoublePressed;
  final Function(BuildContext context)? onLongPress;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool initialValue;
  final bool enabled;
  final Widget? trailing;
  final Color? activeSwitchColor;
  final Color? color;
final int duration;


  @override
  Widget build(BuildContext context) {
    double leftPadding=24;
    double rightPadding=24;

    final theme = SettingsTheme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    if (MediaQuery.of(context).size.width < 600){
        leftPadding = 8;
        rightPadding = 8;
    }

    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: color ?? Colors.transparent,
        child: AnimatedContainer(
          duration: Duration(milliseconds: duration),
          color: color,
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
                      padding: EdgeInsetsDirectional.only(
                        start: leftPadding,
                      ),
                      child: IconTheme(
                        data: IconTheme.of(context).copyWith(
                          color: theme.themeData.leadingIconsColor,
                        ),
                        child: leading!,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: leftPadding,
                        end: rightPadding,
                        bottom: 19 * scaleFactor,
                        top: 19 * scaleFactor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title!=null)
                          DefaultTextStyle(
                            style: TextStyle(
                              color: theme.themeData.settingsTileTextColor,
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
                                  color: theme.themeData.tileDescriptionTextColor,
                                ),
                                child: value!,
                              ),
                            )
                          else if (description != null)
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: theme.themeData.tileDescriptionTextColor,
                                ),
                                child: description!,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // if (tileType == SettingsTileType.navigationTile)
                  //   Padding(
                  //     padding:
                  //         const EdgeInsetsDirectional.only(start: 6, end: 15),
                  //     child: IconTheme(
                  //       data: IconTheme.of(context)
                  //           .copyWith(color: theme.themeData.leadingIconsColor),
                  //       child: Icon(
                  //         CupertinoIcons.chevron_forward,
                  //         size: 18 * scaleFactor,
                  //       ),
                  //     ),
                  //   ),
                  if (trailing != null && tileType == SettingsTileType.switchTile)
                    Row(
                      children: [
                        trailing!,
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: Switch(
                            activeColor: activeSwitchColor ??
                                Color.fromRGBO(138, 180, 248, 1.0),
                            value: initialValue,
                            onChanged: onToggle,
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
                        activeColor: activeSwitchColor ??
                            Color.fromRGBO(138, 180, 248, 1.0),
                        onChanged: onToggle,
                      ),
                    )
                  else if (trailing != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: trailing!,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
