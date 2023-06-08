import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/model/minutes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MinuteDashboard extends StatelessWidget {
  const MinuteDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Minutes> items = [];
    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/minutes/add');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Center(child: Text('lista de atas'))),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.schema.toString()),
            onTap: () => context.push('/minutes/add'),
          );
        },
      ),
    );
  }
}
