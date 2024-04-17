import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weatherapp_starter_project/screens/home_screen.dart';

import 'controller/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.put(ThemeController());

    return  GetMaterialApp(
      home: const InternetConnectionWrapper(child: HomeScreen()),
      title: "Weather",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeController.getThemeMode(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class InternetConnectionWrapper extends StatefulWidget {
  final Widget child;

  const InternetConnectionWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _InternetConnectionWrapperState createState() => _InternetConnectionWrapperState();
}

class _InternetConnectionWrapperState extends State<InternetConnectionWrapper> {
  late InternetConnectionStatus _connectionStatus = InternetConnectionStatus.disconnected;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    // Subscribe to internet connection changes
    InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  Future<void> _checkInternetConnection() async {
    _connectionStatus = await InternetConnectionChecker().connectionStatus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == InternetConnectionStatus.disconnected) {
      return Scaffold(
        body: Center(
          child: AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection and try again.'),
            actions: [
              _connectionStatus == InternetConnectionStatus.connected ?
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ) : TextButton(
                onPressed: (){},
                child: Text('OK'),
              ),
            ],
          ),
        ),
      );
    } else {
      return widget.child;
    }
  }
}