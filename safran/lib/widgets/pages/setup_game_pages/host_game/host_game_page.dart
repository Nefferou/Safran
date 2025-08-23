import 'package:flutter/material.dart';
import 'package:safran/widgets/pages/setup_game_pages/host_game/game_name_textfield.dart';
import 'package:safran/widgets/pages/setup_game_pages/host_game/privacy_switch.dart';
import 'package:safran/widgets/pages/setup_game_pages/host_game/nb_player_selector.dart';

import '../../../components/header/custom_header.dart';
import '../../settings_page/rules_page.dart';
import '../../settings_page/settings_page.dart';

class HostGamePage extends StatefulWidget {
  const HostGamePage({super.key});

  @override
  State<HostGamePage> createState() => _HostGamePageState();
}

class _HostGamePageState extends State<HostGamePage> {
  late final TextEditingController gameNameController;

  @override
  void initState() {
    super.initState();
    gameNameController = TextEditingController();
  }

  @override
  void dispose() {
    gameNameController.dispose();
    super.dispose();
  }

  Privacy _privacy = Privacy.private;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomHeader(
        onBookTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (c, a1, a2) => RulesPage()),
          );
        },
        onSettingsTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (c, a1, a2) => SettingsPage()),
          );
        },
      ),
      resizeToAvoidBottomInset: true,
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
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: const Text(
                            'Invocation des joueurs et mise en place de la partie...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFE5AC),
                              fontFamily: 'Almendra',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 300, // peut être 230 si tu veux
                                minWidth: 180,
                                minHeight: 40,
                              ),
                              child: GameNameTextField(
                                  controller: gameNameController),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 230,
                                minWidth: 160,
                                minHeight: 40,
                              ),
                              child: NbPlayerSelector(
                                min: 3,
                                max: 6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          child: PrivacySwitch(
                            value: _privacy,
                            onChanged: (val) => setState(() => _privacy = val),
                            height: 40,
                            radius: 12,
                            diagonalOffset: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF4C956C),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "res/assets/host_game/cards.png",
                        color: const Color(0xFFFFE5AC),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Créer la partie',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFE5AC),
                          fontFamily: 'Almendra',
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFAE004B),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "res/assets/host_game/logout.png",
                        color: const Color(0xFFFFE5AC),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Annuler la partie',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFE5AC),
                          fontFamily: 'Almendra',
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
