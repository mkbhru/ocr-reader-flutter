import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon App',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'OCR & Barcode Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isInitial = false;

  void _scanBarcode() async {
    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        waitTap: true,
        showText: true,
      );
      if (barcodes.length > 0) {
        for (Barcode barcode in barcodes) {
          print(
              'barcodevalueis ${barcode.displayValue} ${barcode.getFormatString()} ${barcode.getValueFormatString()}');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // int _counter = 0;
  bool isInitialized = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitialized = true;
      setState(() {
        isInitial = true;
      });
    });
    super.initState();
  }

  _startScan() async {
    List<OcrText> list = [];
    try {
      list = await FlutterMobileVision.read(
        waitTap: true,
        fps: 10.0,
      );
      for (OcrText text in list) {
        print('valueis ${text.value}');
      }
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Card(
        color: Colors.grey[350],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome To OCR Reader',
                style: TextStyle(fontSize: 30),

              ),
              //         floatingActionButton: FloatingActionButton(
              //   onPressed: _startScan,
              //   tooltip: 'Increment',
              //   child: Icon(Icons.find_in_page),
              // ),
              ElevatedButton(
                onPressed: _startScan,
                child: Icon(Icons.find_in_page),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: _scanBarcode,
              //   tooltip: 'Increment',
              //   child: Icon(Icons.find_in_page),
              // ),
              ElevatedButton(
                onPressed: _scanBarcode,
                child: Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _app,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.find_in_page),
      // ),
    );
  }
}
