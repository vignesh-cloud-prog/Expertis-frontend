import 'package:expertis/components/user_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/main.dart';
import 'package:expertis/view_model/user_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AdminUsersHomeScreen extends StatefulWidget {
  AdminUsersHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersHomeScreen> createState() => _AdminUsersHomeScreenState();
}

class _AdminUsersHomeScreenState extends State<AdminUsersHomeScreen> {
  final userListViewModel = UserListViewModel();
  @override
  void initState() {
    userListViewModel.fetchUserData(); //widget.shopId

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider<UserListViewModel>.value(
        value: userListViewModel,
        child: Consumer<UserListViewModel>(builder: (context, value, _) {
          switch (value.userList.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              print("error");
              return Center(
                child: Text(value.userList.message.toString()),
              );
            case Status.COMPLETED:
              print("value to jason ${value.userList.data?.toJson()}");
              print("printed to string ${value.userList.data.toString()}");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.userList.data?.users?.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: appStore.isDarkModeOn ? white : white,
                          borderRadius: radius(20)),
                      child: UserCardComponent(
                          element: value.userList.data?.users![index]),
                    ).paddingAll(8);
                  });
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
