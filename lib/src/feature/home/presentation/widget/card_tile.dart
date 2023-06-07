import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardTile extends StatelessWidget {
  final String route;
  final IconData icon;
  final Widget title;
  final Color? color;

  const CardTile({
    required this.route,
    required this.icon,
    required this.title,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => context.router.pushNamed(route),
      onTap: () => context.push('/minutes'),
      child: Card(
        color: color ?? Colors.blueAccent.shade100,
        child: Column(
          children: [
            ListTile(trailing: Icon(icon), title: title),
          ],
        ),
      ),
    );
  }
}
