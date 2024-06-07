import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

Future<String?> dialogRecordBuilder(BuildContext context,
    SpeechToText speechToText, LocaleName selectedLocale) {
  final TextEditingController textController = TextEditingController();
  bool isFirstOpen = true;
  String _lastWords = '';
  void stopListening(VoidCallback callback) async {
    await speechToText.stop();
    callback();
  }

  void onSpeechResult(
      SpeechRecognitionResult result, Function(String) callback) {
    _lastWords = result.recognizedWords;
    callback(_lastWords);
  }

  void startListening(VoidCallback callback) async {
    isFirstOpen = false;
    await speechToText.listen(
      onResult: (result) => onSpeechResult(
        result,
        (value) {
          textController.text = value;
        },
      ),
      listenFor: const Duration(minutes: 1),
      localeId: selectedLocale.localeId,
    );
    callback();
  }

  return showDialog<String?>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Material(
          color: Colors.black.withOpacity(0.6),
          child: StatefulBuilder(builder: (context, setState) {
            speechToText.statusListener = (status) {
              if (status == 'done') {
                setState(() {});
              }
            };
            if (isFirstOpen) {
              startListening(() {
                setState(() {});
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Đang ghi âm...',
                    ),
                    controller: textController,
                    maxLines: 12,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                speechToText.isNotListening
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  side: BorderSide(
                                      color: Colors.grey.shade300, width: 1.5),
                                ),
                                onPressed: () {
                                  textController.clear();
                                  startListening(
                                    () {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: const Text('Thử lại'),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  stopListening(() {
                                    setState(() {});
                                  });
                                  Navigator.of(context)
                                      .pop(textController.text);
                                },
                                child: const Text('Hoàn tất'),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 75,
                        width: 75,
                        child: FloatingActionButton(
                          onPressed: speechToText.isNotListening
                              ? () {
                                  textController.clear();
                                  startListening(() {
                                    setState(() {});
                                  });
                                }
                              : () {
                                  stopListening(() {
                                    setState(() {});
                                  });
                                },
                          tooltip: 'Listen',
                          heroTag: null,
                          mini: false,
                          child: Icon(
                            // speechToText.isListening ? Icons.stop : Icons.mic,
                            speechToText.isListening ? Icons.stop : Icons.mic,
                            color: Colors.white,
                            size: 40,
                          ), // Set mini to false to make the button bigger
                        ),
                      ),
              ],
            );
          }),
        );
      });
}
