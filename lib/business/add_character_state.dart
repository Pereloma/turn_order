part of 'add_character_bloc.dart';

@immutable
class AddCharacterState extends Equatable {
  final FormzStatus status;
  final CharacterNameValid name;
  final CharacterInitiativeValid initiative;
  final CharacterDexterityValid dexterity;
  final CharacterHPValid hp;
  final CharacterCommentValid comment;

  final TextEditingController? nameController;
  final TextEditingController? initiativeController;
  final TextEditingController? dexterityController;
  final TextEditingController? hpController;
  final TextEditingController? commentController;

  final IconsName iconsName;
  final Color color;

  const AddCharacterState(
      {this.nameController,
      this.initiativeController,
      this.dexterityController,
      this.hpController,
      this.commentController,
      this.status = FormzStatus.pure,
      this.name = const CharacterNameValid.pure(),
      this.initiative = const CharacterInitiativeValid.pure(),
      this.dexterity = const CharacterDexterityValid.pure(),
      this.hp = const CharacterHPValid.pure(),
      this.comment = const CharacterCommentValid.pure(),
      this.iconsName = IconsName.weapon_30,
      this.color = Colors.black});

  static AddCharacterState stateFromCharacter(Character character) {
    String name = character.name;
    String initiative = character.initiative.toString();
    String dexterity = character.dexterity.toString();
    String hp = character.hp == null ? "" : character.hp.toString();
    String comment = character.comment ?? "";

    CharacterNameValid nameValid = CharacterNameValid.dirty(name);
    CharacterInitiativeValid initiativeValid =
        CharacterInitiativeValid.dirty(initiative);
    CharacterDexterityValid dexterityValid =
        CharacterDexterityValid.dirty(dexterity);
    CharacterHPValid hpValid = CharacterHPValid.dirty(hp);
    CharacterCommentValid commentValid = CharacterCommentValid.dirty(comment);
    return AddCharacterState(
        nameController: TextEditingController()..text = name,
        initiativeController: TextEditingController()..text = initiative,
        dexterityController: TextEditingController()..text = dexterity,
        hpController: TextEditingController()..text = hp,
        commentController: TextEditingController()..text = comment,
        name: nameValid,
        initiative: initiativeValid,
        dexterity: dexterityValid,
        hp: hpValid,
        comment: commentValid,
        status: Formz.validate([
          nameValid,
          initiativeValid,
          dexterityValid,
          hpValid,
          commentValid
        ]),
        color: character.color,
        iconsName: character.iconsName);
  }

  AddCharacterState copyWith(
      {FormzStatus? status,
      CharacterNameValid? name,
      CharacterInitiativeValid? initiative,
      CharacterDexterityValid? dexterity,
      CharacterHPValid? hp,
      CharacterCommentValid? comment,
      IconsName? iconsName,
      Color? color}) {
    return AddCharacterState(
        status: status ?? this.status,
        name: name ?? this.name,
        initiative: initiative ?? this.initiative,
        dexterity: dexterity ?? this.dexterity,
        hp: hp ?? this.hp,
        comment: comment ?? this.comment,
        iconsName: iconsName ?? this.iconsName,
        color: color ?? this.color);
  }

  @override
  List<Object?> get props => [status, name, initiative, dexterity, hp, comment, iconsName, color];
}
