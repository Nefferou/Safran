import 'package:flutter/material.dart';

class NbPlayerSelector extends StatefulWidget {
  const NbPlayerSelector({
    super.key,
    this.min = 3,
    this.max = 6,
    this.initial,
  });

  final int min;
  final int max;
  final int? initial;

  @override
  State<NbPlayerSelector> createState() => _NbPlayerSelectorState();
}

class _NbPlayerSelectorState extends State<NbPlayerSelector> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = (widget.initial ?? widget.min).clamp(widget.min, widget.max);
  }

  void _dec() {
    if (_value > widget.min) setState(() => _value--);
  }

  void _inc() {
    if (_value < widget.max) setState(() => _value++);
  }

  @override
  Widget build(BuildContext context) {
    final bool canDec = _value > widget.min;
    final bool canInc = _value < widget.max;

    return Container(
      width: 230,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5AC),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 80, maxWidth: 200),
            child: const Text(
              'Nombre de joueurs',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAE004B),
                fontFamily: 'Almendra',
              ),
            ),
          ),

          InkWell(
            onTap: canDec ? _dec : null,
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              "res/assets/host_game/substract.png",
              fit: BoxFit.contain,
              color: canDec ? const Color(0xFFAE004B) : Colors.grey,
            ),
          ),

          Text(
            "$_value",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFAE004B),
              fontFamily: 'Almendra',
            ),
          ),

          InkWell(
            onTap: canInc ? _inc : null,
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              "res/assets/host_game/plus.png",
              fit: BoxFit.contain,
              color: canInc ? const Color(0xFFAE004B) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
