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
      title: "Hackathon App",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'All-In-One Reader'),
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
  // List<String> data = [
  //   "hello",
  // ];
  String name = "Your selected Text Will Appear here :)";

  void _scanBarcode() async {
    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        waitTap: true,
        // showText: true,
      );
      if (barcodes.length > 0) {
        for (Barcode barcode in barcodes) {
          print(
              'barcodevalueis ${barcode.displayValue} ${barcode.getFormatString()} ${barcode.getValueFormatString()}');
          setState(() {
            name = barcode.displayValue;
          });
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
        fps: 5.0,
      );
      for (OcrText text in list) {
        print('valueis ${text.value}');
        setState(() {
          name = text.value;
        });
        // data.add(text.value);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "OCR Reader ->",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: _startScan,
                      child: Icon(Icons.find_in_page),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "QR & Barcode Scanner ->",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: _scanBarcode,
                      child: Icon(Icons.qr_code),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Long Press to copy :)"),
          ),
          //         onTap: () {
          // Clipboard.setData(ClipboardData(text: name));
// },

          // ListView(
          //   children: [Text(data.first)],
          // )
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _app,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.find_in_page),
      // ),
    );
  }
}
