import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MinuteEditor extends StatelessWidget {
  const MinuteEditor({super.key});

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
          ToAdd(minute),
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
            listener: (context, state) async {
              final status = state.status;
              final router = GoRouter.of(context);
              if (status == MinuteStatus.errorOnSave) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error ?? 'erro ao salvar ata')),
                );
                return;
              }
              if (status == MinuteStatus.saved) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ata salva com sucesso!')));
                router.push('/home');
                return;
              }
              if (status == MinuteStatus.updated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ata atualizada com sucesso!')),
                );
                router.push('/home');
                return;
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final bloc = context.read<MinuteBloc>();
                  final editedBy = context.read<AppBloc>().state.user;
                  final isUpdate = state.mode == MinuteMode.updating || state.mode == MinuteMode.draw;
                  bloc.add(AddMinuteOnFirebaseEvent(editedBy: editedBy, schema: minute, isUpdate: isUpdate));
                },
                icon: const Icon(Icons.check),
              );
            },
          ),
        ],
      ),
      body: state.status == MinuteStatus.saving ? _saving() : _editor(context, minute),
    );
  }

  Widget _saving() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [CircularProgressIndicator(), SizedBox(height: 20), Text('Salvando')],
      ),
    );
  }

  Widget _editor(BuildContext context, SchemaInterface minute) {
    return SingleChildScrollView(
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
    );
  }
}
