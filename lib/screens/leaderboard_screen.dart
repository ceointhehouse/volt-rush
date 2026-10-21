import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volt_rush/providers/leaderboard_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<LeaderboardProvider>(context).leaderboardStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No scores yet!'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;
              var score = data['score'] as int;
              var userId = data['userId'] as String;

              return ListTile(
                leading: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                title: Text(
                  'User: ${userId.substring(0, 6)}...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'Hash: ${userId.hashCode.toRadixString(16)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(
                  score.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
