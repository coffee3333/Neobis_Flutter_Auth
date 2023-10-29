import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardAwareWidget extends StatefulWidget {
  final Widget child;
  final bool onOpen;
  const KeyboardAwareWidget(
      {super.key, this.onOpen = false, required this.child});

  @override
  createState() => _KeyboardAwareWidgetState();
}

class _KeyboardAwareWidgetState extends State<KeyboardAwareWidget> {
  final KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();

  bool _isWidgetVisible = false;

  @override
  void initState() {
    super.initState();
    _keyboardVisibilityController.onChange.listen((bool isVisible) {
      setState(() {
        _isWidgetVisible = isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: widget.onOpen ? _isWidgetVisible : !_isWidgetVisible,
        child: widget.child,
      ),
    );
  }
}
