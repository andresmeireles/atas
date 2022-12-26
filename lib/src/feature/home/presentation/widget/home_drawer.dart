import 'package:atas/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(const ClearUserEvent());
            },
            child: const Text('LIMPAR DADOS'),
          ),
        ],
      ),
    );
  }
}
