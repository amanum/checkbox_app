import 'package:checkbox_app/custom_checkbox.dart';
import 'package:flutter/material.dart';

const minAnimationDuration = 200.0;
const maxAnimationDuration = 2000.0;

enum CheckBoxType {
  blue,
  green,
}

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({Key? key}) : super(key: key);

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage>
    with TickerProviderStateMixin {
  CheckBoxType selected = CheckBoxType.green;

  double _blueCheckboxFraction = 12.0;
  double _greenCheckboxFraction = 12.0;

  double _blueIconSize = 0;
  double _greenIconSize = 0;

  double sliderValue = minAnimationDuration;

  late Animation<double> blueBackAnimation;
  late AnimationController blueCheckboxController;
  late Animation<double> blueIconAnimation;

  late Animation<double> greenBackAnimation;
  late AnimationController greenCheckboxController;
  late Animation<double> greenIconAnimation;

  final Tween<double> _backTween = Tween(begin: 12, end: 0);
  final Tween<double> _iconTween = Tween(begin: 0, end: 20);

  @override
  void initState() {
    super.initState();
    blueCheckboxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: sliderValue.floor()),
    )..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        greenCheckboxController.reverse();
      }
    });

    greenCheckboxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: sliderValue.floor()),
    )..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        blueCheckboxController.reverse();
      }
    });

    blueBackAnimation = _backTween.animate(CurvedAnimation(
      parent: blueCheckboxController,
      curve: const Interval(0, 0.5),
    ))
      ..addListener(() {
        setState(() {
          _blueCheckboxFraction = blueBackAnimation.value;
        });
      });

    blueIconAnimation = _iconTween.animate(CurvedAnimation(
      parent: blueCheckboxController,
      curve: const Interval(0.5, 1)
    ))
      ..addListener(() {
        setState(() {
          _blueIconSize = blueIconAnimation.value;
        });
      });

    greenBackAnimation = _backTween.animate(CurvedAnimation(
      parent: greenCheckboxController,
      curve: const Interval(0, 0.5),
    ))
      ..addListener(() {
        setState(() {
          _greenCheckboxFraction = greenBackAnimation.value;
        });
      });

    greenIconAnimation = _iconTween.animate(CurvedAnimation(
      parent: greenCheckboxController,
      curve: const Interval(0.5, 1),
    ))
      ..addListener(() {
        setState(() {
          _greenIconSize = greenIconAnimation.value;
        });
      });
    greenCheckboxController.forward();
  }

  void onCheckboxClick(CheckBoxType type) {
    if (type != selected) {
      if (type == CheckBoxType.blue) {
        blueCheckboxController.forward();
      } else {
        greenCheckboxController.forward();
      }
      setState(() {
        selected = type;
      });
    }
  }

  void changeAnimationDuration(double? newVal) {
    if (newVal != null) {
      setState(() {
        sliderValue = newVal;
        blueCheckboxController.duration =
            Duration(milliseconds: sliderValue.floor());
        greenCheckboxController.duration =
            Duration(milliseconds: sliderValue.floor());
      });
    }
  }

  @override
  void dispose() {
    blueCheckboxController.dispose();
    greenCheckboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    onCheckboxClick(CheckBoxType.blue);
                  },
                  child: CustomCheckbox(
                    fraction: _blueCheckboxFraction,
                    color: Colors.blueAccent,
                    checkSize: _blueIconSize,
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    onCheckboxClick(CheckBoxType.green);
                  },
                  child: CustomCheckbox(
                    fraction: _greenCheckboxFraction,
                    color: Colors.green,
                    checkSize: _greenIconSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Animation duration'),
            Slider(
              value: sliderValue,
              onChanged: changeAnimationDuration,
              min: minAnimationDuration,
              max: maxAnimationDuration,
            ),
            Text('${sliderValue.floor()} ms')
          ],
        ),
      ),
    );
  }
}
