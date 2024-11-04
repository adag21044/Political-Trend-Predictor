import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/dependency_injector.dart';
import 'views/home_page.dart';

void main() {
  final injector = DependencyInjector();
  runApp(MyApp(injector: injector));
}

class MyApp extends StatelessWidget {
  final DependencyInjector injector;

  const MyApp({super.key, required this.injector});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => injector.newsViewModel),
      ],
      child: MaterialApp(
        title: 'ABD Politik Eğilimleri',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: const HomePage(),
      ),
    );
  }
}
