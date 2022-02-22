import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FFButtonOptions {
  FFButtonOptions(
      {required this.textStyle,
      required this.height,
      required this.width,
      required this.color,
      required this.borderRadius,
      required this.borderSide});

  final TextStyle textStyle;
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final BorderSide borderSide;
}

class FFButtonWidget extends StatefulWidget {
  FFButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    IconData? iconData,
    required this.options,
    this.showLoadingIndicator = true,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final FFButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<FFButtonWidget> createState() => _FFButtonWidgetState();
}

class _FFButtonWidgetState extends State<FFButtonWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: widget.options.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } catch (e) {
              print('On pressed error:\n$e');
            }
            setState(() => loading = false);
          }
        : () => widget.onPressed();

    return Container(
      height: widget.options.height,
      width: widget.options.width,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.options.borderRadius),
          side: widget.options.borderSide,
        ),
        textColor: widget.options.textStyle.color,
        color: widget.options.color,
        colorBrightness:
            ThemeData.estimateBrightnessForColor(widget.options.color),
        child: textWidget,
      ),
    );
  }
}
