import 'package:flutter/widgets.dart';
import 'package:frontend/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n {
    return AppLocalizations.of(this)!;
  }
}
