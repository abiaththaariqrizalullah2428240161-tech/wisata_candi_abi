
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_provider.dart';
import '../providers/auth_provider.dart';
import 'sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCount =
        context.watch<FavoriteProvider>().count;

    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 150,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'images/placeholder_image.png',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          Icon(Icons.lock, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'Pengguna',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? auth.username : '-'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),

                Row(
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Nama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? auth.username : '-'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),

                Row(
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Favorit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $favoriteCount',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 20),

                auth.isSignedIn
                    ? TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().signOut();
                          context.read<FavoriteProvider>().clearAll();
                        },
                        child: const Text('Sign Out'),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text('Sign In'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
