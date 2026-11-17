
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({
    super.key,
    required this.candi,
  });

  void _showImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(
                      Icons.error,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFav = context
        .watch<FavoriteProvider>()
        .isFavorite(candi.name);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: candi.imageAsset,
                      child: Image.asset(
                        candi.imageAsset,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100]
                          ?.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          candi.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<FavoriteProvider>()
                              .toggle(candi.name);
                        },
                        icon: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Lokasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.location}'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Dibangun',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.built}'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          'Tipe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(': ${candi.type}'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Colors.deepPurple.shade100),
                  const SizedBox(height: 16),

                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(candi.description),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.deepPurple.shade100),

                  const Text(
                    'Galeri',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: candi.imageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl =
                            candi.imageUrls[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _showImage(context, imageUrl);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      Colors.deepPurple.shade100,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Container(
                                      width: 120,
                                      color:
                                          Colors.deepPurple[50],
                                    );
                                  },
                                  errorWidget:
                                      (context, url, error) {
                                    return const Icon(
                                      Icons.error,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Tap untuk memperbesar',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
