import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Posting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TambahPosting(),
    );
  }
}

class TambahPosting extends StatefulWidget {
  @override
  _TambahPostingState createState() => _TambahPostingState();
}

class _TambahPostingState extends State<TambahPosting> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _genreController = TextEditingController();
  TextEditingController _sinopsisController = TextEditingController();
  TextEditingController _penulisController = TextEditingController();
  TextEditingController _sutradaraController = TextEditingController();
  TextEditingController _aktorController = TextEditingController();
  XFile? _image;

  Future<void> _simpanPosting() async {
    if (_judulController.text.isEmpty ||
        _tanggalController.text.isEmpty ||
        _genreController.text.isEmpty ||
        _sinopsisController.text.isEmpty ||
        _penulisController.text.isEmpty ||
        _sutradaraController.text.isEmpty ||
        _aktorController.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua kolom harus diisi.'),
        ),
      );
      return;
    }

    try {
      final String apiUrl = 'https://asia-southeast2-core-advice-401502.cloudfunctions.net/createfilm';

      // Membuat request body sesuai dengan struktur JSON yang dibutuhkan oleh API
      final Map<String, dynamic> postData = {
        'ID': _judulController.text,
        'Judul': _judulController.text,
        'Tanggal': _tanggalController.text,
        'Genre': _genreController.text,
        'Sinopsis': _sinopsisController.text,
        'Penulis': _penulisController.text,
        'Sutradara': _sutradaraController.text,
        'Aktor': _aktorController.text,
        'Image': _image?.path ?? '', // Path gambar jika ada, jika tidak kosongkan
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        // Jika request berhasil, tambahkan logika atau tampilan sesuai kebutuhan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Posting berhasil disimpan.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan posting. Silakan coba lagi.'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi.'),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _clearImage() {
    setState(() {
      _image = null;
    });
  }

  Widget _buildInputFields() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _judulController,
          decoration: InputDecoration(labelText: 'Judul'),
        ),
        TextField(
          controller: _tanggalController,
          decoration: InputDecoration(labelText: 'Tanggal'),
        ),
        TextField(
          controller: _genreController,
          decoration: InputDecoration(labelText: 'Genre'),
        ),
        TextField(
          controller: _sinopsisController,
          decoration: InputDecoration(labelText: 'Sinopsis'),
        ),
        TextField(
          controller: _penulisController,
          decoration: InputDecoration(labelText: 'Penulis'),
        ),
        TextField(
          controller: _sutradaraController,
          decoration: InputDecoration(labelText: 'Sutradara'),
        ),
        TextField(
          controller: _aktorController,
          decoration: InputDecoration(labelText: 'Aktor'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _simpanPosting,
          child: Text('Simpan Tambah Posting'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pilih Gambar'),
        ),
        if (_image != null)
          Column(
            children: [
              SizedBox(height: 8.0),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(_image!.path)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _clearImage,
                child: Text('Hapus Gambar'),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Posting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildInputFields(),
          ],
        ),
      ),
    );
  }
}
