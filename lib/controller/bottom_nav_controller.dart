import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavControllerProvider =
    StateNotifierProvider<BottomNavController, int>((ref) {
      return BottomNavController();
    });

class BottomNavController extends StateNotifier<int> {
  BottomNavController() : super(0); // default to index 0

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}
