import 'package:expertis/responsive.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/widgets/header.dart';
import 'package:expertis/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils.getScreenSize(context);
    return Scaffold(
      // key: context.read<MenuController>().getOrdersScaffoldKey,
      drawer: Container(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Container(),
              ),
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Header(
                        showTexField: false,
                        fct: () {
                          // context.read<MenuController>().controlAllOrder();
                        },
                        title: 'All Orders',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OrdersList(
                          isInDashboard: false,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
