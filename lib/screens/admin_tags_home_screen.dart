import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AdminTagsHomeScreen extends StatefulWidget {
  AdminTagsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminTagsHomeScreen> createState() => _AdminTagsHomeScreenState();
}

class _AdminTagsHomeScreenState extends State<AdminTagsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('AdminTagsHomeScreen'),
          AppButton(
            text: 'Add Categpry',
            onTap: () {
              Beamer.of(context).beamToNamed(RoutesName.createTag);
            },
          )
        ],
      ),
    );
  }
}
