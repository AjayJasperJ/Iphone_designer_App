import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final String tag;
  const ProductDetailScreen({required this.product, required this.tag, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displaysize.height * .06),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    minimumSize: Size(32, 32),
                    child: Icon(
                      CupertinoIcons.back,
                      size: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: displaysize.width * .6,
                      child: Center(
                        child: Txt(
                          product['title'] ?? '',
                          font: Font.medium,
                          size: sizes.titleLarge(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: displaysize.height * .02),
              Container(
                height: displaysize.height * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: .1),
                ),
                child: Center(
                  child: Hero(
                    tag: tag,
                    child: product['icon'] != null
                        ? Image.asset(product['icon'], height: 180, fit: BoxFit.contain)
                        : SizedBox.shrink(),
                  ),
                ),
              ),
              SizedBox(height: displaysize.height * .04),
              Txt(product['title'] ?? '', font: Font.medium, size: sizes.titleLarge(context)),
              SizedBox(height: displaysize.height * .02),
              Txt('Description :', font: Font.medium),
              if (product['description'] != null) ...[
                SizedBox(height: 12),
                Txt(
                  product['description'],
                  max: 10,
                  height: 1.5,
                  size: sizes.titleMedium(context),
                  font: Font.regular,
                ),
              ],
              SizedBox(height: displaysize.height * .02),
              if (product['ram'] != null || product['rom'] != null || product['screensize'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt('Specification :', font: Font.medium),
                    SizedBox(height: displaysize.height * .02),
                    if (product['ram'] != null) Txt('RAM: ${product['ram']}'),
                    SizedBox(height: displaysize.height * .01),
                    if (product['rom'] != null) Txt('Storage: ${product['rom']}'),
                    SizedBox(height: displaysize.height * .01),
                    if (product['screensize'] != null) Txt('Screen: ${product['screensize']}'),
                  ],
                ),
              SizedBox(height: displaysize.height * .02),
              if (product['color'] != null && product['color'] is List)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt('Colors :', font: Font.medium),
                    SizedBox(height: displaysize.height * .02),
                    for (final color in product['color'])
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt('• ', color: Theme.of(context).colorScheme.primary),
                              Expanded(child: Txt(color.toString())),
                            ],
                          ),
                          SizedBox(height: displaysize.height * .01),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
