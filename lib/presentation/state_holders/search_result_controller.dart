import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class SearchResultController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final RxString searchText = ''.obs;

  Future<List<String>> _fetchImagesFromStorage() async {
    try {
      final ListResult result = await _storage.ref('').listAll();
      final List<String> imageUrls = await Future.wait(result.items.map(
            (Reference ref) async {
          return await ref.getDownloadURL();
        },
      ).toList());
      return imageUrls;
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  Stream<List<String>> get imagesStream async* {
    final List<String> images = await _fetchImagesFromStorage();
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return filterImages(images);
    });
  }

  void setSearchText(String term) {
    searchText.value = term;
  }

  List<String> filterImages(List<String> images) {
    if (searchText.value.isEmpty) {
      return images;
    } else {
      return images
          .where((image) =>
          image.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }
  }
}
