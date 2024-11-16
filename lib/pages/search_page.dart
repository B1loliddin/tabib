import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;
  final List<String> _items = List.generate(100, (index) => 'Item $index');
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeAllControllers();
  }

  /// #initializations
  void _initAll() {
    _searchController = TextEditingController();
    _filteredItems = _items;
    _searchController.addListener(_filterItems);
  }

  void _disposeAllControllers() {
    _searchController.dispose();
  }

  /// #main functions
  void _filterItems() {
    final query = _searchController.text.trim().toLowerCase();

    _filteredItems =
        _items.where((item) => item.toLowerCase().contains(query)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// #search field
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            /// #doctors
            Expanded(
              child: _filteredItems.isEmpty
                  ? const Center(
                      child: Text('No results found'),
                    )
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredItems[index]),
                          subtitle:
                              Text('Details for ${_filteredItems[index]}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
