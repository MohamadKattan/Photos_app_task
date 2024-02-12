import 'package:flutter/material.dart';
import 'package:image_list_test/views/save_image.dart';
import 'ctm_txt.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 200, 173, 247)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTxt(
                'Привет :)',
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.watch_later),
            title: const Text('Сохраненные изображения'),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SaveImageScreen()));
            },
          ),
        ],
      ),
    );
  }
}
