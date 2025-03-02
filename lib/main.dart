 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_with_provider_practice/utils/routes/routes.dart';
import 'package:rest_api_with_provider_practice/utils/routes/routes_name.dart';
import 'package:rest_api_with_provider_practice/view_model/auth_view_model.dart';
import 'package:rest_api_with_provider_practice/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
