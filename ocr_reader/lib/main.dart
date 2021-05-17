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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'OCR Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Card(
        color: Colors.grey,
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
