import 'package:dragable_app/constants/sizes.dart';
import 'package:flutter/material.dart';

enum Font {
  bold(FontWeight.w700),
  medium(FontWeight.w500),
  regular(FontWeight.w400),
  semiBold(FontWeight.w600);

  final FontWeight weight;
  const Font(this.weight);
}

enum Decorate {
  underline(TextDecoration.underline),
  overline(TextDecoration.overline),
  lineThrough(TextDecoration.lineThrough),
  none(TextDecoration.none);

  final TextDecoration value;
  const Decorate(this.value);
}

class Txt extends StatelessWidget {
  final String text;
  final double? size;
  final Font font;
  final Color? color;
  final Decorate decorate;
  final int? max;
  final TextAlign? align;
  final TextOverflow? clip;
  final double? space;
  final double? height;

  const Txt(
    this.text, {
    super.key,
    this.size,
    this.font = Font.regular,
    this.color,
    this.decorate = Decorate.none,
    this.max = 1,
    this.align,
    this.clip,
    this.space = 0,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: max,
      textAlign: align,
      overflow: clip,
      style: TextStyle(
        fontFamily: 'general_sans',
        fontSize: size ?? sizes.bodyLarge(context),
        fontWeight: font.weight,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        decoration: decorate.value,
        letterSpacing: space,
        height: height,
      ),
    );
  }
}
