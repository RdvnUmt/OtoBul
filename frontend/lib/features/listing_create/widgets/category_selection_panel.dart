import 'package:flutter/material.dart';
import 'listing_create_models.dart';

typedef CategoryChanged = void Function(
  ListingMainCategory main,
  ListingVasitaCategory vasita,
  ListingEmlakCategory emlak,
);

class CategorySelectionPanel extends StatelessWidget {
  const CategorySelectionPanel({
    super.key,
    required this.mainCategory,
    required this.vasitaCategory,
    required this.emlakCategory,
    required this.onChanged,
    this.enabled = true, // ✅ edit modunda kilitlemek için
  });

  final ListingMainCategory mainCategory;
  final ListingVasitaCategory vasitaCategory;
  final ListingEmlakCategory emlakCategory;
  final CategoryChanged onChanged;

  /// false ise tüm panel "read-only" olur (tıklanamaz) + opacity düşer
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Kategori Seçimi', style: theme.textTheme.titleLarge),
        const SizedBox(height: 12),

        SegmentedButton<ListingMainCategory>(
          segments: const [
            ButtonSegment(
              value: ListingMainCategory.emlak,
              label: Text('Emlak'),
              icon: Icon(Icons.home_rounded),
            ),
            ButtonSegment(
              value: ListingMainCategory.vasita,
              label: Text('Vasıta'),
              icon: Icon(Icons.directions_car_rounded),
            ),
          ],
          selected: {mainCategory},
          onSelectionChanged: (set) {
            final next = set.first;
            onChanged(next, vasitaCategory, emlakCategory);
          },
        ),

        const SizedBox(height: 12),
        Divider(color: theme.colorScheme.outlineVariant),
        const SizedBox(height: 8),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: mainCategory == ListingMainCategory.vasita
              ? _VasitaSubcategory(
                  key: const ValueKey('vasita'),
                  value: vasitaCategory,
                  onChanged: (v) => onChanged(mainCategory, v, emlakCategory),
                )
              : _EmlakSubcategory(
                  key: const ValueKey('emlak'),
                  value: emlakCategory,
                  onChanged: (v) => onChanged(mainCategory, vasitaCategory, v),
                ),
        ),
      ],
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: AbsorbPointer(
          absorbing: !enabled,
          child: Opacity(
            opacity: enabled ? 1 : 0.55,
            child: content,
          ),
        ),
      ),
    );
  }
}

class _VasitaSubcategory extends StatelessWidget {
  const _VasitaSubcategory({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final ListingVasitaCategory value;
  final ValueChanged<ListingVasitaCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return _DropdownCard<ListingVasitaCategory>(
      title: 'Vasıta Kategorisi',
      icon: Icons.directions_car_rounded,
      value: value,
      items: ListingVasitaCategory.values,
      itemLabel: (v) => v.label,
      onChanged: onChanged,
    );
  }
}

class _EmlakSubcategory extends StatelessWidget {
  const _EmlakSubcategory({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final ListingEmlakCategory value;
  final ValueChanged<ListingEmlakCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return _DropdownCard<ListingEmlakCategory>(
      title: 'Emlak Kategorisi',
      icon: Icons.home_work_rounded,
      value: value,
      items: ListingEmlakCategory.values,
      itemLabel: (v) => v.label,
      onChanged: onChanged,
    );
  }
}

class _DropdownCard<T> extends StatelessWidget {
  const _DropdownCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final T value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: theme.textTheme.titleSmall),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<T>(
            value: value,
            items: items
                .map(
                  (v) => DropdownMenuItem<T>(
                    value: v,
                    child: Text(itemLabel(v)),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              hintText: 'Seçiniz',
            ),
          ),
        ],
      ),
    );
  }
}
