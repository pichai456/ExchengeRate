import 'package:flutter/material.dart';
import 'package:learn/util/api_service.dart';
import 'models/ExchengeRate.dart';
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

  /* ------------------------------Input-------------------------------------------- */
  double _inputAmount = 1;

  @override
  void initState() {
    super.initState();
    _dataFormAPI = ApiException.getExchangeRate();
  }

  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              buildInput(size),
              buildShowAllExchengeRate(),
            ],
          ),
        ));
  }

  Container buildInput(double size) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
      width: size * 0.7,
      height: size * 0.1,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF6F00)),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF6F01)),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          hintText: 'กรุณากรอกตัวเลข',
          labelText: 'THB',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _inputAmount = double.parse(value);
          });
        },
      ),
    );
  }

  FutureBuilder<ExchengeRate> buildShowAllExchengeRate() {
    return FutureBuilder<ExchengeRate>(
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
        });
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
