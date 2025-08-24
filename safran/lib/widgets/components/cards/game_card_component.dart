import 'package:flutter/material.dart';
import 'package:safran/entities/card/game_card.dart';

class GameCardComponent extends StatefulWidget {

  final GameCard card;

  const GameCardComponent({super.key, required this.card});

  @override
  State<GameCardComponent> createState() => _GameCardComponentState();

}

class _GameCardComponentState extends State<GameCardComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // <-- pour que l'image respecte les bords arrondis
      child: Image.asset(
        "res/assets/cards/${widget.card.image}",
        fit: BoxFit.cover, // <-- prend tout l'espace dispo
      ),
    );
  }
}