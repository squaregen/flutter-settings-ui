import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:settings_ui/src/utils/settings_theme.dart';

class WebSettingsScrollSection extends StatelessWidget {
  const WebSettingsScrollSection({
    required this.tiles,
    required this.margin,
    required this.title,
    this.elevation = 0, // M3 preferisce 0 elevation per i container raggruppati
    this.color,
    this.icon,
    this.shape,
    this.marginCard,
    this.shadowColor,
    this.surfaceTintColor,
    Key? key,
  }) : super(key: key);

  final List<Widget> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;
  final Color? color;
  final double elevation;
  final Widget? icon;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? marginCard;
  final bool borderOnForeground = true;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  @override
  Widget build(BuildContext context) {
    return buildSectionBody(context);
  }

  Widget buildSectionBody(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 16, bottom: 8, top: 16),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: colorScheme.primary, // M3 usa il Primary per i titoli di sezione
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                ),
                child: Row(
                  children: [
                    if (icon != null) ...[
                      IconTheme(
                        data: IconThemeData(
                            color: colorScheme.primary, size: 18),
                        child: icon!,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(child: title!),
                  ],
                ),
              ),
            ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: elevation,
            shadowColor: shadowColor ?? Colors.transparent,
            // M3 Expressive usa bordi molto arrotondati (16-24dp)
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.3),
                    width: 1,
                  ),
                ),
            borderOnForeground: borderOnForeground,
            surfaceTintColor: surfaceTintColor ?? Colors.transparent,
            margin: marginCard ?? EdgeInsets.zero,
            // Colore di sfondo: Surface Container High per raggruppamenti
            color: color ?? colorScheme.surfaceContainerHigh,
            child: buildTileList(context),
          ),
        ],
      ),
    );
  }

  Widget buildTileList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(tiles.length > 0 ? (tiles.length * 2) - 1 : 0,
                (index) {
              if (!((index + 1) % 2 == 0)) {
                return tiles[(index / 2).truncate()];
              }
              // Divisore sottile e armonizzato
              return Divider(
                height: 0,
                thickness: 1,
                color: colorScheme.outlineVariant.withOpacity(0.5),
                indent: 16, // Indentazione M3 style
                endIndent: 16,
              );
            }),
      ),
    );
  }
}