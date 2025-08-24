import 'package:flutter/material.dart';
import 'package:safran/widgets/components/header/custom_header.dart';
import 'package:safran/widgets/pages/settings_page/rules_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const double _headerHeight = 100;
  static const double _gapBelowHeader = 10;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // État
  String _lang = 'fr';
  String _mode = 'cl';

  int _selected = 0; // 0 = Affichage, 1 = Son, 2 = Déconnexion

  double _musicVol = 0.7;
  double _sfxVol = 0.8;
  bool _muted = false;

  Future<void> _confirmLogout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Se déconnecter')),
        ],
      ),
    );
    if (ok == true) {
      // TODO: logique de déconnexion
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Déconnecté.')));
    }
    setState(() => _selected = 0); // revenir sur Affichage
  }

  @override
  Widget build(BuildContext context) {
    const bordeaux = Color(0xFFAE004B);
    const jauneClair = Color(0xFFF6DDA5);

    final double topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomHeader(
        onBookTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RulesPage()),
          );
        },
        onSettingsTap: () {},
        isRulesPage: false,
        isSettingsPage: true,
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
          // content
          Padding(
            padding: EdgeInsets.only(
              top: topInset +
                  SettingsPage._headerHeight +
                  SettingsPage._gapBelowHeader,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: LayoutBuilder(
              builder: (context, c) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    // ====== COLONNE CENTRALE (inchangée) ======
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // On bascule comme dans RulesPage via AnimatedSwitcher
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: _selected == 0
                                ? _DisplaySettings(
                              key: const ValueKey('affichage'),
                              lang: _lang,
                              mode: _mode,
                              onLangChanged: (v) => setState(() => _lang = v),
                              onModeChanged: (v) => setState(() => _mode = v),
                              bordeaux: bordeaux,
                              jauneClair: jauneClair,
                            )
                                : _SoundSettings(
                              key: const ValueKey('son'),
                              music: _musicVol,
                              sfx: _sfxVol,
                              muted: _muted,
                              onMusicChanged: (v) => setState(() => _musicVol = v),
                              onSfxChanged: (v) => setState(() => _sfxVol = v),
                              onMutedChanged: (v) => setState(() => _muted = v),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ====== PANNEAU DROIT ======
                    SizedBox(
                      width: 165,
                      height: 155,
                      child: _RightPane(
                        selected: _selected,
                        onChanged: (i) {
                          if (i == 2) {
                            _confirmLogout();
                          } else {
                            setState(() => _selected = i);
                          }
                        },
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

// ======= Contenu "Affichage" (Langue & Mode) =======
class _DisplaySettings extends StatelessWidget {
  const _DisplaySettings({
    super.key,
    required this.lang,
    required this.mode,
    required this.onLangChanged,
    required this.onModeChanged,
    required this.bordeaux,
    required this.jauneClair,
  });

  final String lang;
  final String mode;
  final ValueChanged<String> onLangChanged;
  final ValueChanged<String> onModeChanged;
  final Color bordeaux;
  final Color jauneClair;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // LANGUE
        Container(
          width: 340,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: bordeaux,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Langue",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownMenu<String>(
                    initialSelection: lang,
                    onSelected: (v) { if (v != null) onLangChanged(v); },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "fr", label: "Français"),
                      DropdownMenuEntry(value: "en", label: "English"),
                    ],
                    menuHeight: 120,
                    textStyle: TextStyle(
                      color: bordeaux,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    trailingIcon: const Icon(Icons.arrow_drop_down),
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      filled: true,
                      fillColor: jauneClair,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    menuStyle: const MenuStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFFFFE5AC)),
                      elevation: WidgetStatePropertyAll(6),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // MODE
        Container(
          width: 340,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: bordeaux,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Text(
                "Mode",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownMenu<String>(
                    initialSelection: mode,
                    onSelected: (value) { if (value != null) onModeChanged(value); },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "cl", label: "Classique"),
                    ],
                    textStyle: TextStyle(
                      color: bordeaux,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    trailingIcon: const Icon(Icons.arrow_drop_down),
                    menuStyle: const MenuStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFFFFE5AC)),
                      elevation: WidgetStatePropertyAll(6),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      filled: true,
                      fillColor: jauneClair,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ======= Contenu "Son" (style maquette) =======
class _SoundSettings extends StatelessWidget {
  const _SoundSettings({
    super.key,
    required this.music,
    required this.sfx,
    required this.muted,
    required this.onMusicChanged,
    required this.onSfxChanged,
    required this.onMutedChanged,
  });

  final double music; // utilisé pour "Volume"
  final double sfx;   // utilisé pour "Music"
  final bool muted;
  final ValueChanged<double> onMusicChanged;
  final ValueChanged<double> onSfxChanged;
  final ValueChanged<bool> onMutedChanged;

  static const _bordeaux = Color(0xFFAE004B);
  static const _cream    = Color(0xFFFFE5AC);
  static const _accent   = Color(0xFF7C2BBE); // violet du slider (ajuste si besoin)

  @override
  Widget build(BuildContext context) {
    final sliderTheme = SliderTheme.of(context).copyWith(
      trackHeight: 6,
      activeTrackColor: _accent,
      inactiveTrackColor: Colors.white.withOpacity(.85),
      thumbColor: _accent,
      overlayColor: Colors.transparent,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      trackShape: const RoundedRectSliderTrackShape(),
    );

    Widget tile({
      required String label,
      required Image image,
      required double value,
      required ValueChanged<double> onChanged,
    }) {
      return Container(
        width: 340,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _bordeaux,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _bordeaux,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Almendra',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _cream,
                    ),
                  ),
                  const SizedBox(width: 10),
                  image,
                ],
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: SliderTheme(
                data: sliderTheme,
                child: Slider(
                  value: value,
                  onChanged: muted ? null : onChanged,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tile(
          label: 'Volume',
          image: Image.asset("res/assets/settings/speaker.png"),
          value: music,
          onChanged: onMusicChanged,
        ),
        const SizedBox(height: 16),
        tile(
          label: 'Music',
          image: Image.asset("res/assets/settings/musical_note.png"),
          value: sfx,
          onChanged: onSfxChanged,
        ),
      ],
    );
  }
}

// ======= Panneau droit (inchangé visuellement) =======
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
          _tab("Affichage", 0, selected == 0, top: true, onTap: () => onChanged(0)),
          Container(height: 1, color: _cream.withOpacity(.7)),
          _tab("Son", 1, selected == 1, onTap: () => onChanged(1)),
          Container(height: 1, color: _cream.withOpacity(.7)),
          _tab("Déconnexion", 2, selected == 2, bottom: true, onTap: () => onChanged(2)),
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
        height: 50,
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
            color: _cream,
          ),
        ),
      ),
    );
  }
}
