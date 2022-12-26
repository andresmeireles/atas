import 'package:flutter/material.dart';

class CreatedMinutes extends StatelessWidget {
  const CreatedMinutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // final api = Minutes();
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: FutureBuilder(
    //     future: api.all(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           return Center(child: Text(snapshot.error.toString()));
    //         }
    //         if (!snapshot.hasData) {
    //           return const Center(child: Text('nao tem data'));
    //         }
    //         final data = snapshot.data!;
    //         return data.when(
    //           (success) => Container(),
    //           (error) => Center(child: Text(error)),
    //         );
    //       }
    //       return const Center(child: CircularProgressIndicator());
    //     },
    //   ),
    // );
  }

  // Widget _minutesList(List<Minute> minutes) {
  //   return ListView.builder(
  //     itemCount: minutes.length,
  //     itemBuilder: (context, index) {
  //       final minute = minutes[index];
  //       return ListTile(title: Text('Ata do dia ${minute.createdAt}'));
  //     },
  //   );
  // }
}
