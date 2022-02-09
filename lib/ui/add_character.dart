import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_order/business/add_character_bloc.dart';
import 'package:turn_order/model/character.dart';
import 'package:turn_order/model/character_valid/character_dexterity_valid.dart';
import 'package:turn_order/model/character_valid/character_hp_valid.dart';
import 'package:turn_order/model/character_valid/character_initiative_valid.dart';
import 'package:turn_order/model/character_valid/character_name_valid.dart';
import 'package:formz/formz.dart';
import 'package:turn_order/repository/icons_repository.dart';
import 'package:turn_order/ui/element/dialog/select_Icon.dart';
import 'package:turn_order/ui/element/dialog/select_color.dart';

class AddCharacter extends StatelessWidget {
  const AddCharacter({Key? key, this.character}) : super(key: key);
  final Character? character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => character == null? AddCharacterBloc():AddCharacterBloc.character(character!),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const _NextActionButton(),
        bottomNavigationBar: const _HomeBottomAppBar(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(6.0),
            children: const [
              _NameInput(),
              SizedBox(height: 6.0),
              _InitiativeInput(),
              SizedBox(height: 6.0),
              _DexterityInput(),
              SizedBox(height: 6.0),
              _HPInput(),
              SizedBox(height: 6.0),
              _CommentInput(),
              SizedBox(height: 6.0),
              _IConAndColorButton()
            ],
          ),
        ),
      ),
    );
  }

  static Route<Character> route({Character? character}) {
    return MaterialPageRoute(builder: (context) => AddCharacter(character: character));
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        String errorText;
        switch (state.name.error) {
          case CharacterNameValidError.empty:
            errorText = "Введите имя";
            break;
          default:
            errorText = "Некоректное имя";
            break;
        }
        return TextField(
          controller: state.nameController,
          onChanged: (name) =>
              context.read<AddCharacterBloc>().add(CharacterNameChanged(name)),
          decoration: InputDecoration(
            errorText: state.name.invalid ? errorText : null,
            border: const OutlineInputBorder(),
            labelText: 'Имя *',
          ),
        );
      },
    );
  }
}

class _InitiativeInput extends StatelessWidget {
  const _InitiativeInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        String errorText;
        switch (state.initiative.error) {
          case CharacterInitiativeValidError.empty:
            errorText = "Введите инициативу";
            break;
          case CharacterInitiativeValidError.tooSmall:
            errorText = "Инициатива меньше 1";
            break;
          default:
            errorText = "Некоректная инициатива";
            break;
        }
        return TextField(
          controller: state.initiativeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (initiative) => context
              .read<AddCharacterBloc>()
              .add(CharacterInitiativeChanged(initiative)),
          decoration: InputDecoration(
            errorText: state.initiative.invalid ? errorText : null,
            border: const OutlineInputBorder(),
            labelText: 'Инициатива *',
          ),
        );
      },
    );
  }
}

class _DexterityInput extends StatelessWidget {
  const _DexterityInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        String errorText;
        switch (state.dexterity.error) {
          case CharacterDexterityValidError.tooSmall:
            errorText = "Ловкость меньше 0";
            break;
          default:
            errorText = "Некоректная ловкость";
            break;
        }
        return TextField(
          controller: state.dexterityController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (dexterity) => context
              .read<AddCharacterBloc>()
              .add(CharacterDexterityChanged(dexterity)),
          decoration: InputDecoration(
            errorText: state.dexterity.invalid ? errorText : null,
            border: const OutlineInputBorder(),
            labelText: 'Ловкость',
          ),
        );
      },
    );
  }
}

class _HPInput extends StatelessWidget {
  const _HPInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        String errorText;
        switch (state.hp.error) {
          default:
            errorText = "Некоректная ловкость";
            break;
        }
        return TextField(
          controller: state.hpController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (hp) =>
              context.read<AddCharacterBloc>().add(CharacterHPChanged(hp)),
          decoration: InputDecoration(
            errorText: state.hp.invalid ? errorText : null,
            border: const OutlineInputBorder(),
            labelText: 'Здоровье',
          ),
        );
      },
    );
  }
}

class _CommentInput extends StatelessWidget {
  const _CommentInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        String errorText;
        switch (state.comment.error) {
          default:
            errorText = "Некоректная ловкость";
            break;
        }
        return TextField(
          controller: state.commentController,
          minLines: 2,
          maxLines: 10,
          onChanged: (comment) => context
              .read<AddCharacterBloc>()
              .add(CharacterCommentChanged(comment)),
          decoration: InputDecoration(
            errorText: state.comment.invalid ? errorText : null,
            border: const OutlineInputBorder(),
            labelText: 'Коментарий',
          ),
        );
      },
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
          IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _NextActionButton extends StatelessWidget {
  const _NextActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        return FloatingActionButton(
          key: const Key("FloatingActionButton"),
          child: Icon(Icons.add, color: state.status.isValidated ? Colors.white : Colors.white10,),
          onPressed: state.status.isValidated
              ? () => context
                  .read<AddCharacterBloc>()
                  .add(CharacterSubmitted(context))
              : null,
        );
      },
    );
  }
}

class _IConAndColorButton extends StatelessWidget {
  const _IConAndColorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) {
        return Card(
            child: InkWell(
              onTap: ()async {
                IconsName? iconsName = await showDialog(builder: (_) => const SelectIconDialog(), context: context);
                if(iconsName != null){
                  Color? color = await showDialog(builder: (_) => SelectColorDialog(iconsName: iconsName), context: context);
                  if(color != null){
                    context.read<AddCharacterBloc>().add(ColorAndIconChanged(iconsName: iconsName,color: color));
                  }
                }
              },
              child: SizedBox(
                height: 96,
                child: Row(
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          IconsCharacter.getPatchIcon(state.iconsName),
                          color: state.color,
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ));
      },
    );
  }
}