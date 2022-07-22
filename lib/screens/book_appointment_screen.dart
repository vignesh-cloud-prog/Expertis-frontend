import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMAvailabilityComponent.dart';
import 'package:expertis/models/BMServiceListModel.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BookAppointmentScreen extends StatefulWidget {
  BMServiceListModel? element =
      BMServiceListModel(name: "haircut", cost: "100", time: "20");
  bool isStaffBooking = false;
  String? shopId;

  BookAppointmentScreen({Key? key, this.shopId}) : super(key: key);

  @override
  BookAppointmentScreenState createState() => BookAppointmentScreenState();
}

class BookAppointmentScreenState extends State<BookAppointmentScreen> {
  AppointmentListViewModel appointmentViewModel = AppointmentListViewModel();
  List<BMServiceListModel> availabilityList = [];
  String selectedSlot = "";

  int selectedTimer = 0;
  String openingTime = "08:00:AM";
  String closingTime = "08:00:PM";
  List<int> bookedSlot = [];
  int getSlotNoByTime(String time) {
    int hour = int.parse(time.split(":")[0]);
    int min = int.parse(time.split(":")[1]);
    String day = time.split(":")[2];
    if (day.toLowerCase() == "pm") {
      if (hour < 12) {
        hour += 12;
      }
    }
    int slotNo = hour * 2 + min ~/ 30;
    return slotNo;
  }

  String getTimeBySlotNo(int slotNo) {
    int hour = slotNo ~/ 2;
    int min = (slotNo % 2) * 30;
    String day = "AM";
    if (hour >= 12) {
      day = "PM";
    }
    if (hour > 12) {
      hour -= 12;
    }
    return "${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:$day";
  }

  List<String>? getAvailableTimes() {
    List<String> times = [];
    DateTime now = DateTime.now();
    String currentTime = DateFormat("HH:mm:a").format(now);
    // print(currentTime);

    for (int i = 0; i < 24 * 2; i++) {
      if (_bookingDateController.text ==
              DateFormat('dd-MMM-yyyy').format(DateTime.now()) &&
          i <= getSlotNoByTime(currentTime)) {
        continue;
      }
      if (i < getSlotNoByTime(openingTime) ||
          i >= getSlotNoByTime(closingTime)) {
        continue;
      }
      if (bookedSlot.contains(i)) {
        continue;
      }
      times.add(getTimeBySlotNo(i));
    }
    if (times.isEmpty) {
      return null;
    }
    return times;
  }

  List<String> availableTimes = [];

  List<String> timers = [
    'Anytime',
    'Morning',
    'Afternoon',
    'Evening',
    'Special time'
  ];

  String getYear() {
    return new DateFormat.yMMM().format(DateTime.now());
  }

  FocusNode dob = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _bookingDateController = TextEditingController();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    setState(() {
      _bookingDateController.text =
          DateFormat('dd-MMM-yyyy').format(DateTime.now());
      bookedSlot = appointmentViewModel.slots;
    });
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentListViewModel appointmentViewModel =
        Provider.of<AppointmentListViewModel>(context);
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    // print(appointmentViewModel.slots);
    // print(appointmentViewModel.appointmentModel.memberId);
    // print(appointmentViewModel.appointmentModel.services);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bmSpecialColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
        title: Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title: 'Select Date'),
                    AppTextField(
                      focus: dob,
                      readOnly: true,
                      textFieldType: TextFieldType.OTHER,
                      suffix: InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 90)),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              var date =
                                  DateFormat('dd-MMM-yyyy').format(pickedDate);

                              _bookingDateController.text = date;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.calendar_today,
                          color: bmPrimaryColor,
                        ),
                      ),
                      nextFocus: null,
                      controller: _bookingDateController,
                      errorThisFieldRequired: 'DOB is required',
                      cursorColor: bmPrimaryColor,
                      textStyle: boldTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmPrimaryColor),
                      suffixIconColor: bmPrimaryColor,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                      ),
                    ),
                    // bookStaff(),
                    bookAppointment(context),
                    20.height,
                    Row(
                      children: [
                        AppButton(
                          // enabled: !authViewMode.loading,
                          disabledColor: bmPrimaryColor,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            if (kDebugMode) {
                              print('selected slot $selectedSlot');
                              print(
                                  'selected date ${_bookingDateController.text}');
                              print('User id ${userViewModel.user.id}');
                              print(
                                  'Member id ${appointmentViewModel.appointmentModel.memberId}');
                              print(
                                  'Services ${appointmentViewModel.appointmentModel.selectedServices}');
                              print('shop id ${widget.shopId}');
                            }
                            if (selectedSlot == "") {
                              Utils.flushBarErrorMessage(
                                  'Please select a slot', context);
                              return;
                            }
                            if (_bookingDateController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                  'Please select a date', context);
                              return;
                            }
                            if (appointmentViewModel
                                .appointmentModel.selectedServices.isEmpty) {
                              Utils.flushBarErrorMessage(
                                  'Please select atleast one service', context);
                              return;
                            }
                            List months = [
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec'
                            ];
                            String date = _bookingDateController.text;
                            String year = date.split('-')[2].toString();
                            String monthName = date.split('-')[1];
                            String month = '${months.indexOf(monthName) + 1}';

                            String day = date.split('-')[0];
                            String hour = selectedSlot.split(':')[0];
                            String minute = selectedSlot.split(':')[1];
                            String ampm = selectedSlot.split(':')[2];
                            ampm.toLowerCase() == "pm" && hour.toInt() < 12
                                ? hour = '${hour.toInt() + 12}'
                                : hour = hour;

                            DateTime bookingDate = DateTime(
                                int.parse(year),
                                int.parse(month),
                                int.parse(day),
                                int.parse(hour),
                                int.parse(minute));
                            print('booking time $bookingDate');
                            Map data = {
                              'memberId': appointmentViewModel
                                  .appointmentModel.memberId,
                              'userId': userViewModel.user.id,
                              'shopId': widget.shopId,
                              'startTime': bookingDate.toString(),
                              'services': appointmentViewModel
                                  .appointmentModel.selectedServices,
                            };
                            if (kDebugMode) {
                              print(data.toString());
                            }
                            appointmentViewModel.BookAppointment(
                                jsonEncode(data), context);
                          },
                          child: Text("Book Appointment ",
                              style: boldTextStyle(color: Colors.white)),
                        ).expand(),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }

  Widget bookAppointment(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title: 'Availability'),
        16.height,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: getAvailableTimes()?.map((e) {
                int index = getAvailableTimes()!.indexOf(e);
                if (index == 0) {
                  selectedSlot = e;
                }
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedTimer == index
                        ? bmPrimaryColor
                        : bmPrimaryColor.withAlpha(50),
                    borderRadius: radius(32),
                    border: Border.all(color: bmPrimaryColor),
                  ),
                  child: Text(e,
                      style: primaryTextStyle(
                          color: selectedTimer == index
                              ? Colors.white
                              : appStore.isDarkModeOn
                                  ? Colors.white
                                  : bmSpecialColorDark)),
                ).onTap(() {
                  selectedTimer = index;
                  setState(() {
                    selectedSlot = e;
                  });
                });
              }).toList() ??
              [
                Center(
                  child: Text("Slots are not available for the day"),
                )
              ],
        ),
        16.height,
        Divider(),
        16.height,
        BMAvailabilityComponent(
            element: appointmentViewModel.appointmentModel.services),
        16.height,
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bmPrimaryColor.withAlpha(50),
            borderRadius: radius(32),
            border: Border.all(color: bmPrimaryColor),
          ),
          child: Text(' + Add another Services',
              style: primaryTextStyle(
                  color: appStore.isDarkModeOn
                      ? Colors.white
                      : bmSpecialColorDark)),
        ).onTap(() {
          // finish(context);
          // finish(context);
        }),
      ],
    );
  }

  Widget bookStaff() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title: 'Staff'),
        16.height,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: timers.map((e) {
            int index = timers.indexOf(e);
            return Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedTimer == index
                    ? bmPrimaryColor
                    : bmPrimaryColor.withAlpha(50),
                borderRadius: radius(32),
                border: Border.all(color: bmPrimaryColor),
              ),
              child: Text(e,
                  style: primaryTextStyle(
                      color: selectedTimer == index
                          ? Colors.white
                          : appStore.isDarkModeOn
                              ? Colors.white
                              : bmSpecialColorDark)),
            ).onTap(() {
              selectedTimer = index;
              setState(() {});
            });
          }).toList(),
        ),
      ],
    );
  }
}
