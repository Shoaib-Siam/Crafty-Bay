import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.dart';

class LanguageChangeSwitch extends StatelessWidget {
  const LanguageChangeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.localization.selectLanguage),
      trailing: DropdownMenu<Locale>(
        dropdownMenuEntries: CraftyBay.languageController.supportedLocales
            .map(
              (locale) =>
                  DropdownMenuEntry(value: locale, label: locale.languageCode),
            )
            .toList(),

        onSelected: (Locale? locale) {
          CraftyBay.languageController.changeLocale(locale!);
        },
      ),
    );
  }
}
