import 'package:atas/src/core/widget/widget.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectMinuteToCreate extends StatefulWidget {
  final Meet meetApi;

  const SelectMinuteToCreate({required this.meetApi, super.key});

  @override
  State<SelectMinuteToCreate> createState() => _SelectMinuteToCreateState();
}

class _SelectMinuteToCreateState extends State<SelectMinuteToCreate> {
  bool _loading = true;
  bool _noTypes = false;
  final _types = <MeetType>[];

  @override
  void initState() {
    super.initState();
    widget.meetApi.types.then((value) {
      value.when((success) => _setup(success), (error) => _setNoType);
    });
  }

  _setup(List<MeetType> types) {
    _types.clear();
    _types.addAll(types);
    setState(() {
      _loading = false;
    });
  }

  get _setNoType {
    setState(() {
      _loading = false;
      _noTypes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Selecione o tipo de ata')),
      body: _loading ? const Center(child: CircularProgressIndicator()) : _view,
    );
  }

  Widget get _view => _noTypes ? _error : _listTypes;

  Widget get _error => const Center(child: Text('Não foi possível carregar os tipos de ata'));

  Widget get _listTypes {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _types.length,
        itemBuilder: (context, index) {
          final type = _types[index];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              title: Text(type.name.toUpperCase()),
              onTap: () => context.push(AddMinuteController.path(type.id)),
            ),
          );
        });
  }
}
