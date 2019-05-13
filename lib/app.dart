import 'package:flutter/material.dart';
import 'page/page.dart';
import 'package:flutter_architecture/style/style.dart';
import 'shelf.dart';
import 'package:provide/provide.dart';
import 'package:flutter_architecture/login/login_view_model.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  Providers _providers = Providers()
    ..provide(
      Provider.value(LoginViewModel()),
    );

  @override
  Widget build(BuildContext context) {
    return ProviderNode(
      providers: _providers,
      child: _buildMaterialApp(context),
    );
  }

  MaterialApp _buildMaterialApp(BuildContext context) {
    return MaterialApp(
      title: Strings.app_title,
      color: Colors.red,
      theme: ThemeData(brightness: Brightness.light,
//        primarySwatch: Colors.blue,
//          accentColor: Colors.white,
          ),
      home: Provide<LoginViewModel>(
        builder: (context, child, model) {
          return model.isLogin ? Shelf() : LoginPage();
        },
      ),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
    );
  }
}
