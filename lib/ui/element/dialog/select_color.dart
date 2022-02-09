import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_order/repository/icons_repository.dart';

class SelectColorDialog extends StatelessWidget {
  final IconsName iconsName;
  const SelectColorDialog({Key? key,required this.iconsName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Выберите цвет иконки"),
      content: SingleChildScrollView(
          child: Center(
              child: Wrap(
                  children:
                  [
                    IconCard(iconsName,Colors.black),
                    IconCard(iconsName,Colors.yellow),
                    IconCard(iconsName,Colors.red),
                    IconCard(iconsName,Colors.blue),
                    IconCard(iconsName,Colors.orange),
                    IconCard(iconsName,Colors.purple),
                    IconCard(iconsName,Colors.green)
                  ]),
          )),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconsName iconsName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).pop(color),
        child: SizedBox(
          width: 96,
          height: 96,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              IconsCharacter.getPatchIcon(iconsName),
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  const IconCard(this.iconsName,this.color, {Key? key}) : super(key: key);
}
