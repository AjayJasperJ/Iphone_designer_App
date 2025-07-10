//perfect
import 'package:dragable_app/app.dart';
import 'package:dragable_app/constants/icons.dart';
import 'package:dragable_app/constants/sizes.dart';
import 'package:dragable_app/widgets/txtfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(
                  CupertinoIcons.download_circle,
                  size: displaysize.height * .08,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: displaysize.height * .015),
                Txt(
                  'Astore',
                  size: sizes.displayLarge(context),
                  font: Font.medium,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            Txt(
              'Design the Future\nOne Tap at a Time',
              size: sizes.headlineMedium(context),
              align: TextAlign.center,
              height: 1.5,
              max: 2,
              font: Font.regular,
            ),
            Image.asset(icons.illust8, height: displaysize.height * .3),
            _CustomSlideToEnter(
              onComplete: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSlideToEnter extends StatefulWidget {
  final VoidCallback onComplete;
  const _CustomSlideToEnter({required this.onComplete});

  @override
  State<_CustomSlideToEnter> createState() => _CustomSlideToEnterState();
}

class _CustomSlideToEnterState extends State<_CustomSlideToEnter>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  late double _maxDrag;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          _dragPosition = _animation.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_completed) return;
    setState(() {
      _dragPosition += details.delta.dx;
      _dragPosition = _dragPosition.clamp(0.0, _maxDrag);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_completed) return;
    if (_dragPosition > _maxDrag * 0.92) {
      setState(() => _completed = true);
      _controller.animateTo(1.0, duration: Duration(milliseconds: 200));
      Future.delayed(Duration(milliseconds: 250), widget.onComplete);
    } else {
      _animation = Tween<double>(begin: _dragPosition, end: 0).animate(_controller);
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double trackWidth = MediaQuery.of(context).size.width * 0.82;
    final double trackHeight = displaysize.height * .07;
    final double thumbSize = displaysize.height * .06;
    _maxDrag = trackWidth - thumbSize - 4;
    return SizedBox(
      width: trackWidth,
      height: trackHeight,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: trackWidth,
            height: trackHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(trackHeight / 2),
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .1),
            ),
            child: Center(
              child: Txt(
                'Get Started',
                color: Theme.of(context).colorScheme.primary,
                font: Font.medium,
              ),
            ),
          ),
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: thumbSize,
                height: thumbSize,
                margin: EdgeInsets.all(thumbSize * .05),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
