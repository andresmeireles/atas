import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewMinute extends StatelessWidget {
  const NewMinute({super.key});

  @override
  Widget build(BuildContext context) {
    final minute = Sacramental();
    final state = context.select<MinuteBloc, MinuteState>((MinuteBloc bloc) => bloc.state);
    if (state.status == MinuteStatus.fetching) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<MinuteBloc, MinuteState, MinuteMode>(
          selector: (state) => state.mode,
          builder: (context, state) => Column(children: [const Text('nova ata'), Text(state.name)]),
        ),
        actions: [
          BlocBuilder<MinuteBloc, MinuteState>(
            builder: (_, state) {
              return IconButton(
                onPressed: () async {
                  final minuteType = await showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider<MinuteBloc>.value(
                        value: BlocProvider.of<MinuteBloc>(context),
                        child: ItemSelector(
                          minuteAddedLabels: state.items.map((item) => item.label).toList(),
                          minuteItems: minute.items,
                        ),
                      );
                    },
                  );
                  // when no action is taken minute type will be Null, causing app to crash without this verification
                  if (minuteType == null) return;
                  await showDialog(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<MinuteBloc>(context),
                      child: TypeResolver.resolveWidget(minuteType),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              );
            },
          ),
          BlocConsumer<MinuteBloc, MinuteState>(
            listener: (context, state) {
              final status = state.status;
              if (status == MinuteStatus.errorOnSave) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('erro ao salvar ata')));
                return;
              }
              if (status == MinuteStatus.saved) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ata salva com sucesso!')));
                GoRouter.of(context).go('/home');
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final bloc = context.read<MinuteBloc>();
                  final editedBy = context.read<AppBloc>().state.user;
                  if (state.mode == MinuteMode.updating) {
                    bloc.add(UpdateMinuteEvent());
                    return;
                  }
                  bloc.add(AddMinuteOnFirebaseEvent(editedBy: editedBy, schema: minute));
                },
                icon: const Icon(Icons.check),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MinuteBloc, MinuteState>(
          builder: (context, state) {
            final addedItems = state.items;
            return Column(
              children: minute.items.map((item) {
                final items = addedItems.where((element) => element.label == item.label).toList();
                if (items.isEmpty) return Container();
                return MinuteTile(label: item.label, type: item.type, items: items, fixed: item.fixed);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
