import 'package:formz/formz.dart';

enum CharacterDexterityValidError { error, tooSmall }

class CharacterDexterityValid extends FormzInput<String, CharacterDexterityValidError>{
  const CharacterDexterityValid.pure() : super.pure('');
  const CharacterDexterityValid.dirty([String value = '']) : super.dirty(value);

  @override
  CharacterDexterityValidError? validator(String value) {
    if(value.isEmpty){
      return null;
    }
    int? intValue = int.tryParse(value);
    if(intValue == null){
      return CharacterDexterityValidError.error;
    }
    else if(intValue < 0){
      return CharacterDexterityValidError.tooSmall;
    }

    return null;
  }

}