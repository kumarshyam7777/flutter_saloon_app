import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/salon.dart';
import '../widgets/info_row.dart';

class SalonDetailPage extends StatelessWidget {
  final Salon salon;

  const SalonDetailPage({super.key, required this.salon});

  Future<void> _openDirections(BuildContext context) async {
    final uri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': salon.address,
    });
    final activated = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!activated && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open directions.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(salon.name),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              Text(salon.rating.toStringAsFixed(1)),
              const SizedBox(width: 12),
              Chip(label: Text(salon.category)),
            ],
          ),
          const SizedBox(height: 12),
          InfoRow(icon: Icons.location_on, text: salon.address),
          InfoRow(icon: Icons.access_time, text: salon.hours),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.directions),
            label: const Text('Directions'),
            onPressed: () => _openDirections(context),
          ),
          const Divider(height: 32),
          const Text(
            'Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...salon.services.map(
            (service) => ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(service),
            ),
          ),
          if (salon.notes != null) ...[
            const Divider(height: 32),
            const Text(
              'Additional information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(salon.notes!),
          ],
          const SizedBox(height: 24),
          const Text(
            'Ratings and business details are shown as provided and may change. '
            'Confirm hours and availability before visiting.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
