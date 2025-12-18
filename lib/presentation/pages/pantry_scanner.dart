import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchen_confidant/domain/repositories/pantry_repository.dart';

class PantryScanner {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final PantryRepository _pantryRepository;

  PantryScanner(this._pantryRepository);

  Future<List<String>> scanReceipt() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return [];

    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await _textRecognizer.processImage(
      inputImage,
    );

    // Extract lines of text (usually items on a receipt)
    List<String> items = [
      'book',
      'pen',
      'rice',
      'clove',
      'lemon',
      'salt',
      'tomato',
      'chilly',
    ];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        items.add(line.text.toLowerCase());
      }
    }
    print('objects scanned from receipt: $items');
    // Delegate the API call to the repository
    await _pantryRepository.sendItemsToApi(items);

    return items;
  }
}
