import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_share_orange/presentation/state_holders/search_result_controller.dart';
import 'package:snap_share_orange/presentation/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTEController = TextEditingController();
  final SearchResultController _searchResultController = SearchResultController();

  @override
  void initState() {
    super.initState();
    _searchTEController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final searchTerm = _searchTEController.text.toLowerCase();
    _searchResultController.setSearchText(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SearchBox(controller: _searchTEController,),),
      body: StreamBuilder<List<String>>(
        stream: _searchResultController.imagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found'));
          }
          return Obx(() {
            final displayedImages = _searchResultController.filterImages(snapshot.data!);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: displayedImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        displayedImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchTEController.dispose();
    super.dispose();
  }
}
