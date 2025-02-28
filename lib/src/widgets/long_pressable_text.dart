import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LongPressableText extends StatelessWidget {
  const LongPressableText({super.key, required this.child});

  final Text child;

  void _showMenu(BuildContext context, TapDownDetails details) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset tapPosition = details.globalPosition;

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
      Clipboard.setData(ClipboardData(text: child.data ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTapDown: (details) {
        _showMenu(context, details);
      },
    );
  }
}