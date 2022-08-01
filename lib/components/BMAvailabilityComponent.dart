import 'package:expertis/models/shop_model.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMAvailabilityComponent extends StatefulWidget {
  List<Services>? selectedServices;

  BMAvailabilityComponent({Key? key, required this.selectedServices})
      : super(key: key);

  @override
  _BMAvailabilityComponentState createState() =>
      _BMAvailabilityComponentState();
}

class _BMAvailabilityComponentState extends State<BMAvailabilityComponent> {
  @override
  Widget build(BuildContext context) {
    AppointmentListViewModel appointmentViewModel =
        Provider.of<AppointmentListViewModel>(context);

    if (widget.selectedServices == null) {
      widget.selectedServices = appointmentViewModel.appointmentModel.services;
    }
    print(appointmentViewModel.appointmentModel.services);
    double totalCost = 0.0;
    int totalTime = 0;
    appointmentViewModel.appointmentModel.services?.forEach((element) {
      totalCost += double.parse(element.price.toString());
      totalTime += int.parse(element.time.toString());
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleText(title: "Services"),
        10.height,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.selectedServices
                  ?.map((e) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  titleText(
                                      title: e.serviceName ?? '',
                                      size: 16,
                                      maxLines: 1),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rs ${e.price?.toString()}',
                                          style: secondaryTextStyle(
                                              color: bmPrimaryColor, size: 16)),
                                      4.width,
                                      Text('${e.time} min',
                                          style: secondaryTextStyle(
                                              color: bmPrimaryColor, size: 14)),
                                      10.width,
                                    ],
                                  )
                                ],
                              ),
                              10.width,
                              IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: bmPrimaryColor,
                                ),
                                onPressed: () {
                                  appointmentViewModel.appointmentModel.services
                                      ?.remove(e);
                                  setState(() {});
                                  super.setState(() {});
                                  ;
                                },
                              ),
                            ],
                          )
                        ],
                      ))
                  .toList() ??
              [Center(child: Text('No services selected'))],
        ),
        10.height,
        titleText(title: "Summary"),
        10.height,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Time: "),
                Text("${totalTime} min"),
              ],
            ),
            2.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price: "),
                Text("${totalCost} Rs"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
