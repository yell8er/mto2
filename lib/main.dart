import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import './screens/objects_screen.dart';
// import './screens/service_requests_screen.dart';
import './screens/tabs_screen.dart';
import './screens/auth_screen.dart';
import './helpers/material_color_creator.dart';
// import 'package:intl/intl.dart';

import './screens/add_object_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  void selectedPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/objects');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF00622D)),
        //0xFF007200-main
        //0xFF007A00
        //0xFF217b43
        //0xFF46BE4D
        //0xFF1E6E3C
        //0xFF00622D
        //0xFFEF7E2F -orange
      ),
      // home: AuthScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  return TabsScreen();
                }
                return AuthScreen();
              },
            ),
        '/add-object': (ctx) => AddObject(),
      },
    );
  }
}

