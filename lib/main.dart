import 'package:job/Model.dart';
import 'Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 40.0),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
        ).apply(
          bodyColor: Colors.black45,
          displayColor: Colors.red,
        ),
      ),
      home: MyHomePage(title: 'ข้อมูลการวัด'),
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
  int _counter = 0;
  Data mydata = Data();

  Future<List<DataModels>> fetchMyModel() async {
    var data = mydata.measureList;
    List<DataModels> ui = data.map((ui) => DataModels.fromJson(ui)).cast<DataModels>().toList();
    print(ui);
    return ui;
  }

  void initState() {
    fetchMyModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppbar,
      backgroundColor: Color(0xffDCDCDC),
      body:FutureBuilder<List<DataModels>>(
        future: fetchMyModel(),
        builder: (BuildContext context, AsyncSnapshot<List<DataModels>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(padding: const EdgeInsets.symmetric(horizontal: 10 ),
                    child: Card(
                      child: myBox(
                        snapshot.data[index].iconUrl,
                        snapshot.data[index].titleName,
                        snapshot.data[index].value,
                        snapshot.data[index].desireable,
                        snapshot.data[index].target,
                        snapshot.data[index].different,
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget myBox(icon, title, value, des, taget, different) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Icon(Icons.image,size: 30,),
                    backgroundColor: Colors.tealAccent,

                  ),
                  Text('$title',style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                  Icon(Icons.info_outline),
                ],
              ),
              Text('$value',style: TextStyle(color: Colors.orange,fontSize: 28,fontWeight: FontWeight.bold))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('ค่าที่เหมาะสม'),
              Text('เป้าหมาย'),
              Text('แตกต่าง'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('$des',style: TextStyle(fontWeight: FontWeight.bold)),
              Text((taget==null)?' - ':'$taget' ,style: TextStyle(fontWeight: FontWeight.bold)),
              Text((different==null)?' - ':'$different' ,style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget setAppbar = AppBar(
    backgroundColor: Colors.blue,
    centerTitle: true,
    title: Text('ข้อมูลการวัด',style: TextStyle(fontWeight: FontWeight.bold)),
    actions: [
      IconButton(
          icon: Icon(
            Icons.screen_share_outlined,
            color: Colors.white,
          ),
          onPressed: null)
    ],
  );
}
