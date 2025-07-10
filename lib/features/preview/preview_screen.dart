import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/custom_iphone.dart';
import '../../models/placed_component.dart';

class PreviewScreen extends StatelessWidget {
  final CustomIphone customIphone;
  final int index;
  const PreviewScreen({super.key, required this.customIphone, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double phoneWidth = 220;
    double phoneHeight = 440;
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: displaysize.height * .06),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
              child: Row(
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
                          'Custom Design #$index',
                          font: Font.medium,
                          size: sizes.titleLarge(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: displaysize.height * .02),
            Center(
              child: Container(
                width: phoneWidth,
                height: phoneHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: theme.colorScheme.surface,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.all(48 * .18),
                        decoration: BoxDecoration(
                          border: Border.all(color: CupertinoColors.systemGrey, width: 3),
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            colors: [
                              customIphone.color.withOpacity(.8),
                              customIphone.color.withOpacity(.75),
                              customIphone.color.withOpacity(.5),
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            if (theme.brightness == Brightness.dark)
                              BoxShadow(color: theme.colorScheme.onSurface),
                          ],
                        ),
                      ),
                    ),
                    ...customIphone.components.asMap().entries.map((entry) {
                      final placed = entry.value;
                      final left = placed.position.dx;
                      final top = placed.position.dy;
                      final double? customRadius = placed.radius;
                      final Size? customSize = placed.size;
                      if (placed.type == ComponentType.expandableCamera) {
                        return Positioned(
                          left: left,
                          top: top,
                          child: _buildExpandableCameraWidget(
                            customSize ?? const Size(48, 48),
                            customRadius ?? 12.0,
                          ),
                        );
                      }
                      return Positioned(
                        left: left,
                        top: top,
                        child: _buildComponentIcon(
                          placed.type,
                          isDragging: false,
                          customRadius: customRadius ?? 0.0,
                          customSize: customSize,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: displaysize.height * .02),
                  Txt('Specifications', size: sizes.titleLarge(context), font: Font.medium),
                  SizedBox(height: displaysize.height * .03),
                  Column(
                    children: List.generate(5, (index) {
                      final fielddata = [
                        {'type': 'RAM', 'measure': 'GB', 'value': customIphone.ram},
                        {'type': 'Storage', 'measure': 'GB', 'value': customIphone.storage},
                        {'type': 'Screen Size', 'measure': '"', 'value': customIphone.screenSize},
                        {
                          'type': 'Camera MegaPixels',
                          'measure': 'MP',
                          'value': customIphone.cameraMp,
                        },
                        {'type': 'Battery', 'measure': 'mAh', 'value': customIphone.battery},
                      ];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Txt(fielddata[index]['type'].toString()),
                              Txt(
                                '${fielddata[index]['value']}${fielddata[index]['measure']}',
                                color: Theme.of(context).colorScheme.primary,
                                font: Font.medium,
                              ),
                            ],
                          ),
                          SizedBox(height: displaysize.height * .02),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: displaysize.height * .02),
                  Txt('Modules Used', size: sizes.titleLarge(context), font: Font.medium),
                  SizedBox(height: displaysize.height * .03),
                  // Only show modules that are present (count > 0)
                  Column(
                    children: [
                      ...[
                        {
                          'type': 'Camera',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.camera)
                              .length,
                        },
                        {
                          'type': 'Camera Module',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.expandableCamera)
                              .length,
                        },
                        {
                          'type': 'LiDar',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.lidarSensor)
                              .length,
                        },
                        {
                          'type': 'FlashLight',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.backFlashlight)
                              .length,
                        },
                        {
                          'type': 'Apple Logo',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.appleLogo)
                              .length,
                        },
                        {
                          'type': 'Power Button',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.powerButton)
                              .length,
                        },
                        {
                          'type': 'Volume Button',
                          'value': customIphone.components
                              .where((c) => c.type == ComponentType.volumeButton)
                              .length,
                        },
                      ].where((field) => (field['value'] as int) > 0).map((field) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(field['type'].toString()),
                                Txt(
                                  '${field['value']}',
                                  color: Theme.of(context).colorScheme.primary,
                                  font: Font.medium,
                                ),
                              ],
                            ),
                            SizedBox(height: displaysize.height * .02),
                          ],
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: displaysize.height * .01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentIcon(
    ComponentType type, {
    bool isDragging = false,
    double customRadius = 0,
    Size? customSize,
  }) {
    double size = isDragging ? 50 : 48;
    Color shadow = isDragging ? CupertinoColors.systemGrey3 : Colors.transparent;
    switch (type) {
      case ComponentType.camera:
        return Container(
          width: customRadius > 0 ? customRadius * 2 : size * .8,
          height: customRadius > 0 ? customRadius * 2 : size * .8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.black,
            boxShadow: [
              BoxShadow(
                color: isDragging ? CupertinoColors.systemGrey3 : Colors.black,
                offset: Offset(1, 3),
                blurRadius: 2,
              ),
            ],
            border: Border.all(color: CupertinoColors.systemGrey, width: 1.5),
          ),
          child: Center(
            child: Container(
              width: (customRadius > 0 ? customRadius : size * .4),
              height: (customRadius > 0 ? customRadius : size * .4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: customIphone.color.withValues(alpha: .2),
                border: Border.all(color: Colors.grey, width: 1.2),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.5),
                  radius: (customRadius > 0 ? customRadius * 0.13 : size * 0.05),
                ),
              ),
            ),
          ),
        );
      case ComponentType.powerButton:
        return Container(
          width: customSize?.width ?? size * 0.11,
          height: customSize?.height ?? size * 0.85,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey2,
            borderRadius: BorderRadius.circular(size),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          ),
        );
      case ComponentType.volumeButton:
        return Container(
          width: customSize?.width ?? size * 0.11,
          height: customSize?.height ?? size * 0.5,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey2,
            borderRadius: BorderRadius.circular(size),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          ),
        );
      case ComponentType.appleLogo:
        final double logoSize = customRadius > 0 ? customRadius : size * .8;
        return Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(boxShadow: [BoxShadow(color: shadow, blurRadius: 7)]),
          child: Center(
            child: Icon(
              Icons.apple,
              size: customRadius > 0 ? customRadius : size * .8,
              color: CupertinoColors.black,
            ),
          ),
        );
      case ComponentType.backFlashlight:
        return Container(
          width: customRadius > 0 ? customRadius * 2 : size * 0.4,
          height: customRadius > 0 ? customRadius * 2 : size * 0.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 231, 172).withOpacity(.9),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
          ),
          child: Center(
            child: CircleAvatar(radius: (customRadius > 0 ? customRadius * 0.13 : size * 0.05)),
          ),
        );
      case ComponentType.lidarSensor:
        return Container(
          width: customRadius > 0 ? customRadius * 2 : size * 0.3,
          height: customRadius > 0 ? customRadius * 2 : size * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.systemGrey2,
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 1.5),
          ),
        );
      case ComponentType.expandableCamera:
        return Container(
          width: customSize?.width ?? size * 0.8,
          height: customSize?.height ?? size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: CupertinoColors.black,
            borderRadius: BorderRadius.circular(customRadius > 0 ? customRadius : 12),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 3),
          ),
        );
    }
  }

  Widget _buildExpandableCameraWidget(
    Size camSize,
    double radius, {
    bool isDragging = false,
    VoidCallback? onTap,
  }) {
    Widget cam = Container(
      width: camSize.width,
      height: camSize.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: customIphone.color.withOpacity(0.5),
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
        boxShadow: [BoxShadow(blurRadius: 5, color: isDragging ? Colors.white : Colors.grey)],
      ),
    );
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: cam);
    }
    return cam;
  }
}
