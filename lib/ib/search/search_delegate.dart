import 'package:flutter/material.dart';

class DRSearchDelegate extends SearchDelegate {
  final _items = const [
    {
      'label': 'DR downloads (offline maps)',
      'route': '/offline',
      'aliases': ['dr', 'offline', 'download', 'maps']
    },
    {
      'label': 'Ride Safety',
      'route': '/safety',
      'aliases': ['safety', 'driver', 'share']
    },
    {
      'label': 'Introduction & How to use',
      'route': '/intro',
      'aliases': ['intro', 'help']
    },
  ];

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final q = query.toLowerCase();

    final results = _items.where((e) =>
      e['label']!.toString().toLowerCase().contains(q) ||
      (e['aliases'] as List).any((a) => a.toString().toLowerCase().startsWith(q))
    ).toList();

    if (results.isEmpty) return const Center(child: Text('No results'));

    return ListView(
      children: results.map(
        (e) => ListTile(
          title: Text(e['label'] as String),
          onTap: () => Navigator.of(context).pushNamed(e['route'] as String),
        ),
      ).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}
 
