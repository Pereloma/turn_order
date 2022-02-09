import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_order/business/turn_bloc.dart';
import 'package:turn_order/model/character.dart';
import 'package:turn_order/repository/icons_repository.dart';
import 'package:turn_order/ui/add_character.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => TurnBloc(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const _NextActionButton(),
        bottomNavigationBar: const _HomeBottomAppBar(),
        body: SafeArea(
          child: BlocBuilder<TurnBloc, TurnState>(
            builder: (context, state) {
              return Stack(
                children: [
                  ListView(children: [
                    ...state.characters.map((e) => _CharacterCard(e)).toList(),
                    ...state.waitCharacters
                        .map((e) =>
                        _CharacterCard(
                          e,
                          characterType: CharacterType.wait,
                        ))
                        .toList()
                  ]),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Круг: ${state.lap + 1},  Ход: ${state.move + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeBottomAppBar extends StatelessWidget {
  const _HomeBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      key: const Key("BottomAppBar"),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const IconButton(
            tooltip: 'Меню',
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
          const SizedBox(width: 16),
          IconButton(
            tooltip: 'Добавить персонажа',
            icon: const Icon(Icons.person_add),
            onPressed: () async {
              final Character? result =
              await Navigator.of(context).push(AddCharacter.route());
              if (result != null) {
                context.read<TurnBloc>().add(AddCharacterInTurnEvent(result));
              }
            },
          ),
          const Spacer(),
          BlocBuilder<TurnBloc, TurnState>(
            builder: (context, state) {
              return IconButton(
                  tooltip: 'Отмена',
                  icon: const Icon(Icons.navigate_before),
                  onPressed: state.previousState != null ? () =>
                      context.read<TurnBloc>().add(BackStateTurnEvent())
                      : null
              );
            },
          ),
          const SizedBox(width: 72),
        ],
      ),
    );
  }
}

class _NextActionButton extends StatelessWidget {
  const _NextActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TurnBloc, TurnState>(
      builder: (context, state) {
        return FloatingActionButton(
          key: const Key("FloatingActionButton"),
          child: Icon(Icons.navigate_next,
              color:
              state.characters.length > 1 ? Colors.white : Colors.white10),
          onPressed: state.characters.length > 1
              ? () => context.read<TurnBloc>().add(NextCharacterTurnEvent())
              : null,
        );
      },
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final Character _character;
  final CharacterType? characterType;

  const _CharacterCard(this._character, {this.characterType});

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (characterType == CharacterType.wait) {
      color = Colors.black45;
    } else if (characterType == CharacterType.dead) {
      color = Colors.red.shade400;
    }

    return Dismissible(
      onDismissed: (_) =>
          context
              .read<TurnBloc>()
              .add(DismissibleCharacterTurnEvent(_character)),
      key: Key(
          "${_character.name}_${characterType ?? 0}_${_character.initiative}"),
      child: Card(
          child: InkWell(
            onTap: () async {
              final Character? result = await Navigator.of(context)
                  .push(AddCharacter.route(character: _character));
              if (result != null) {
                context
                    .read<TurnBloc>()
                    .add(EditCharacterTurnEvent(_character, result));
              }
            },
            child: SizedBox(
              height: 96,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    width: 96,
                    height: 96,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        IconsCharacter.getPatchIcon(_character.iconsName),
                        color: _character.color,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(_character.name,
                                    style: const TextStyle(fontSize: 32)))),
                        Flexible(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("HP: ${_character.hp ?? "-"}",
                                    style: const TextStyle(fontSize: 16)),
                                Text("Initiative: ${_character.initiative}",
                                    style: const TextStyle(fontSize: 16)),
                                Text("Queue: ${_character.queue ?? "-"}",
                                    style: const TextStyle(fontSize: 16))
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

enum CharacterType { normal, wait, dead }
