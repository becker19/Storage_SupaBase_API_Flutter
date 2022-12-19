import 'package:demo1/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storageProvider = Provider.of<StorageImageProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 142, 255, 145),
      appBar: AppBar(
        title: const Text('Storage'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              storageProvider.activeCleanImage();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
                child: (storageProvider.image != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48),
                          child: Image.file(
                            storageProvider.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.photo,
                        size: 100,
                      ),
              ),
              onTap: () {
                storageProvider.activeGalleryImage();
              },
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.amber,
                onPressed: () {
                  storageProvider.activeCamaraImage();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.camera_alt),
                    Text('Camara'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.amber,
                onPressed: () {
                  storageProvider.guardarDB();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.save),
                    Text('Guardar'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
