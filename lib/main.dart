import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchengeRate.dart';
import 'MoneyBox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Home(),
      theme: ThemeData(primaryColor: Colors.amber[700]),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

@override
class _HomeState extends State<Home> {
  /* ------------------------------API-------------------------------------------- */
  late Future<ExchengeRate> _dataFormAPI;

  /* -----------------------------โหลดข้อมูล--------------------------------------------- */
  // ScrollController _sc = new ScrollController();
  // static int _page = 0;
  // bool isLoading = false;

  /* ------------------------------Input-------------------------------------------- */
  double _inputAmount = 1;

  @override
  void initState() {
    super.initState();
    _dataFormAPI = getExchangeRate();
    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
    //     _getMoreData(_page);
    //   }
    // });
  }

  // void _getMoreData(int index) {
  //   if (!isLoading) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  // }

  Future<ExchengeRate> getExchangeRate() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    final response = await http.get(url);
    return ExchengeRate.fromJson(jsonDecode(response.body));
  }

  @override
  void dispose() {
    super.dispose();
    // _sc.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text(
              'แปลงสกุลเงิน',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'กรุณากรอกตัวเลข', labelText: 'THB', border: InputBorder.none),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _inputAmount = double.parse(value);
                  });
                },
              ),
            ),
            FutureBuilder<ExchengeRate>(
                future: _dataFormAPI,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  // ----------------------------------ถ้าดึงข้อมูลมาครบ---------------------------------------- */
                  if (snapshot.hasData) {
                    var _resultRate = snapshot.data.rates;
                    return widgetContext(_resultRate);
                  }
                  // --------------------------------ถ้ายังดึงไม่ครบ ------------------------------------------ */
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const LinearProgressIndicator();
                }),
          ],
        ));
  }

  Expanded widgetContext(_resultRate) {
    return Expanded(
      child: Scrollbar(
        showTrackOnHover: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _resultRate.length,
          itemBuilder: (BuildContext context, int index) {
            String _key = _resultRate.keys.elementAt(index);
            double _val = double.parse('${_resultRate[_key]}');
            return MoneyBox(_key, _val * _inputAmount, Colors.orange, 100);
          },
        ),
      ),
    );
  }
}
