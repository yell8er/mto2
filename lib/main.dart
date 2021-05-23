import 'package:flutter/material.dart';
import './screens/objects_screen.dart';
import './screens/service_requests_screen.dart';
import './screens/tabs_screen.dart';
import './helpers/material_color_creator.dart';

void main() {
  runApp(MyApp());
}

// var currentDate = DateTime.now().day.toString() + "  May";

class MyApp extends StatelessWidget {
  void selectedPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/objects');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF2F4F4F)),
        //0xFF007200-main
        //0xFF007A00
        //0xFF217b43
        //0xFF46BE4D
        //0xFF1E6E3C
        //0xFF00622D
        //0xFFEF7E2F -orange
      ),
      // home: MyHomePage(title: '$currentDate'),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        '/objects': (ctx) => ObjectsScreen(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }



// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           ElevatedButton.icon(
//             onPressed: () => selectedPage(context),
//             label: Text('1'),
//             icon: Icon(Icons.access_alarm_outlined),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 15,
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             child: SizedBox(
//               width: 400,
//               height: 20,
//               child: LinearProgressIndicator(
//                 value: 2,
//                 valueColor: AlwaysStoppedAnimation(Color(0xFF3F0C51)),
//                 backgroundColor: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 150,
//           ),
//           Container(
//             height: 300,
//             width: double.infinity,
//             color: Colors.grey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'calendar_picker',
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Theme.of(context).primaryColor,
//         selectedItemColor: Colors.white70,
//         unselectedItemColor: Colors.black,
//         iconSize: 35,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.house_rounded),
//             label: 'Главная',
//             //water_damage_outlined
//             //house_rounded
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.local_fire_department),
//             //assignment_outlined
//             //fact_check_rounded
//             //whatshot
//             //local_fire_department
//             //fireplace_rounded
//             label: 'Заявки',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history_edu_rounded),
//             //history
//             //history_edu_rounded
//             label: 'История',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business_rounded),

//             //location_city_rounded
//             label: 'Объекты',
//           ),
//         ],
//       ),
//     );
//   }
// }
