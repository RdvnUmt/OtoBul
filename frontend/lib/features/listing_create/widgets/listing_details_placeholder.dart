import 'package:flutter/material.dart';

class ListingDetailsPlaceholder extends StatelessWidget {
  const ListingDetailsPlaceholder({
    super.key,
    this.height = 180,
    this.headerRight,
  });

  final double height;
  final Widget? headerRight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('İlan Bilgileri', style: theme.textTheme.titleMedium),
                const SizedBox(width: 8),
                Text('*', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
                const Spacer(),
                if (headerRight != null) headerRight!,
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.35),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Text(
                'Bu alan sonraki adımda kategoriye göre\nform alanlarıyla doldurulacak.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
