import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paintom1/painting_model.dart';

class PaintPage extends StatefulWidget {
  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  Offset pos = Offset(0, 0);
  static List<Offset> listPos = <Offset>[];
  static Color color = Colors.black;
  static List<Color> listColor = <Color>[color];
  static double brushSize = 5;
  static List<double> listBrushSize = <double>[brushSize];

  PaintModel paintModel = PaintModel(
      listBrushSize: listBrushSize, listColor: listColor, listPos: listPos);
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paint Room'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).primaryColorDark,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    RenderBox box = context.findRenderObject();
                    pos = box.globalToLocal(details.globalPosition);
                    listPos = List.from(listPos)..add(pos);
                    listColor = List.from(listColor)..add(color);
                    listBrushSize = List.from(listBrushSize)..add(brushSize);
                  });
                },
                onPanStart: (DragStartDetails details) {
                  setState(() {
                    RenderBox box = context.findRenderObject();
                    pos = box.globalToLocal(details.globalPosition);
                    listPos = List.from(listPos)..add(pos);
                    listColor = List.from(listColor)..add(color);
                    listBrushSize = List.from(listBrushSize)..add(brushSize);
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {
                    listPos = List.from(listPos)..add(null);
                  });
                },
                child: Container(
                  child: CustomPaint(
                    painter: Draw(
                        listPos: listPos,
                        listColor: listColor,
                        listBrushSize: listBrushSize),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.arrow_drop_down),
        onPressed: () {
          setState(() {
            showModalBottomSheet(
                isDismissible: true,
                backgroundColor: Colors.white10,
                context: context,
                builder: bottomSheetWidget);
          });
        },
      ),
    );
  }

  Widget bottomSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Theme.of(context).primaryColorDark,
          border: Border.all(width: 2),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.brush,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  color = Colors.black;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.brush,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  color = Colors.blue[600];
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.brush,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                setState(() {
                  color = Colors.deepPurple[900];
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.brightness_1,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  brushSize = 10;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.brightness_1,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                setState(() {
                  brushSize = 20;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                setState(() {
                  pos = Offset(0, 0);
                  listPos = <Offset>[];

                  color = Colors.black;
                  listColor = <Color>[color];

                  brushSize = 5;
                  listBrushSize = <double>[brushSize];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Draw extends CustomPainter {
  final List<Offset> listPos;
  final List<Color> listColor;
  final List<double> listBrushSize;

  Draw({this.listPos, this.listColor, this.listBrushSize});

  @override
  void paint(Canvas canvas, Size size) {
    //Circule
    final paint = Paint();
    paint.color = Colors.black;
    paint.isAntiAlias = true;
    paint.strokeCap = StrokeCap.round;

    //var c = Offset(size.width/2  , size.height/2);
//    for (int i = 0; i < listPos.length; i++) {
//      paint.color = listColor[i];
//      canvas.drawCircle(listPos[i], listBrushSize[i], paint);
//    }

    for (int i = 0; i < listPos.length; i++) {
      paint.strokeWidth = listBrushSize[i];
      if (listPos[i] != null && listPos[i + 1] != null) {
        canvas.drawLine(listPos[i], listPos[i + 1], paint);
      }
    }
    // //Rectangel
    // var rect  = Rect.fromLTWH(size.width/3 , size.height/2 , 135, 200);
    // paint.color = Colors.deepPurple;
    // canvas.drawRect(rect , paint);

    // //Line
    // paint.color = Colors.blueAccent;
    // paint.strokeWidth = 20;
    // var p1 = Offset( 0 , 500);
    // var p2 = Offset(size.width/2 , size.height/2);
    // canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(Draw old) {
    return old.listPos != listPos;
  }
}
