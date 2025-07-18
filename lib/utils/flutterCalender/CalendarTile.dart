import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import '../../main.dart';

class CalendarTile extends StatefulWidget {
  final VoidCallback? onDateSelected;
  final DateTime? date;
  final String? dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List? events;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final Widget? child;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;

  const CalendarTile({super.key, 
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek = false,
    this.isSelected = false,
    this.inMonth = true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
  });

  @override
  State<CalendarTile> createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (widget.isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.dayOfWeek!,
            style: widget.dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: widget.onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: widget.isSelected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.selectedColor != null
                        ? DateUtils.isSameDay(widget.date!, DateTime.now())
                            ? Colors.green
                            : widget.selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : const BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat("d").format(widget.date!),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: widget.isSelected
                          ? Colors.white
                          : DateUtils.isSameDay(
                                  widget.date!, DateTime.now())
                              ? widget.todayColor
                              : widget.inMonth
                                  ? appStore.isDarkModeOn
                                      ? Colors.white
                                      : Colors.black
                                  : Colors.grey),
                ),
                widget.events != null && widget.events!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.events!.map((event) {
                          eventCount++;
                          // print(event);
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 1.0),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: event["isDone"]
                                  ? widget.isSelected
                                      ? Colors.white
                                      : Colors.green
                                  : widget.isSelected
                                      ? Colors.white38
                                      : Colors.black45,
                            ),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return InkWell(
        onTap: widget.onDateSelected,
        child: widget.child,
      );
    }
    return Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
