import 'package:expertis/models/shop_model.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMBottomSheet.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class SelectServiceComponent extends StatefulWidget {
  Services element;
  // BMServiceListModel element;

  SelectServiceComponent({required this.element});

  @override
  State<SelectServiceComponent> createState() => _SelectServiceComponentState();
}

class _SelectServiceComponentState extends State<SelectServiceComponent> {
  bool isInSelected(id, list) {
    if (list == null) return false;
    print(list);
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      }
    }
    return false;
  }

  bool? selected = false;

  @override
  void initState() {
    AppointmentListViewModel().appointmentModel.selectedServices = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentListViewModel appointmentViewModel =
        Provider.of<AppointmentListViewModel>(context);
    print(
        "selected services: ${appointmentViewModel.appointmentModel.selectedServices}");
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return bmSpecialColor;
      }
      return bmPrimaryColor;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(
                title: widget.element.serviceName ?? '', size: 14, maxLines: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rs ${widget.element.price}+',
                  style: secondaryTextStyle(
                    color: appStore.isDarkModeOn
                        ? bmTextColorDarkMode
                        : bmPrimaryColor,
                    size: 12,
                  ),
                ),
                16.width,
                Text(
                  '${widget.element.time} min',
                  style: secondaryTextStyle(
                    color: appStore.isDarkModeOn
                        ? bmTextColorDarkMode
                        : bmPrimaryColor,
                    size: 12,
                  ),
                ),
              ],
            )
          ],
        ).expand(),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bmPrimaryColor.withAlpha(50),
                borderRadius: radius(100),
                border: Border.all(color: bmPrimaryColor),
              ),
              padding: EdgeInsets.all(6),
              child: InkWell(
                child: Icon(Icons.info, color: bmPrimaryColor),
                onTap: () {
                  showBookBottomSheet(context, widget.element);
                },
              ),
            ),
            8.width,
            Checkbox(
              value: selected,
              fillColor: WidgetStateProperty.resolveWith(getColor),
              onChanged: (value) {
                if (value == true) {
                  appointmentViewModel.appointmentModel.selectedServices
                      .add(widget.element.id.toString());
                  appointmentViewModel.appointmentModel.services == null
                      ? appointmentViewModel.appointmentModel.services = [
                          widget.element
                        ]
                      : appointmentViewModel.appointmentModel.services
                          ?.add(widget.element);
                } else {
                  appointmentViewModel.appointmentModel.selectedServices
                      .remove(widget.element.id.toString());
                  appointmentViewModel.appointmentModel.services
                      ?.remove(widget.element);
                }
                print(appointmentViewModel.appointmentModel.services);

                setState(() {
                  selected = value;
                });
              },
            ),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 8);
  }
}
