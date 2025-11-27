import 'package:flutter/material.dart';

@immutable
class SidebarPalette {
  /// SIDEBAR STILINI BURADAN DEĞİŞTİREBİLİRSİN ✅
  /// Özellikle background ve selected renkleri.
  final Color background;
  final Color divider;

  final Color itemHover;
  final Color itemSelected;

  final Color indicator; // soldaki ince çizgi
  final Color text;
  final Color textSelected;

  final Color icon;
  final Color iconSelected;

  const SidebarPalette({
    required this.background,
    required this.divider,
    required this.itemHover,
    required this.itemSelected,
    required this.indicator,
    required this.text,
    required this.textSelected,
    required this.icon,
    required this.iconSelected,
  });
}

class SidebarButton extends StatefulWidget {
  const SidebarButton({
    super.key,
    required this.palette,
    required this.icon,
    required this.label,
    this.trailing,
    this.selected = false,
    this.onTap,
  });

  final SidebarPalette palette;
  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.selected
        ? widget.palette.itemSelected
        : (_hover ? widget.palette.itemHover : Colors.transparent);

    final textColor = widget.selected ? widget.palette.textSelected : widget.palette.text;
    final iconColor = widget.selected ? widget.palette.iconSelected : widget.palette.icon;

    return MouseRegion(
      cursor: widget.onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            height: 48,
            width: double.infinity,
            color: bg,
            child: Row(
              children: [
                // left indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  width: 4,
                  height: double.infinity,
                  color: widget.selected ? widget.palette.indicator : Colors.transparent,
                ),
                const SizedBox(width: 14),
                Icon(widget.icon, size: 22, color: iconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.trailing != null) ...[
                  const SizedBox(width: 10),
                  widget.trailing!,
                  const SizedBox(width: 14),
                ] else
                  const SizedBox(width: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SidebarTag extends StatelessWidget {
  const SidebarTag({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD54F), // sarı "Yeni" etiketi (istersen değiştir)
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}
