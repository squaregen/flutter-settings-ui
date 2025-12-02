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
    this.duration = 1000,
    this.borderColor,
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
  final Color? borderColor;
  final int duration;

  @override
  Widget build(BuildContext context) {
    // M3 Expressive preferisce padding generosi
    double leftPadding = 16;
    double rightPadding = 16;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Gestione compatibilità textScaleFactor/textScaler
    final double scaleFactor = MediaQuery.textScalerOf(context).scale(1);

    if (MediaQuery.of(context).size.width < 600) {
      leftPadding = 16;
      rightPadding = 16;
    }

    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return IgnorePointer(
      ignoring: !enabled,
      child: AnimatedContainer(
        duration: Duration(milliseconds: duration),
        decoration: BoxDecoration(
          color: color,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
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
            onDoubleTap: onDoublePressed != null
                ? () {
              onDoublePressed?.call(context);
            }
                : null,
            onLongPress: onLongPress != null
                ? () {
              onLongPress?.call(context);
            }
                : null,
            splashColor: colorScheme.primary.withOpacity(0.1),
            highlightColor: colorScheme.primary.withOpacity(0.05),
            child: ExcludeFocusTraversal(
              excluding: !enabled,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: leftPadding,
                  end: rightPadding,
                  top: 16 * scaleFactor, // Padding verticale aumentato per M3
                  bottom: 16 * scaleFactor,
                ),
                child: Row(
                  children: [
                    if (leading != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 16),
                        child: IconTheme(
                          data: IconTheme.of(context).copyWith(
                            color: enabled
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface.withOpacity(0.38),
                            size: 24,
                          ),
                          child: leading!,
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (title != null)
                            DefaultTextStyle(
                              style: textTheme.bodyLarge!.copyWith(
                                color: enabled
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurface.withOpacity(0.38),
                                fontWeight: FontWeight.w400,
                              ),
                              child: title!,
                            ),
                          if (value != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: DefaultTextStyle(
                                style: textTheme.bodyMedium!.copyWith(
                                  color: enabled
                                      ? colorScheme.primary
                                      : colorScheme.onSurface.withOpacity(0.38),
                                ),
                                child: value!,
                              ),
                            )
                          else if (description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: DefaultTextStyle(
                                style: textTheme.bodyMedium!.copyWith(
                                  color: enabled
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.onSurface.withOpacity(0.38),
                                ),
                                child: description!,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (trailing != null &&
                        tileType == SettingsTileType.switchTile)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultTextStyle(
                              style: textTheme.labelLarge!.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              child: trailing!),
                          const SizedBox(width: 12),
                          _buildM3Switch(initialValue, onToggle,
                              activeSwitchColor, colorScheme),
                        ],
                      )
                    else if (tileType == SettingsTileType.switchTile)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8),
                        child: _buildM3Switch(initialValue, onToggle,
                            activeSwitchColor, colorScheme),
                      )
                    else if (trailing != null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 16),
                          child: IconTheme(
                            data: IconThemeData(
                              color: colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                            child: DefaultTextStyle(
                              style: textTheme.bodyMedium!.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              child: trailing!,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildM3Switch(bool value, Function(bool)? onChanged, Color? activeColor,
      ColorScheme colorScheme) {
    // M3 Switch nativo
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeSwitchColor ?? colorScheme.primaryContainer,
      activeTrackColor: activeSwitchColor ?? colorScheme.primary,
      inactiveThumbColor: colorScheme.outline,
      inactiveTrackColor: colorScheme.surfaceContainerHighest,
      trackOutlineColor: MaterialStateProperty.resolveWith(
            (states) => Colors.transparent, // M3 switches usually have no outline border
      ),
    );
  }
}