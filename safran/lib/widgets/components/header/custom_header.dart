import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String avatarAsset;
  final VoidCallback? onBookTap;
  final VoidCallback? onSettingsTap;

  const CustomHeader({
    super.key,
    this.username = 'Guest',
    this.avatarAsset = "res/assets/home/default_avatar.png",
    this.onBookTap,
    this.onSettingsTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    const headerGradient = LinearGradient(
      colors: [
        Color(0xFFAE004B),
        Color(0xFF550167),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    const iconColor = Color(0xFFFFE5AC);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              gradient: headerGradient,
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
                    color: iconColor,
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
                      avatarAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Username
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
                  iconColor: iconColor,
                  onBookTap: onBookTap,
                  onSettingsTap: onSettingsTap,
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
  final Color iconColor;
  final VoidCallback? onBookTap;
  final VoidCallback? onSettingsTap;

  const _ActionPill({
    required this.iconColor,
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
        ),
        const SizedBox(width: 6),
        _ImageBtn(
          assetPath: "res/assets/home/settings.png",
          size: 55,
          onTap: onSettingsTap,
        ),
      ],
    );
  }
}

class _ImageBtn extends StatelessWidget {
  final String assetPath;
  final double size;
  final VoidCallback? onTap;

  const _ImageBtn({
    required this.assetPath,
    this.size = 24,
    this.onTap,
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
          ),
        ),
      ),
    );
  }
}