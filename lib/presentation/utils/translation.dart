import 'package:get/get.dart';

class Translation extends Translations {
  static const titleKey = 'title';
  static const subtitleKey = 'card_subtitle';

  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      titleKey: 'Cat Facts',
      subtitleKey: 'A fun fact about cats!',
    },
    'id': {
      titleKey: 'Fakta Kucing',
      subtitleKey: 'Fakta menarik tentang kucing!',
    }
  };
}
