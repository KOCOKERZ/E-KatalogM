import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/constant.dart';
import 'package:movieproject/widgets/back_button.dart';
import 'package:movieproject/models/lokal.dart';
import 'package:movieproject/models/komentar.dart';
import 'package:movieproject/api/api_komentar.dart';
import 'package:uuid/uuid.dart';

class DetailScreenLokal extends StatefulWidget {
  final Lokal filmData;

  const DetailScreenLokal({Key? key, required this.filmData}) : super(key: key);

  @override
  _DetailScreenLokalState createState() => _DetailScreenLokalState();
}

class _DetailScreenLokalState extends State<DetailScreenLokal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                '${Constants.imageUrl}${widget.filmData.image}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: BackBtn(),
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery
                      .of(context)
                      .size
                      .height,
                  pinned: true,
                  flexibleSpace: SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.6,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Image.network(
                                widget.filmData.image,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Judul: ${widget.filmData.judul}',
                          style: GoogleFonts.openSans(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal: ${widget.filmData.tanggal}',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Genre: ${widget.filmData.genre}',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sinopsis: ${widget.filmData.sinopsis}',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Komentar',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              Comment comment = comments[index];
                              return ListTile(
                                title: Text(comment.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment.name),
                                    Text(comment.tanggal),
                                    Text(comment.komentar),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Nama',
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Tambahkan komentar...',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                _addComment();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addComment() {
    // Ganti nilai ID dengan nilai yang sesuai dengan kebutuhan aplikasi Anda
    String id = uuid.v4(); // Misalnya, Anda bisa menggunakan library seperti 'uuid' untuk menghasilkan ID unik

    // Ganti dengan nama pengguna yang sebenarnya
    String name = commentController.text;

    // Ambil waktu saat ini sebagai tanggal komentar
    String tanggal = DateTime.now().toString();

    // Ambil teks komentar dari pengguna
    String komentar = commentController.text;

    // Buat objek Comment dengan nilai yang sudah diisi
    Comment newComment = Comment(
      id: id,
      idFilm: widget.filmData.id,
      name: name,
      tanggal: tanggal,
      komentar: komentar,
    );

    // Tambahkan objek Comment ke daftar komentar
    comments.add(newComment);

    // Kirim komentar ke server (gunakan fungsi postComment dari ApiKomentar)
    ApiKomentar apiKomentar = ApiKomentar(); // Inisialisasi ApiKomentar
    apiKomentar.postComment(context, newComment);

    // Bersihkan input
    commentController.clear();

    // Refresh tampilan untuk menampilkan komentar terbaru
    setState(() {});
  }
}