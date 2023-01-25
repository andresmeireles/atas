import 'package:atas/environment.dart';
import 'package:atas/src/feature/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final devMode = Environment.isDevMode;
    return SafeArea(
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(title: devMode ? const Text('atas [DEV]') : const Text('atas')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => context.push('/new-minute'),
                    child: Card(
                      color: Colors.blueGrey,
                      child: Center(
                        child: Text('Nova Ata', style: TextStyle(fontSize: size.height * 0.05, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).push('/minutes'),
                    child: Card(
                      color: Colors.green.shade200,
                      child: Center(
                        child: Text('Atas', style: TextStyle(fontSize: size.height * 0.05, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
