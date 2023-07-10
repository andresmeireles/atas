import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

// loaders para quando o botão de salvar for pressionado
class MinuteForm extends StatelessWidget {
  const MinuteForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MinuteBloc>();
    final state = bloc.state;
    final mutateState = context.select<MinuteBloc, MinuteState>((value) => value.state);
    final user = context.read<AppBloc>().state.user;

    if (mutateState.errorMessage.isNotEmpty) {
      Fluttertoast.showToast(msg: mutateState.errorMessage);
      bloc.add(ClearErrorMessage());
    }

    return BlocListener<MinuteBloc, MinuteState>(
      listener: (context, state) {
        if (state.status == MinuteBlocStatus.submitted) {
          context.pop();
          context.pop();
          context.pushReplacementNamed(MinuteListController.name);
        }
      },
      child: AppScaffold(
        appBar: AppBar(
          foregroundColor: state.appBarForegroundColor,
          backgroundColor: state.appBarBackgroundColor,
          title: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nova ${translate(state.minute.schema.value)}'),
                Text(translate(state.minute.status.value)),
              ],
            ),
          ),
          actions: mutateState.status == MinuteBlocStatus.submitting
              ? [
                  const Center(
                      child: Padding(padding: EdgeInsets.only(right: 15.0), child: CircularProgressIndicator())),
                ]
              : mutateState.isExpired
                  ? []
                  : [
                      IconButton(onPressed: () async => await _showDialog(context, bloc), icon: const Icon(Icons.add)),
                      IconButton(
                        onPressed: () => bloc.add(SubmitMinuteEvent(user: user)),
                        icon: const Icon(Icons.save_as),
                      ),
                    ],
        ),
        body: mutateState.status == MinuteBlocStatus.submitting
            ? _submitWidget
            : FormHandler(form: state.minute.schema.value),
      ),
    );
  }

  Widget get _submitWidget {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('enviando...'), SizedBox(height: 10), LinearProgressIndicator()],
      ),
    );
  }

  _showDialog(BuildContext context, MinuteBloc bloc) async {
    final meetItem = await showDialog<MeetItem?>(
      context: context,
      builder: (context) => BlocProvider<MinuteBloc>.value(value: bloc, child: const OptionDeciderDialog()),
    );
    if (meetItem == null) return;
    final modalForm = await showDialog<(Types, dynamic)>(
      context: context,
      builder: (context) => AssignmentModalFormHandlerBloc(meetItem),
    );
    if (modalForm == null) return;
    final (type, values) = modalForm;
    bloc.add(AddMinuteItem(type: type, label: meetItem.name, values: values));
  }
}
