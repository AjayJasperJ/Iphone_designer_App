import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/providers/custom_iphone_provider.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/placed_component.dart';
import '../../models/custom_iphone.dart';
class CreateIphoneScreen extends StatefulWidget {
  const CreateIphoneScreen({super.key});

  @override
  State<CreateIphoneScreen> createState() => _CreateIphoneScreenState();
}

class _CreateIphoneScreenState extends State<CreateIphoneScreen> {
  // --- State ---
  final List<PlacedComponent> _placedComponents = [];
  int _ram = 4;
  int _storage = 64;
  double _screenSize = 6.1;
  int _cameraMp = 12;
  int _battery = 3000;
  Color _color = CupertinoColors.systemGrey4;
  final double phoneWidth = 220;
  final double phoneHeight = 440;
  final GlobalKey _phoneKey = GlobalKey();
  int? _draggingPlacedIndex;
  IconData? _draggingIcon;
  Offset? _dragOffset;
  final Map<int, Size> _expandableCameraSizes = {};
  final Map<int, double> _expandableCameraRadius = {};
  final Map<int, double> _componentRadius = {}; // id -> radius
  int _nextComponentId = 0;

  // --- Helper: Generate unique id for each component ---
  int _generateComponentId() => _nextComponentId++;

  // --- Publish logic (unchanged) ---
  void _publish() async {
    final provider = Provider.of<CustomIphoneProvider>(context, listen: false);
    // Build a new list of PlacedComponent with correct radius/size for each
    final List<PlacedComponent> componentsToSave = _placedComponents.map((placed) {
      double? radius;
      Size? size;
      switch (placed.type) {
        case ComponentType.camera:
        case ComponentType.backFlashlight:
        case ComponentType.lidarSensor:
          radius = _componentRadius[placed.id] ?? 24.0;
          break;
        case ComponentType.appleLogo:
          radius = _componentRadius[placed.id] ?? 48.0;
          break;
        case ComponentType.expandableCamera:
          radius = _expandableCameraRadius[placed.id] ?? 12.0;
          size = _expandableCameraSizes[placed.id] ?? const Size(48, 48);
          break;
        case ComponentType.powerButton:
        case ComponentType.volumeButton:
          // If you support resizing these, add logic here
          break;
      }
      return PlacedComponent(
        id: placed.id,
        type: placed.type,
        position: placed.position,
        radius: radius,
        size: size,
      );
    }).toList();

    final iphone = CustomIphone(
      components: componentsToSave,
      ram: _ram,
      storage: _storage,
      screenSize: _screenSize,
      cameraMp: _cameraMp,
      battery: _battery,
      color: _color,
    );
    await provider.addIphone(iphone);
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Published!'),
        content: const Text('Your custom iPhone has been saved.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: displaysize.height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displaysize.height * .02),
              Center(
                child: Txt(
                  'Design your own iPhone',
                  font: Font.medium,
                  size: sizes.titleLarge(context),
                ),
              ),
              SizedBox(height: displaysize.height * .02),
              /*  Phone Display Area */
              Center(
                child: DragTarget<PlacedComponent>(
                  onWillAcceptWithDetails: (data) => true,
                  onAcceptWithDetails: (details) {
                    final RenderBox box = _phoneKey.currentContext!.findRenderObject() as RenderBox;
                    final Offset local = box.globalToLocal(details.offset);
                    // Offset by -25 on y to match feedback offset
                    final Offset adjusted = Offset(local.dx, local.dy - 25);
                    setState(() {
                      if (_draggingPlacedIndex == null) {
                        // New component from palette
                        final newId = _generateComponentId();
                        final newComponent = PlacedComponent(
                          id: newId,
                          type: details.data.type,
                          position: adjusted,
                        );
                        _placedComponents.add(newComponent);
                        double? initialR;
                        if (details.data.type == ComponentType.camera) initialR = 20.0;
                        if (details.data.type == ComponentType.backFlashlight) initialR = 10.0;
                        if (details.data.type == ComponentType.lidarSensor) initialR = 8.0;
                        if (initialR != null) _componentRadius[newId] = initialR;
                      } else {
                        // Move the existing component
                        final old = _placedComponents[_draggingPlacedIndex!];
                        _placedComponents[_draggingPlacedIndex!] = PlacedComponent(
                          id: old.id,
                          type: old.type,
                          position: adjusted,
                        );
                        _draggingPlacedIndex = null;
                      }
                      _draggingIcon = null;
                      _dragOffset = null;
                    });
                  },
                  builder: (context, candidate, rejected) {
                    return Container(
                      key: _phoneKey,
                      width: phoneWidth,
                      height: phoneHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: theme.colorScheme.surface,
                        boxShadow: [],
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
                                    _color.withOpacity(.8),
                                    _color.withOpacity(.75),
                                    _color.withOpacity(.5),
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
                          ..._placedComponents.asMap().entries.map((entry) {
                            final index = entry.key;
                            final placed = entry.value;
                            final left = placed.position.dx;
                            final top = placed.position.dy;
                            Widget child;
                            if (placed.type == ComponentType.camera ||
                                placed.type == ComponentType.backFlashlight ||
                                placed.type == ComponentType.lidarSensor) {
                              final radius = _componentRadius[placed.id] ?? 24.0;
                              child = GestureDetector(
                                onTap: () async {
                                  double newRadius = radius;
                                  await showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      title: Text('Resize ${placed.type.name}'),
                                      message: StatefulBuilder(
                                        builder: (context, setSheetState) => Column(
                                          children: [
                                            Text('Radius: ${newRadius.toStringAsFixed(0)} px'),
                                            CupertinoSlider(
                                              value: newRadius,
                                              min: 8,
                                              max: phoneWidth / 2,
                                              onChanged: (v) {
                                                setSheetState(() => newRadius = v);
                                                setState(() => _componentRadius[placed.id] = v);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      cancelButton: CupertinoActionSheetAction(
                                        child: const Text('Done'),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                  );
                                },
                                child: _buildComponentIcon(placed.type, customRadius: radius),
                              );
                            }
                            else if (placed.type == ComponentType.appleLogo) {
                              final height = _componentRadius[placed.id] ?? 48.0;
                              child = GestureDetector(
                                onTap: () async {
                                  double newHeight = height;
                                  await showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      title: const Text('Resize Apple Logo'),
                                      message: StatefulBuilder(
                                        builder: (context, setSheetState) => Column(
                                          children: [
                                            Text('Height: ${newHeight.toStringAsFixed(0)} px'),
                                            CupertinoSlider(
                                              value: newHeight,
                                              min: 24,
                                              max: phoneHeight,
                                              onChanged: (v) {
                                                setSheetState(() => newHeight = v);
                                                setState(() => _componentRadius[placed.id] = v);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      cancelButton: CupertinoActionSheetAction(
                                        child: const Text('Done'),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: height,
                                  height: height,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CupertinoColors.transparent,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.apple,
                                      size: height,
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                            else if (placed.type == ComponentType.expandableCamera) {
                              final camSize =
                                  _expandableCameraSizes[placed.id] ?? const Size(48, 48);
                              final camRadius = _expandableCameraRadius[placed.id] ?? 12.0;
                              child = GestureDetector(
                                onTap: () async {
                                  double newRadius = camRadius;
                                  Size newSize = camSize;
                                  await showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      title: const Text('Resize Expandable Camera'),
                                      message: StatefulBuilder(
                                        builder: (context, setSheetState) => Column(
                                          children: [
                                            Text('Radius: ${newRadius.toStringAsFixed(0)} px'),
                                            CupertinoSlider(
                                              value: newRadius,
                                              min: 8,
                                              max: phoneWidth / 2,
                                              onChanged: (v) {
                                                setSheetState(() => newRadius = v);
                                                setState(
                                                  () => _expandableCameraRadius[placed.id] = v,
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            Text('Width: ${newSize.width.toStringAsFixed(0)} px'),
                                            CupertinoSlider(
                                              value: newSize.width,
                                              min: 24,
                                              max: phoneWidth,
                                              onChanged: (v) {
                                                setSheetState(
                                                  () => newSize = Size(v, newSize.height),
                                                );
                                                setState(
                                                  () => _expandableCameraSizes[placed.id] = Size(
                                                    v,
                                                    newSize.height,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            Text('Height: ${newSize.height.toStringAsFixed(0)} px'),
                                            CupertinoSlider(
                                              value: newSize.height,
                                              min: 20,
                                              max: phoneHeight,
                                              onChanged: (v) {
                                                setSheetState(
                                                  () => newSize = Size(newSize.width, v),
                                                );
                                                setState(
                                                  () => _expandableCameraSizes[placed.id] = Size(
                                                    newSize.width,
                                                    v,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      cancelButton: CupertinoActionSheetAction(
                                        child: const Text('Done'),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                  );
                                },
                                child: _buildExpandableCameraWidget(camSize, camRadius),
                              );
                            } else {
                              child = _buildComponentIcon(placed.type);
                            }
                            return Positioned(
                              left: left,
                              top: top,
                              child: Draggable<PlacedComponent>(
                                data: placed,
                                feedback: Transform.translate(
                                  offset: const Offset(0, -25),
                                  child: Material(color: Colors.transparent, child: child),
                                ),
                                childWhenDragging: const SizedBox.shrink(),
                                onDragStarted: () {
                                  setState(() {
                                    _draggingPlacedIndex = index;
                                  });
                                },
                                onDraggableCanceled: (_, __) {
                                  setState(() {
                                    _draggingPlacedIndex = null;
                                  });
                                },
                                onDragEnd: (_) {
                                  setState(() {
                                    _draggingPlacedIndex = null;
                                  });
                                },
                                child: child,
                              ),
                            );
                          }),
                          if (_draggingPlacedIndex != null || _draggingIcon != null)
                            Positioned(
                              bottom: 32,
                              right: 32,
                              child: DragTarget<PlacedComponent>(
                                onWillAcceptWithDetails: (data) => true,
                                onAcceptWithDetails: (data) {
                                  setState(() {
                                    if (_draggingPlacedIndex != null) {
                                      _placedComponents.removeAt(_draggingPlacedIndex!);
                                      _draggingPlacedIndex = null;
                                      _draggingIcon = null;
                                      _dragOffset = null;
                                    }
                                  });
                                },
                                builder: (context, candidate, rejected) {
                                  final isActive = candidate.isNotEmpty;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? CupertinoColors.destructiveRed.withOpacity(0.9)
                                          : CupertinoColors.systemGrey5.withOpacity(0.85),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: isActive
                                              ? CupertinoColors.destructiveRed.withOpacity(0.3)
                                              : CupertinoColors.systemGrey3.withOpacity(0.18),
                                          blurRadius: 16,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: isActive
                                          ? CupertinoColors.white
                                          : CupertinoColors.destructiveRed,
                                      size: 38,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: displaysize.height * .02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
                child: Txt(
                  'Customizable Widgets',
                  font: Font.medium,
                  size: sizes.titleLarge(context),
                ),
              ),
              SizedBox(height: displaysize.height * .02),
              /* Tools Palette */
              SizedBox(
                // height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildToolDraggable(ComponentType.camera, 'Camera'),
                      _buildToolDraggable(ComponentType.powerButton, 'Power'),
                      _buildToolDraggable(ComponentType.volumeButton, 'Volume'),
                      _buildToolDraggable(ComponentType.appleLogo, 'Logo'),
                      _buildToolDraggable(ComponentType.backFlashlight, 'Flashlight'),
                      _buildToolDraggable(ComponentType.lidarSensor, 'LiDAR'),
                      _buildToolDraggable(ComponentType.expandableCamera, 'Camera Module'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: displaysize.height * .02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: displaysize.height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt('Configuration', font: Font.medium, size: sizes.titleLarge(context)),
                    SizedBox(height: displaysize.height * .02),
                    // Spec Inputs
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Txt('RAM'),
                            const Spacer(),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Txt(
                                '$_ram GB',
                                font: Font.medium,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () async {
                                final int? picked = await showCupertinoModalPopup<int>(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    title: const Txt('Select RAM'),
                                    actions: [
                                      for (final ram in [4, 6, 8, 12])
                                        CupertinoActionSheetAction(
                                          child: Text('$ram GB'),
                                          onPressed: () => Navigator.of(context).pop(ram),
                                        ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ),
                                );
                                if (picked != null) setState(() => _ram = picked);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .01),
                        Row(
                          children: [
                            const Txt('Storage'),
                            const Spacer(),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Txt(
                                _storage >= 1024 ? '1TB' : '$_storage GB',
                                font: Font.medium,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () async {
                                final int? picked = await showCupertinoModalPopup<int>(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    title: const Text('Select Storage'),
                                    actions: [
                                      for (final storage in [64, 128, 256, 512, 1024])
                                        CupertinoActionSheetAction(
                                          child: Text(storage == 1024 ? '1TB' : '$storage GB'),
                                          onPressed: () => Navigator.of(context).pop(storage),
                                        ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ),
                                );
                                if (picked != null) setState(() => _storage = picked);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Txt('Screen Size'),
                              ),
                            ),

                            SizedBox(
                              width: displaysize.width * .4,
                              child: CupertinoSlider(
                                value: _screenSize.toDouble(),
                                min: 5.4,
                                max: 7.0,
                                divisions: 16,
                                onChanged: (v) => setState(
                                  () => _screenSize = double.parse(v.toStringAsFixed(2)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Txt(
                                  '${_screenSize.toStringAsFixed(1)}"',
                                  color: theme.colorScheme.primary,
                                  font: Font.medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Txt('Camera MP'),
                              ),
                            ),

                            SizedBox(
                              width: displaysize.width * .4,
                              child: CupertinoSlider(
                                value: _cameraMp.toDouble(),
                                min: 8,
                                max: 108,
                                divisions: 20,
                                onChanged: (v) => setState(() => _cameraMp = v.round()),
                              ),
                            ),
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Txt(
                                  '${_cameraMp}MP',
                                  color: theme.colorScheme.primary,
                                  font: Font.medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(alignment: Alignment.centerLeft, child: Txt('Battery')),
                            ),

                            SizedBox(
                              width: displaysize.width * .4,
                              child: CupertinoSlider(
                                value: _battery.toDouble(),
                                min: 2000,
                                max: 6000,
                                divisions: 20,
                                onChanged: (v) => setState(() => _battery = v.round()),
                              ),
                            ),
                            SizedBox(
                              width: displaysize.width * .23,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Txt(
                                  '${_battery}mAh',
                                  color: theme.colorScheme.primary,
                                  font: Font.medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: displaysize.height * .02),
                        Row(
                          children: [
                            const Txt('Color'),
                            const Spacer(),
                            Row(
                              children: [
                                for (final color in [
                                  Colors.black,
                                  const Color.fromARGB(255, 4, 20, 51),
                                  const Color.fromARGB(255, 179, 0, 59),
                                  Colors.grey.shade200,
                                  const Color.fromARGB(255, 5, 39, 6),
                                  const Color.fromARGB(255, 224, 202, 0),
                                ])
                                  GestureDetector(
                                    onTap: () => setState(() => _color = color),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      width: displaysize.width * .08,
                                      height: displaysize.width * .08,
                                      decoration: BoxDecoration(
                                        color: color,
                                        border: Border.all(
                                          color: _color == color
                                              ? theme.colorScheme.primary
                                              : Colors.grey,
                                          width: _color == color ? 2.5 : 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: displaysize.height * .02),
                    SizedBox(
                      height: displaysize.height * .06,
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: _publish,
                        child: Center(
                          child: Txt(
                            "Publish",
                            font: Font.semiBold,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolDraggable(ComponentType type, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displaysize.height * .02,
        vertical: displaysize.height * .01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: displaysize.height * .06,
            width: displaysize.height * .06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: Center(
              child: Draggable<PlacedComponent>(
                data: PlacedComponent(id: -1, type: type, position: Offset.zero),
                feedback: Material(
                  color: Colors.transparent,
                  child: _buildComponentIcon(type, isDragging: true),
                ),
                childWhenDragging: Opacity(opacity: 0.5, child: _buildComponentIcon(type)),
                child: _buildComponentIcon(type),
                onDragStarted: () {
                  setState(() {
                    _draggingIcon = _iconForType(type);
                  });
                },
                onDraggableCanceled: (_, __) {
                  setState(() {
                    _draggingIcon = null;
                    _dragOffset = null;
                  });
                },
                onDragEnd: (details) {
                  setState(() {
                    _draggingIcon = null;
                    _dragOffset = null;
                  });
                },
                onDragUpdate: (details) {
                  setState(() {
                    _dragOffset = details.globalPosition;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: displaysize.height * .02),
          Txt(label, size: sizes.bodySmall(context)),
        ],
      ),
    );
  }

  Widget _buildComponentIcon(
    ComponentType type, {
    bool isDragging = false,
    double customRadius = 0,
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
                color: _color.withValues(alpha: .2),
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
          width: size * 0.11,
          height: size * 0.85,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey2,
            borderRadius: BorderRadius.circular(size),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          ),
        );
      case ComponentType.volumeButton:
        return Container(
          width: size * 0.11,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey2,
            borderRadius: BorderRadius.circular(size),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 1),
          ),
        );
      case ComponentType.appleLogo:
        return Container(
          width: size * .8,
          height: size * .8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.white,
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
          ),
          child: Center(
            child: Icon(Icons.apple, size: size * .8, color: CupertinoColors.black),
          ),
        );
      case ComponentType.backFlashlight:
        return Container(
          width: customRadius > 0 ? customRadius * 2 : size * 0.4,
          height: customRadius > 0 ? customRadius * 2 : size * 0.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 231, 172).withOpacity(.9),
            boxShadow: [
              BoxShadow(
                color: isDragging ? CupertinoColors.systemGrey3 : Colors.black,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
          ),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: (customRadius > 0 ? customRadius * 0.13 : size * 0.05),
            ),
          ),
        );
      case ComponentType.lidarSensor:
        return Container(
          width: customRadius > 0 ? customRadius * 2 : size * 0.3,
          height: customRadius > 0 ? customRadius * 2 : size * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.systemGrey2,
            boxShadow: [
              BoxShadow(
                color: isDragging ? CupertinoColors.systemGrey3 : Colors.black,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 1.5),
          ),
        );
      case ComponentType.expandableCamera:
        return Container(
          width: size * 0.8,
          height: size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: CupertinoColors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: shadow, blurRadius: 7)],
            border: Border.all(color: CupertinoColors.systemGrey, width: 3),
          ),
        );
    }
  }

  // Helper widget for expandable camera
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
        color: _color.withOpacity(0.5),
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
        boxShadow: [BoxShadow(blurRadius: 5, color: isDragging ? Colors.white : Colors.grey)],
      ),
    );
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: cam);
    }
    return cam;
  }

  IconData _iconForType(ComponentType type) {
    switch (type) {
      case ComponentType.camera:
        return Icons.camera_alt;
      case ComponentType.powerButton:
        return Icons.power;
      case ComponentType.volumeButton:
        return Icons.volume_up;
      case ComponentType.appleLogo:
        return Icons.apple;
      case ComponentType.backFlashlight:
        return Icons.flash_on;
      case ComponentType.lidarSensor:
        return Icons.blur_circular;
      case ComponentType.expandableCamera:
        return Icons.open_in_full;
    }
  }
}
