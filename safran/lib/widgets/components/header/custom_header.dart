import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class CustomHeader extends StatefulWidget implements PreferredSizeWidget {
  final String avatarAsset;
  final VoidCallback? onBookTap;
  final VoidCallback? onSettingsTap;
  final bool isRulesPage;
  final bool isSettingsPage;

  const CustomHeader({
    super.key,
    this.avatarAsset = "res/assets/home/default_avatar.png",
    this.onBookTap,
    this.onSettingsTap,
    required this.isRulesPage,
    required this.isSettingsPage,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  String username = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final payload = Jwt.parseJwt(token);
        setState(() {
          username = payload['username'] ?? 'Guest';
        });
      } catch (e) {
        print("Erreur parsing token: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: widget.preferredSize.height,
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFAE004B), Color(0xFF550167)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5AC),
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
                  child: ClipOval(
                    child: Image.asset(
                      widget.avatarAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Almendra',
                      fontSize: 26,
                      color: Color(0xFFFFE5AC),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _ActionPill(
                  rulesColor: widget.isRulesPage ? const Color(0xFFAE004B) : const Color(0xFFFFE5AC),
                  settingsColor: widget.isSettingsPage ? const Color(0xFFAE004B) : const Color(0xFFFFE5AC),
                  onBookTap: widget.onBookTap,
                  onSettingsTap: widget.onSettingsTap,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final Color rulesColor;
  final Color settingsColor;
  final VoidCallback? onBookTap;
  final VoidCallback? onSettingsTap;

  const _ActionPill({
    required this.rulesColor,
    required this.settingsColor,
    this.onBookTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ImageBtn(
          assetPath: "res/assets/home/rules.png",
          size: 55,
          onTap: onBookTap,
          color: rulesColor,
        ),
        const SizedBox(width: 6),
        _ImageBtn(
          assetPath: "res/assets/home/settings.png",
          size: 55,
          onTap: onSettingsTap,
          color: settingsColor,
        ),
      ],
    );
  }
}

class _ImageBtn extends StatelessWidget {
  final String assetPath;
  final double size;
  final VoidCallback? onTap;
  final Color color;

  const _ImageBtn({
    required this.assetPath,
    this.size = 24,
    this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        splashColor: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            assetPath,
            width: size,
            height: size,
            filterQuality: FilterQuality.high,
            color: color,
          ),
        ),
      ),
    );
  }
}