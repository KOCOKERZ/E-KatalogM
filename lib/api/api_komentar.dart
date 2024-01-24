import 'dart:convert';
import 'package:flutter/material.dart'; // Import ini diperlukan untuk menggunakan ScaffoldMessenger
import 'package:http/http.dart' as http;
import 'package:movieproject/models/komentar.dart';

class ApiKomentar {
  static const _komentarUrl =
      'https://asia-southeast2-core-advice-401502.cloudfunctions.net/createkomentator';

  Future<void> postComment(BuildContext context, Comment comment) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(_komentarUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'ID_FILM': comment.idFilm,
          'Name': comment.name,
          'Tanggal': comment.tanggal,
          'Komentar': comment.komentar,
        }),
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');


      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Comment added successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add comment. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}
