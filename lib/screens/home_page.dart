import 'package:flutter/material.dart';

import '../data/salon_data.dart';
import '../widgets/salon_card.dart';
import 'salon_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final shown = kSalons.where((salon) {
      final searchableText = [
        salon.name,
        salon.category,
        salon.address,
        ...salon.services,
        salon.notes ?? '',
      ].join(' ').toLowerCase();
      return searchableText.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jaipur Salons & Parlours'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search name, area or service',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${shown.length} of ${kSalons.length} listings'),
            ),
          ),
          Expanded(
            child: shown.isEmpty
                ? const Center(child: Text('No salons or parlours found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: shown.length,
                    itemBuilder: (context, index) {
                      final salon = shown[index];
                      return SalonCard(
                        salon: salon,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SalonDetailPage(salon: salon),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Text(
              'Listing details are based on the information provided.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
