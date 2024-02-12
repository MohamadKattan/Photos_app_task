import 'package:flutter/material.dart';
import 'package:image_list_test/components%20/ctm_txt.dart';
import 'package:image_list_test/views/home_page.dart';
import 'package:provider/provider.dart';

import '../controllers/save_image_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _asyncMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CustomTxt('Задача приложения «Фото»',color: Colors.black,),
        ),
      ),
    );
  }

  Future<void> _asyncMethods() async {
    await context
        .read<ImageController>()
        .getListOfImagesFromApi(context: context);
    if (!context.mounted) return;
    await context.read<ImageController>().readDataFromLocal(context);
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) =>const HomePage()));
  }
}
