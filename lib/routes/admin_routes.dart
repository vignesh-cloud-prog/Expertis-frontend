import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/admin_dashboard_screen.dart';
import 'package:expertis/screens/shop_details_screen.dart';
import 'package:expertis/screens/owner_dashboard_screen.dart';
import 'package:expertis/screens/tag_create_update_screen.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AdminLocation extends BeamLocation<BeamState> {
  @override
  Widget builder(BuildContext context, Widget navigator) =>
      ChangeNotifierProvider<ShopViewModel>.value(
        value: ShopViewModel(),
        child: navigator,
      );
  @override
  List<String> get pathPatterns => [
        RoutesName.adminDashboard,
        RoutesName.adminShops,
        RoutesName.adminTags,
        RoutesName.adminUsers,
        RoutesName.createTag,
        RoutesName.updateTag,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uri.pathSegments.contains('admin') &&
          state.uri.pathSegments.contains('dashboard'))
        BeamPage(
          key: const ValueKey(RoutesName.adminDashboard),
          title: 'Admin Dashboard',
          child: AdminDashBoardScreen(),
        ),
      if (state.uri.pathSegments.contains('admin') &&
          state.uri.pathSegments.contains('shops'))
        BeamPage(
          key: const ValueKey(RoutesName.adminShops),
          title: 'All Shops',
          child: AdminDashBoardScreen(
            tabNo: 1,
          ),
        ),
      if (state.uri.pathSegments.contains('admin') &&
          state.uri.pathSegments.contains('users'))
        BeamPage(
          key: const ValueKey(RoutesName.adminUsers),
          title: 'All Users',
          child: AdminDashBoardScreen(
            tabNo: 2,
          ),
        ),
      if (state.uri.pathSegments.contains('admin') &&
          state.uri.pathSegments.contains('tags'))
        BeamPage(
          key: const ValueKey(RoutesName.adminTags),
          title: 'All Tags',
          child: AdminDashBoardScreen(tabNo: 3),
        ),
      if (state.uri.pathSegments.contains('tag') &&
          state.uri.pathSegments.contains('admin') &&
          state.uri.pathSegments.contains('create'))
        const BeamPage(
          key: ValueKey(RoutesName.createTag),
          title: 'Create Tag',
          child: CreateUpdateTagScreen(),
        ),
      if (state.uri.pathSegments.contains('tag') &&
          state.uri.pathSegments.contains('update') &&
          state.pathParameters.containsKey('tagId'))
        BeamPage(
          key: ValueKey('Update ${state.pathParameters['tagId']}'),
          title: 'Update ${state.pathParameters['tagId']}',
          child: CreateUpdateTagScreen(
            tagId: state.pathParameters['tagId'],
          ),
        ),
    ];
  }
}
