import 'package:flutter/material.dart';
import 'package:notification_app/core/dependency_injection/di.dart';
import 'package:notification_app/ui/screens/home.dart';
import 'package:notification_app/ui/shared/app_navigator.dart';
import 'package:notification_app/view_models/auth_view_model.dart';
import 'package:notification_app/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDependencies.registerDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        title: 'Notifier App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: AppNavigator.key,
        home: LandingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
