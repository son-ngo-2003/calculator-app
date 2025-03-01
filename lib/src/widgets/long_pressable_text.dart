import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LongPressableText extends StatefulWidget {
  const LongPressableText({super.key, required this.child});

  final Text child;

  @override
  State<LongPressableText> createState() => _LongPressableTextState();
}

class _LongPressableTextState extends State<LongPressableText> {
  late Offset tapPosition;

  void _setTapPosition(TapDownDetails details) {
    setState(() {
      tapPosition = details.globalPosition;
    });
  }

  void _showMenu(BuildContext context) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      position: RelativeRect.fromLTRB(tapPosition.dx, tapPosition.dy, overlay.size.width - tapPosition.dx, overlay.size.height - tapPosition.dy,),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
      items: [
        PopupMenuItem(
          value: 'copy',
          child: Center( child:  Text('Copy', textAlign: TextAlign.center,)),
        ),
      ],
    );

    if (result == 'copy') {
      Clipboard.setData(ClipboardData(text: widget.child.data ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTapDown: (details) {
        _setTapPosition(details);
      },
      onLongPress: () {
        _showMenu(context);
      },
    );
  }
}