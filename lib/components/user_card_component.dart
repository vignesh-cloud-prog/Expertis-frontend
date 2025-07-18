import 'package:beamer/beamer.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/user_list_view_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:store_api_flutter_course/consts/global_colors.dart';

class UserCardComponent extends StatelessWidget {
  final UserModel? element;

  const UserCardComponent({super.key, required this.element});
  @override
  Widget build(BuildContext context) {
    UserListViewModel userListViewModel =
        Provider.of<UserListViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: Image.asset('assets/image-not-found.jpg',
            fit: BoxFit.cover,
            width: size.width * 0.15,
            height: size.width * 0.15),
        imageUrl: element?.userPic == "null" || element?.userPic == ""
            ? Assets.defaultUserImage
            : element?.userPic ?? Assets.defaultServiceImage,
        boxFit: BoxFit.fill,
      ).cornerRadiusWithClipRRect(100),
      title: Text(element?.name ?? ""),
      subtitle: Text(element?.email ?? ""),
      trailing: SizedBox(
        height: size.width * 0.25,
        width: size.width * 0.30,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Beamer.of(context)
                  .beamToNamed(RoutesName.adminUserEditProfile, data: element);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              userListViewModel.deleteUserApi(element?.id, context);
            },
          ),
        ]),
      ),
    );
  }
}
