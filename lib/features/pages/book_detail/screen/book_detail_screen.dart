import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Detail Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //context.router.push(DetailsRoute(id: 42)); // Tip güvenli navigasyon
          },
          child: Text("Detay Sayfasına Git"),
        ),
      ),
    );
  }
}
