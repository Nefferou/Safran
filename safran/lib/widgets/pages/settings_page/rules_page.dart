import 'package:flutter/material.dart';
import 'package:safran/widgets/components/header/custom_header.dart';
import 'package:safran/widgets/pages/settings_page/settings_page.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  static const double _headerHeight = 100;
  static const double _gapBelowHeader = 10;

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  int _selected = 0;

  final List<String> _cardImages = const [
    'res/assets/cards/commander.png',
    'res/assets/cards/archer.png',
    'res/assets/cards/guard.png',
    'res/assets/cards/swordsman.png',
    'res/assets/cards/thief.png',
    'res/assets/cards/aeromancer.png',
    'res/assets/cards/geomancer.png',
    'res/assets/cards/arcanist.png',
    'res/assets/cards/plague_knight.png',
    'res/assets/cards/war_knight.png',
    'res/assets/cards/conquest_knight.png',
    'res/assets/cards/famine_knight.png',
    'res/assets/cards/disease_herald.png',
    'res/assets/cards/chaos_herald.png',
    'res/assets/cards/power_herald.png',
    'res/assets/cards/suffering_herald.png',
    'res/assets/cards/healing_saint.png',
    'res/assets/cards/peace_saint.png',
    'res/assets/cards/prosperity_saint.png',
    'res/assets/cards/abundance_saint.png',
  ];

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomHeader(
        onBookTap: () {},
        onSettingsTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        },
        isRulesPage: true,
        isSettingsPage: false,
      ),
      body: Stack(
        children: [
          // background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("res/assets/home/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: topInset +
                  RulesPage._headerHeight +
                  RulesPage._gapBelowHeader,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: LayoutBuilder(
              builder: (context, c) {
                final isWide = c.maxWidth >= 800;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Image(
                          image: AssetImage("res/assets/join_game/back.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 220),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: _selected == 0
                                        ? const _RulesScroll(
                                            key: ValueKey('rules'))
                                        : _CardsGrid(
                                            key: const ValueKey('cards'),
                                            images: _cardImages,
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: 165,
                                  child: _RightPane(
                                    selected: _selected,
                                    onChanged: (i) =>
                                        setState(() => _selected = i),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 220),
                                    switchInCurve: Curves.easeOut,
                                    switchOutCurve: Curves.easeIn,
                                    child: _selected == 0
                                        ? const _RulesScroll(
                                            key: ValueKey('rules'))
                                        : _CardsGrid(
                                            key: const ValueKey('cards'),
                                            images: _cardImages,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                                      ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============== CONTENU "REGLES" ===============

class _RulesScroll extends StatelessWidget {
  const _RulesScroll({super.key});

  static const Color _cream = Color(0xFFFFE5AC);
  static const Color _creamSoft = Color(0xFFEEDDB3);

  TextStyle get _titleStyle => const TextStyle(
        fontFamily: 'Almendra',
        fontWeight: FontWeight.bold,
        fontSize: 24,
        height: 1.1,
        color: _cream,
      );

  TextStyle get _bodyStyle => const TextStyle(
        fontFamily: 'Almendra',
        fontSize: 16,
        height: 1.35,
        color: _creamSoft,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Objectif
          Text("Objectif du jeu", style: _titleStyle),
          const SizedBox(height: 12),
          Text(
            "Être le dernier joueur encore en jeu en conservant ses cartes le plus longtemps possible. "
            "Stratégie et ruse sont essentielles pour éliminer les adversaires.",
            style: _bodyStyle,
          ),
          const SizedBox(height: 20),

          // Déroulement
          Text("Déroulement d'une partie", style: _titleStyle),
          const SizedBox(height: 12),
          _bullets(const [
            "2 à 6 joueurs.",
            "Les cartes sont distribuées équitablement, sauf une carte face visible au centre : le Champ de Bataille.",
            "À tour de rôle, chaque joueur joue une carte sur le Champ de Bataille et applique son effet si elle en possède un.",
            "Un joueur qui n’a plus de cartes est éliminé.",
            "La partie continue jusqu’à ce qu’il ne reste qu’un seul joueur.",
          ]),

          const SizedBox(height: 20),

          // Jouer / Défausser
          Text("Jouer vs Défausser", style: _titleStyle),
          const SizedBox(height: 12),
          _bullets(const [
            "Jouer une carte : la poser sur le Champ de Bataille et appliquer son effet.",
            "Défausser une carte : la poser sur le Champ de Bataille sans appliquer d'effet.",
          ]),

          const SizedBox(height: 20),

          // Fin
          Text("Fin de la partie", style: _titleStyle),
          const SizedBox(height: 12),
          _bullets(const [
            "La partie prend fin lorsqu'il ne reste qu'un seul joueur en vie.",
            "Ce dernier est déclaré vainqueur.",
          ]),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _bullets(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((t) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text("•", style: TextStyle(fontSize: 18, color: _cream)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(t, style: _bodyStyle),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// =============== CONTENU "CARTES" (GRILLE) ===============

class _CardsGrid extends StatelessWidget {
  const _CardsGrid({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: images.length,
      itemBuilder: (context, i) {
        final img = images[i];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      img,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.image_not_supported_outlined,
                            color: Colors.white54, size: 48),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: const Color(0xFF2B1854),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.image_not_supported_outlined,
                      color: Colors.white54),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// =============== PANNEAU DROIT ===============

class _RightPane extends StatelessWidget {
  const _RightPane({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  static const Color _pill = Color(0xFF8F0E57);
  static const Color _pillDark = Color(0xFF6C0E58);
  static const Color _cream = Color(0xFFFFE5AC);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_pill, _pillDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tab("Règles", 0, selected == 0,
              top: true, onTap: () => onChanged(0)),
          Container(height: 1, color: _cream.withOpacity(.7)),
          _tab("Cartes", 1, selected == 1,
              bottom: true, onTap: () => onChanged(1)),
        ],
      ),
    );
  }

  Widget _tab(String label, int index, bool isSelected,
      {bool top = false, bool bottom = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: top ? const Radius.circular(22) : Radius.zero,
        bottom: bottom ? const Radius.circular(22) : Radius.zero,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? _cream.withOpacity(.15) : Colors.transparent,
          borderRadius: BorderRadius.vertical(
            top: top ? const Radius.circular(22) : Radius.zero,
            bottom: bottom ? const Radius.circular(22) : Radius.zero,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Almendra',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: isSelected
                ? [
                    const Shadow(
                      color: Colors.black,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ]
                : null,
            color: Color(0xFFFFE5AC),
          ),
        ),
      ),
    );
  }
}
