import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';
import '../model/user.dart';

final repositoryProvider =
    Provider<HomeRepository>((_) => HomeRepositoryImpl());

abstract class HomeRepository {
  Future<List<User>> fetchUser();
}

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<List<User>> fetchUser() async {
    // added delay to display loading
    await Future.delayed(const Duration(milliseconds: 1800));
    // fetch data from repo
    final resp = await http.get(Uri.parse(kUserListUrl));
    // decode json
    final data = json.decode(resp.body);
    final userListInMap = data as List<dynamic>;
    // convert list of map to list of user
    return userListInMap
        .map((userMap) => User.fromJson(userMap as Map<String, dynamic>))
        .toList();
  }
}
