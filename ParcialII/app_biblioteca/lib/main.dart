import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const BibliotecaApp());

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Biblioteca Breve',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFA65D3E),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF8EE),
    ),
    home: const BibliotecaPage(),
  );
}

class BibliotecaPage extends StatefulWidget {
  const BibliotecaPage({super.key});

  @override
  State<BibliotecaPage> createState() => _BibliotecaPageState();
}

class _BibliotecaPageState extends State<BibliotecaPage> {
  final _controller = TextEditingController();
  List<Book> _books = [];
  bool _loading = true;
  String? _error;
  String _title = 'Libros destacados';

  @override
  void initState() {
    super.initState();
    _search('literature', initial: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String text, {bool initial = false}) async {
    final query = text.trim();
    if (query.isEmpty && !initial) {
      setState(() => _error = 'Escribe un título, tema o autor.');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _title = initial ? 'Libros destacados' : 'Resultados para "$query"';
    });
    try {
      final response = await http.get(
        Uri.https('gutendex.com', '/books/', {'search': query}),
      );
      if (response.statusCode != 200) {
        throw Exception('Respuesta no disponible');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _books = results
            .map((item) => Book.fromJson(item as Map<String, dynamic>))
            .toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _books = [];
        _loading = false;
        _error = 'No fue posible conectar con la biblioteca. Revisa tu conexión e inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Biblioteca Breve'),
      centerTitle: true,
      backgroundColor: const Color(0xFF6D3927),
      foregroundColor: const Color(0xFFFFF8EE),
    ),
    body: Column(
      children: [
        Container(
          color: const Color(0xFFF1DEC8),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _search,
                  decoration: const InputDecoration(
                    hintText: 'Título, tema o autor',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => _search(_controller.text),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFA65D3E),
                  padding: const EdgeInsets.all(15),
                ),
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_title, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        Expanded(child: _buildBody()),
      ],
    ),
  );

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Text(_error!, textAlign: TextAlign.center),
        ),
      );
    }
    if (_books.isEmpty) {
      return const Center(child: Text('No se encontraron libros.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: _books.length,
      itemBuilder: (_, index) => BookCard(book: _books[index]),
    );
  }
}

class Book {
  const Book({
    required this.title,
    required this.author,
    required this.image,
    required this.downloads,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final authors = json['authors'] as List<dynamic>;
    final formats = json['formats'] as Map<String, dynamic>;
    return Book(
      title: json['title'] as String? ?? 'Sin título',
      author: authors.isEmpty
          ? 'Autor desconocido'
          : (authors.first as Map<String, dynamic>)['name'] as String? ??
                'Autor desconocido',
      image: formats['image/jpeg'] as String?,
      downloads: json['download_count'] as int? ?? 0,
    );
  }

  final String title;
  final String author;
  final String? image;
  final int downloads;
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0xFFFFFDF9),
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 66,
            height: 94,
            color: const Color(0xFFE5C6A6),
            child: book.image == null
                ? const Icon(
                    Icons.menu_book,
                    color: Color(0xFF6D3927),
                    size: 34,
                  )
                : Image.network(
                    book.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.menu_book,
                      color: Color(0xFF6D3927),
                      size: 34,
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4C2B22),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  book.author,
                  style: const TextStyle(color: Color(0xFF7B5A4D)),
                ),
                const SizedBox(height: 12),
                Text(
                  '${book.downloads} descargas',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA65D3E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
