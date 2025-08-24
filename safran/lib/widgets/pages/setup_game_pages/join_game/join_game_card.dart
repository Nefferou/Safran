import 'package:flutter/material.dart';

class JoinGameCard extends StatefulWidget {
  final String title;
  final bool isPrivate;
  final int maxPlayers;
  final int currentPlayers;
  final VoidCallback onTap;

  const JoinGameCard({
    super.key,
    required this.title,
    required this.isPrivate,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.onTap,
  });

  @override
  State<JoinGameCard> createState() => _JoinGameCardState();
}

class _JoinGameCardState extends State<JoinGameCard> {
  static const Color _color = Color.fromRGBO(255, 229, 172, 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: (widget.currentPlayers == widget.maxPlayers)
              ? Color(0xFFAE004B).withOpacity(0.6)
              : Color(0xFFAE004B),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                Image.asset(
                  "res/assets/join_game/${widget.isPrivate ? "private" : "public"}.png",
                  color: _color,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: _color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Almendra",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Center(
                    child: Text(
                      "${widget.currentPlayers}/${widget.maxPlayers}",
                      style: const TextStyle(
                        color: Color(0xFFAE004B),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Almendra",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
