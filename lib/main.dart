import 'package:flutter/material.dart';
import 'package:demo1/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:demo1/providers/storage_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StorageImageProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home-page',
        routes: {
          '/home-page': (_) => const HomePage(),
        },
      ),
    );
  }
}
