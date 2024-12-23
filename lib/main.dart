import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umpdsesi2/presentation/home/home_bindings.dart';
import 'package:umpdsesi2/presentation/home/home_screen.dart';
import 'package:umpdsesi2/presentation/utils/translation.dart';
import 'entities/cat_data.dart';
import 'util.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatDataImplAdapter());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Abel", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      translations: Translation(),
      title: "Cat Facts",
      locale: const Locale("id"),
      initialBinding: HomeBindings(),
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomeScreen(),
    );
  }
}
