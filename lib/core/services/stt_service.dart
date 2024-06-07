import 'package:speech_to_text/speech_to_text.dart';

class STTService {
  static late SpeechToText _speechToText;
  static late bool _speechEnabled;
  static List<LocaleName> locales = [];

  static SpeechToText get speechToText => _speechToText;
  static bool get speechEnabled => _speechEnabled;

  STTService._internal();

  static init() async {
    _speechToText = SpeechToText();
    _speechEnabled = await _speechToText.initialize();
    locales = await _speechToText.locales();
  }

  static LocaleName getLocale(String localeId) {
    return locales.firstWhere((locale) => locale.localeId == localeId,
        orElse: () => locales.last);
  }
}
