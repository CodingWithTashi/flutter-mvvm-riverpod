import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/home/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/home_repository.dart';
import '../view_model/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomeViewModel viewModel;
  @override
  void initState() {
    // initiate view model
    viewModel = ref.read(homeViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call view model fetch data
      viewModel.fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeViewModelProvider);
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<User> userList = state.userList;
          if (userList.isEmpty) {
            return const Center(
              child: Text('No user found'),
            );
          }
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final User user = userList[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                leading: const Icon(
                  Icons.person,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
