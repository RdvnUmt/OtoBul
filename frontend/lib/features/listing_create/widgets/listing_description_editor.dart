import 'package:flutter/material.dart';

class ListingDescriptionEditor extends StatelessWidget {
  const ListingDescriptionEditor({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

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
            Text('İlan açıklaması (Opsiyonel)', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              minLines: 6,
              maxLines: 10,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText:
                    'İlanda öne çıkarmak istediğiniz detayları yazın.\n'
                    'Örn: Bakımları yeni, masrafsız, pazarlık payı vardır...',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
