
import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Candi> _filteredCandis = candiList;

  final TextEditingController _searchController =
      TextEditingController();

  void _searchCandi(String query) {
    setState(() {
      _filteredCandis = candiList.where((candi) {
        return candi.name.toLowerCase().contains(query.toLowerCase()) ||
            candi.location.toLowerCase().contains(query.toLowerCase()) ||
            candi.type.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredCandis = candiList;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian Candi'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),

              child: TextField(
                controller: _searchController,
                onChanged: _searchCandi,

                decoration: InputDecoration(
                  hintText: 'Cari candi...',
                  prefixIcon: const Icon(Icons.search),

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _clearSearch,
                  ),

                  border: InputBorder.none,

                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: _filteredCandis.isEmpty
                ? const Center(
                    child: Text('Candi tidak ditemukan'),
                  )
                : ListView.builder(
                    itemCount: _filteredCandis.length,

                    itemBuilder: (context, index) {
                      final candi = _filteredCandis[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(candi: candi),
                            ),
                          );
                        },

                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 100,
                                height: 100,

                                child: Hero(
                                  tag: candi.imageAsset,

                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10),

                                    child: Image.asset(
                                      candi.imageAsset,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      candi.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(candi.location),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
