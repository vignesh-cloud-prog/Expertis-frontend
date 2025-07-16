import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PurchaseMoreScreen extends StatelessWidget {
  final bool? enableAppbar;

  const PurchaseMoreScreen({super.key, this.enableAppbar = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bmLightScaffoldBackgroundColor,
        body: Stack(
          children: [
            const Icon(Icons.arrow_back, size: 24).paddingAll(16).onTap(() {
              finish(context);
            }).visible(enableAppbar!),
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: boxDecorationDefault(),
                    padding: const EdgeInsets.all(16),
                    child: Image.asset("images/beautymaster_logo.png",
                        height: 100),
                  ),
                  22.height,
                  Text(
                    'This is the lite version of the  App',
                    style: boldTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                  16.height,
                  AppButton(
                    text: 'Explore Later',
                    color: context.primaryColor,
                    textStyle: boldTextStyle(color: Colors.white),
                    shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius(10)),
                    onTap: () {
                      Beamer.of(context).beamToNamed(RoutesName.home);
                    },
                  )
                ],
              ),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
