// /*
// import 'dart:typed_data';
//
// import 'package:file_picker/file_picker.dart';
// import "package:flutter/material.dart";
// import 'package:google_ml_kit/google_ml_kit.dart';
//
// class MachineLearning extends StatefulWidget {
//   const MachineLearning({super.key});
//
//   @override
//   State<MachineLearning> createState() => _MachineLearningState();
// }
//
// class _MachineLearningState extends State<MachineLearning> {
//   TextEditingController message = TextEditingController();
//   String languageIdentifier = "";
//   LanguageIdentifier lang = LanguageIdentifier(confidenceThreshold: 0.4);
//   ImageLabeler labeler =
//       ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.4));
//   late InputImage image;
//   Uint8List? bytesImage;
//   String result = "";
//
//   identificationLanguage() async {
//     if (message.text != "") {*
//       String msg = await lang.identifyLanguage(message.text);
//
//       setState(() {
//         languageIdentifier = "The language detected is $msg";
//       });
//     }
//   }
//
//   multipleLanguages() async {
//     if (message.text != "") {
//       List<IdentifiedLanguage> sentenceList =
//           await lang.identifyPossibleLanguages(message.text);
//
//       for (IdentifiedLanguage label in sentenceList) {
//         setState(() {
//           languageIdentifier =
//               "The language ${label.languageTag} is detected with an indice of truth of ${(label.confidence * 100).toInt()} %";
//         });
//       }
//     }
//   }
//
//   pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       withData: true,
//     );
//
//     if (result != null) {
//       bytesImage = result.files.first.bytes;
//       image = InputImage.fromFilePath(result.files.first.path!);
//     }
//   }
//
//   processing() async {
//     pickImage();
//     List images = await labeler.processImage(image);
//
//     for (ImageLabel img in images) {
//       result +=
//           "${img.label}with trust indice of ${(img.confidence * 100).toInt()}}%";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 100),
//         TextField(
//           controller: message,
//         ),
//         ElevatedButton(
//             onPressed: identificationLanguage,
//             child: const Text("Check language used")),
//         ElevatedButton(
//             onPressed: multipleLanguages,
//             child: const Text("Check multiple languages")),
//         ElevatedButton(onPressed: processing, child: const Text("Check image")),
//         Text(languageIdentifier),
//         Text(result)
//       ],
//     );
//   }
// }
// */
