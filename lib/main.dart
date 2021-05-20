import 'package:flutter/material.dart';
import './screens/objects_screen.dart';

void main() {
  runApp(MyApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

var currentDate = DateTime.now().day.toString() + "  May";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF007200)),
        //0xFF007200
        //0xFF007A00
        //0xFF217b43
        //0xFF46BE4D
        //0xFF1E6E3C
        //0xFF00622D
        //0xFFEF7E2F -orange
      ),
      home: MyHomePage(title: '$currentDate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void selectedPage(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return ObjectsScreen();
      },
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () => selectedPage(context),
            label: Text('1'),
            icon: Icon(Icons.access_alarm_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              width: 400,
              height: 20,
              child: LinearProgressIndicator(
                value: 2,
                valueColor: AlwaysStoppedAnimation(Color(0xFF3F0C51)),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'calendar_picker',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.black,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Главная',
            //water_damage_outlined
            //house_rounded
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            //assignment_outlined
            //fact_check_rounded
            //whatshot
            //local_fire_department
            //fireplace_rounded
            label: 'Заявки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu_rounded),
            //history
            //history_edu_rounded
            label: 'История',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded),

            //location_city_rounded
            label: 'Объекты',
          ),
        ],
      ),
    );
  }
}
