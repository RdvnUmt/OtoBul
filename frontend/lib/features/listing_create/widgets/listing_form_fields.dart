import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'listing_details/listing_details_types.dart';

String? listingRequiredText(String? v, String msg) {
  if (v == null) return msg;
  if (v.trim().isEmpty) return msg;
  return null;
}

class ListingSection extends StatelessWidget {
  const ListingSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: theme.textTheme.titleSmall),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class ListingFormGrid extends StatelessWidget {
  const ListingFormGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final columns = w >= 1100 ? 4 : (w >= 760 ? 3 : (w >= 520 ? 2 : 1));
        const spacing = 12.0;
        final itemWidth = (w - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

class ListingReadOnlyInfo extends StatelessWidget {
  const ListingReadOnlyInfo({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class ListingHelperInfo extends StatelessWidget {
  const ListingHelperInfo({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Text(text),
    );
  }
}

class ListingSwitchTile extends StatelessWidget {
  const ListingSwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class ListingTextField extends StatelessWidget {
  const ListingTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.maxLength,
    this.required = true,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int? maxLength;
  final bool required;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator ??
          (required ? (v) => listingRequiredText(v, '$label zorunlu') : (v) => null),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingIntField extends StatelessWidget {
  const ListingIntField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.required = true,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;
  final String? Function(String?)? validator;

  static final _digitsOnly = <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: _digitsOnly,
      validator: validator ??
          (required
              ? (v) {
                  final msg = listingRequiredText(v, '$label zorunlu');
                  if (msg != null) return msg;
                  if (int.tryParse(v!.trim()) == null) return 'Sayı olmalı';
                  return null;
                }
              : (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  if (int.tryParse(v.trim()) == null) return 'Sayı olmalı';
                  return null;
                }),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingDecimalField extends StatelessWidget {
  const ListingDecimalField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.required = true,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;

  static final _decimalLike = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
  ];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: _decimalLike,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: required ? (v) => listingRequiredText(v, '$label zorunlu') : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingEnumDropdown<T> extends StatelessWidget {
  const ListingEnumDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> items;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(labelOf(e)))).toList(),
      onChanged: (v) => v == null ? null : onChanged(v),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingStringDropdown extends StatelessWidget {
  const ListingStringDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => v == null ? null : onChanged(v),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingNullableStringDropdown extends StatelessWidget {
  const ListingNullableStringDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: [
        const DropdownMenuItem(value: null, child: Text('Belirtilmedi')),
        ...items.map((e) => DropdownMenuItem(value: e, child: Text(e))),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingNullableBoolDropdown extends StatelessWidget {
  const ListingNullableBoolDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<bool>(
      value: value,
      items: const [
        DropdownMenuItem(value: null, child: Text('Belirtilmedi')),
        DropdownMenuItem(value: true, child: Text('Evet')),
        DropdownMenuItem(value: false, child: Text('Hayır')),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}

class ListingIntDropdown extends StatelessWidget {
  const ListingIntDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final int value;
  final List<LabeledInt> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e.id, child: Text(e.label))).toList(),
      onChanged: (v) => v == null ? null : onChanged(v),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
