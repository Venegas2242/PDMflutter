import 'package:flutter/material.dart';
import '../models/list_model.dart';

class DetailScreen extends StatefulWidget {
  final GameModel game;

  DetailScreen(this.game);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_scaleController);

    _slideController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(_slideController);

    // Iniciar las animaciones cuando se carga la pantalla
    _scaleController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.game.name)),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Animación imagen
          Hero(
            tag: widget.game.name, // Mismo tag que en la pantalla anterior
            child: Container(
              height: 300.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  widget.game.imagePath2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Espaciado
                SizedBox(height: 16.0),
                // Animación para el título
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    widget.game.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                // Animación para la descripción larga
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(widget.game.longDescription),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Invertir el estado de favorito
                      widget.game.isFavorite = !widget.game.isFavorite;
                    });

                    // Devolver el estado de favorito a la pantalla anterior
                    Navigator.pop(context, widget.game.isFavorite);
                  },
                  child: Text(widget.game.isFavorite ? 'Eliminar de favoritos' : 'Marcar como favorito'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}