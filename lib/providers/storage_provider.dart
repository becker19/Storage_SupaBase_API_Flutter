import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class StorageImageProvider extends ChangeNotifier {
  File? image;
  String? nameImage;

  //BD
  String urlbase = 'https://tcvazumnxoogteyprtzd.supabase.co/rest/v1/producto';
  String keydb =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjdmF6dW1ueG9vZ3RleXBydHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzcwMzcsImV4cCI6MTk4NjYxMzAzN30.67jg9HnOGOXlfYHxgQIHy7iku6MJaaGxAvO8OqTqLeQ';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjdmF6dW1ueG9vZ3RleXBydHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzcwMzcsImV4cCI6MTk4NjYxMzAzN30.67jg9HnOGOXlfYHxgQIHy7iku6MJaaGxAvO8OqTqLeQ';

  //SUPABASE STORAGE
  final SupabaseClient client = SupabaseClient(
    'https://tcvazumnxoogteyprtzd.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjdmF6dW1ueG9vZ3RleXBydHpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzcwMzcsImV4cCI6MTk4NjYxMzAzN30.67jg9HnOGOXlfYHxgQIHy7iku6MJaaGxAvO8OqTqLeQ',
  );

  //=======================================================
  //API

  Future<String> guardarDB() async {
    final url = Uri.parse(urlbase);
    final String msg;

    Map<String, String> header = {
      'apikey': keydb,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final body = jsonEncode({
      "nombre": "Grupo1",
      "descripcion": "Prueba Demo",
      "categoria_id": 2,
      "image": nameImage
    });

    final response = await http.post(url, body: body, headers: header);

    if (response.statusCode != 201) {
      print('MSG=> NO SE GUARDO CORRECTAMENTE');
      msg = 'MSG=> NO SE GUARDO CORRECTAMENTE';
    } else {
      print('MSG=> SE GUARDO CORRECTAMENTE');
      msg = 'MSG=> SE GUARDO CORRECTAMENTE';
      subirImageStorage();
    }
    return msg;
  }

  //=======================================================

  //SUBIR LA IMAGE A STORAGE
  Future subirImageStorage() async {
    final file = File(image!.path);

    final ruta0 = '/data/user/0/com.example.demo1/cache/$nameImage';
    final ruta1 = image!.path.replaceAll(
      'data/user/0/com.example.demo1/cache',
      'IMG',
    );
    final ruta2 = image!.path.replaceAll(
      'data/user/0/com.example.demo1/app_flutter',
      'IMG',
    );

    final newPath = (image!.path == ruta0) ? ruta1 : ruta2;

    final response = await client.storage.from('grupo1').upload(newPath, file);

    print(response);

    notifyListeners();
  }

  //CAMARA
  Future activeCamaraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    //El nombre del archivo
    nameImage = image.name;
    this.image = imageTemp;
    notifyListeners();
  }

  //GALERIA
  Future activeGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    nameImage = image.name;
    this.image = imageTemp;
    notifyListeners();
  }

  //LIMPIAR IMAGEN
  Future activeCleanImage() async {
    image = null;
    notifyListeners();
  }
}
