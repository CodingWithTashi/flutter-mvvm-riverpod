import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_riverpod/home/model/user.dart';
import 'package:flutter_mvvm_riverpod/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(homeRepo: ref.read(repositoryProvider));
});

class HomeViewModel extends ChangeNotifier {
  final HomeRepository homeRepo;
  List<User> userList = [];
  bool isLoading = false;
  HomeViewModel({
    required this.homeRepo,
  });
  Future<void> fetchData() async {
    try {
      isLoading = true;
      // call repository data
      userList = await homeRepo.fetchUser();
      // if no internet you can call local database here
    } catch (exc) {
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }
    isLoading = false;
    notifyListeners();
  }
}
