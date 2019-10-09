import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:MediAssist/Screens/Login/root_page.dart';
import 'package:flutter/material.dart';
import 'package:MediAssist/Screens/Login/index.dart';
import 'package:MediAssist/Screens/Home/index.dart';
import './stepper.dart';
import './main1.dart';

class Routes {
  //final BaseAuth auth=;
  Routes() {
    runApp(new MaterialApp(
      title: "Medication Assistance App",
      debugShowCheckedModeBanner: false,
      home: new RootPage(auth: new Auth(),),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (BuildContext context) => new RootPage(),//new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (BuildContext context) => new HomeScreen(),//myApp for prescriptions(main1.dart) page.myHome() points to stepper.dart file.
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
