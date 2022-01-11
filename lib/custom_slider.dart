import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

final int overlapDistance = -13; // distance of overlaping between text and slider

class CustomSliderWithTextField extends StatefulWidget {
  final Function(dynamic) callback;
  final List<double> sizes;
  const CustomSliderWithTextField({Key? key, required this.sizes, required this.callback}) : super(key: key);
  @override
  _CustomSliderState createState() => _CustomSliderState(sizes, callback);


}

class _CustomSliderState extends State {
  TextEditingController txtController  = new TextEditingController();
  List<double> sizes;
  double values = 0;
  Function(dynamic) callback;
  _CustomSliderState( this.sizes, this.callback){
    values = sizes[0];
    txtController.text = values.toString() + " см";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: ColumnSuper(
        innerDistance: -13,
        children: [
          TextField(
            controller: txtController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(236, 239, 241, 1),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(36.0)),
                borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(36.0)),
                borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
              ),
            ),
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
              overlayRadius: 0,
            ),
            child: Container(
              child: SfSlider(
                min: sizes[0],
                max: sizes[1],
                value: values,
                stepSize: 10.0,
                showTicks: false,
                showLabels: false,
                enableTooltip: false,
                thumbShape: _SfThumbShape(),
                trackShape: CustomTrackShape(),
                activeColor: Color.fromRGBO(0, 99, 147, 1),
                inactiveColor: Colors.transparent,
                onChanged: (value) {
                  setState(() {
                    values = value;
                    txtController.text = values.toString() + " см";
                    callback(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SfThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    final Path path = Path();

    path.moveTo(center.dx, center.dy);
    path.lineTo(center.dx + 8, center.dy + 10);
    path.lineTo(center.dx + 8, center.dy + 25);
    path.lineTo(center.dx - 8, center.dy + 25);
    path.lineTo(center.dx - 8, center.dy + 10);
    path.close();
    context.canvas.drawPath(
        path,
        Paint()
          ..color = themeData.activeTrackColor!
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);
  }
}

class CustomTrackShape extends SfTrackShape {
  final left = 12;
  final right = 12;
  final height = 5;
  final delta = 5; // depends of the radius (should be modified in future)
  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Animation<double> enableAnimation,
        required Paint? inactivePaint,
        required Paint? activePaint,
        required TextDirection textDirection}) {
    final Path path = Path();
    path.moveTo(offset.dx + left, offset.dy);
    if (thumbCenter!.dx >= offset.dx + left){ //check for position at top right point
      if (thumbCenter.dx < offset.dx + parentBox.size.width - right - delta){ // if in middle position
        path.lineTo(thumbCenter.dx, offset.dy);
        path.lineTo(thumbCenter.dx, offset.dy + height);
        path.lineTo(offset.dx + left + delta, offset.dy + height);
        path.moveTo(offset.dx + left, offset.dy);
      }
      else{ // in the full right pos
        path.lineTo(thumbCenter.dx, offset.dy);
        path.lineTo(thumbCenter.dx - delta, offset.dy + height);
        path.lineTo(offset.dx + left + delta, offset.dy + height);
        path.moveTo(offset.dx + left, offset.dy);
      }
    }
    /*
    else{
      path.lineTo(offset.dx + left, offset.dy);
      path.lineTo(offset.dx + left + delta, offset.dy + height);
      path.moveTo(offset.dx + left, offset.dy);
    }
     */
    path.close();
    context.canvas.drawPath(
        path,
        Paint()
          ..color = themeData.activeTrackColor!
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);

  }
}