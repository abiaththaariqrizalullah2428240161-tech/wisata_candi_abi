import 'package:flutter/material.dart';
import 'package:wisata_candi/models/candi.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Todo: 1. Deklarasikan variabel yg dibutuhkan
  List<Candi> filterCandis = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Todo: 2. Buat appbar dengan judul pencarian candi
      appBar: AppBar(title: Text('Pencarian Candi'),),
      // Todo: 3. Buat body berupa column
      body: Column(
        children: [
          // Todo: 4. Buat textfeld pencarian sebagai anak dari column
          TextField(),
          // Todo: 5. Buat listview hasil pencarian sebagai anak dari column
        ],
      ),
    );
  }
}