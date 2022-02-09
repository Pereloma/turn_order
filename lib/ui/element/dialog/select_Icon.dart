import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_order/repository/icons_repository.dart';
import 'package:turn_order/ui/element/dialog/select_color.dart';

class SelectIconDialog extends StatelessWidget {
  const SelectIconDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Выберите иконку"),
      content: SingleChildScrollView(
          child: Center(
              child: Wrap(
                  children:
                      IconsName.values.map((e) => IconCard(e)).toList()))),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconsName iconsName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap:  () => Navigator.of(context).pop(iconsName),
        child: SizedBox(
          width: 96,
          height: 96,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              IconsCharacter.getPatchIcon(iconsName),
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  const IconCard(this.iconsName, {Key? key}) : super(key: key);
}
