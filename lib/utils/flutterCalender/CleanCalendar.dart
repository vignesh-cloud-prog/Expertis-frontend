import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'CalendarTile.dart';
import 'SimpleGestureDetector.dart';
import 'date_utils.dart';

typedef DayBuilder = Function(BuildContext context, DateTime day);

class Range {
  final DateTime from;
  final DateTime? to;

  Range(this.from, this.to);
}

class Calendar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged? onRangeSelected;
  final bool isExpandable;
  final DayBuilder? dayBuilder;
  final bool hideArrows;
  final bool hideTodayIcon;
  final Map<DateTime, List>? events;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;
  final DateTime? initialDate;
  final bool isExpanded;
  final List<String> weekDays;
  final String locale;
  final bool startOnMonday;
  final bool hideBottomBar;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? bottomBarTextStyle;
  final Color? bottomBarArrowColor;
  final Color? bottomBarColor;

  const Calendar({super.key, 
    this.onMonthChanged,
    this.onDateSelected,
    this.onRangeSelected,
    this.hideBottomBar = false,
    this.isExpandable = false,
    this.events,
    this.dayBuilder,
    this.hideTodayIcon = false,
    this.hideArrows = false,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
    this.initialDate,
    this.isExpanded = false,
    this.weekDays = const ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    this.locale = "en_US",
    this.startOnMonday = false,
    this.dayOfWeekStyle,
    this.bottomBarTextStyle,
    this.bottomBarArrowColor,
    this.bottomBarColor,
  });

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = Utils();
  late List<DateTime> selectedMonthsDays;
  late Iterable<DateTime> selectedWeekDays;
  DateTime _selectedDate = DateTime.now();
  String? currentMonth;
  bool isExpanded = false;
  String displayMonth = "";

  DateTime get selectedDate => _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    isExpanded = widget.isExpanded;
    selectedMonthsDays = _daysInMonth(_selectedDate);
    selectedWeekDays = Utils.daysInRange(
            _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
        .toList();
    initializeDateFormatting(widget.locale, null).then((_) => setState(() {
          var monthFormat =
              DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
          displayMonth =
              "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
        }));
  }

  Widget get nameAndIconRow {
    StatelessWidget todayIcon;
    StatelessWidget leftArrow;
    StatelessWidget rightArrow;

    if (!widget.hideArrows) {
      leftArrow = IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: const Icon(Icons.chevron_left),
      );
      rightArrow = IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: const Icon(Icons.chevron_right),
      );
    } else {
      leftArrow = Container();
      rightArrow = Container();
    }

    if (!widget.hideTodayIcon) {
      todayIcon = InkWell(
        onTap: resetToToday,
        child: const Text('Today'),
      );
    } else {
      todayIcon = Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftArrow ?? Container(),
        Column(
          children: <Widget>[
            todayIcon ?? Container(),
            Text(
              displayMonth,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        rightArrow ?? Container(),
      ],
    );
  }

  Widget get calendarGridView {
    return Container(
      child: SimpleGestureDetector(
        onSwipeUp: _onSwipeUp,
        onSwipeDown: _onSwipeDown,
        onSwipeLeft: _onSwipeLeft,
        onSwipeRight: _onSwipeRight,
        swipeConfig: const SimpleSwipeConfig(
          verticalThreshold: 10.0,
          horizontalThreshold: 40.0,
          swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
        ),
        child: Column(children: <Widget>[
          GridView.count(
            childAspectRatio: 1.5,
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 7,
            padding: const EdgeInsets.only(bottom: 0.0),
            children: calendarBuilder(),
          ),
        ]),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeekDays as List<DateTime>;
    for (var day in widget.weekDays) {
        dayWidgets.add(
          CalendarTile(
            selectedColor: widget.selectedColor,
            todayColor: widget.todayColor,
            eventColor: widget.eventColor,
            eventDoneColor: widget.eventDoneColor,
            events: widget.events![day],
            isDayOfWeek: true,
            dayOfWeek: day,
            dayOfWeekStyle: widget.dayOfWeekStyle ??
                TextStyle(
                  color: widget.selectedColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
          ),
        );
      }

    bool monthStarted = false;
    bool monthEnded = false;

    for (var day in calendarDays) {
        if (day.hour > 0) {
          day = day.toLocal();
          day = day.subtract(Duration(hours: day.hour));
        }

        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (widget.dayBuilder != null) {
          dayWidgets.add(
            CalendarTile(
              selectedColor: widget.selectedColor,
              todayColor: widget.todayColor,
              eventColor: widget.eventColor,
              eventDoneColor: widget.eventDoneColor,
              events: widget.events![day],
              child: widget.dayBuilder!(context, day),
              date: day,
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
            ),
          );
        } else {
          dayWidgets.add(
            CalendarTile(
                selectedColor: widget.selectedColor,
                todayColor: widget.todayColor,
                eventColor: widget.eventColor,
                eventDoneColor: widget.eventDoneColor,
                events: widget.events![day],
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: configureDateStyle(monthStarted, monthEnded),
                isSelected: Utils.isSameDay(selectedDate, day),
                inMonth: day.month == selectedDate.month),
          );
        }
      }
    return dayWidgets;
  }

  TextStyle? configureDateStyle(monthStarted, monthEnded) {
    TextStyle? dateStyles;
    final TextStyle? body1Style = Theme.of(context).textTheme.bodyMedium;

    if (isExpanded) {
      final TextStyle body1StyleDisabled = body1Style!.copyWith(
          color: Color.fromARGB(
        100,
        body1Style.color!.red,
        body1Style.color!.green,
        body1Style.color!.blue,
      ));

      dateStyles =
          monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
    } else {
      dateStyles = body1Style;
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return GestureDetector(
        onTap: toggleExpanded,
        child: Container(
          color: widget.bottomBarColor ?? const Color.fromRGBO(200, 200, 200, 0.2),
          height: 40,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(width: 40.0),
              Text(
                Utils.fullDayFormat(selectedDate),
                style: widget.bottomBarTextStyle ?? const TextStyle(fontSize: 13),
              ),
              IconButton(
                onPressed: toggleExpanded,
                iconSize: 25.0,
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                icon: isExpanded
                    ? Icon(
                        Icons.arrow_drop_up,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      )
                    : Icon(
                        Icons.arrow_drop_down,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          expansionButtonRow
        ],
      ),
    );
  }

  void resetToToday() {
    _selectedDate = DateTime.now();
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = Utils.nextMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousMonth() {
    setState(() {
      _selectedDate = Utils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void nextWeek() {
    setState(() {
      _selectedDate = Utils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat =
          DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
    setState(() {
      _selectedDate = Utils.previousWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat =
          DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime? end) {
    Range rangeSelected = Range(start, end);
    if (widget.onRangeSelected != null) {
      widget.onRangeSelected!(rangeSelected);
    }
  }

  void _onSwipeUp() {
    if (isExpanded) toggleExpanded();
  }

  void _onSwipeDown() {
    if (!isExpanded) toggleExpanded();
  }

  void _onSwipeRight() {
    if (isExpanded) {
      previousMonth();
    } else {
      previousWeek();
    }
  }

  void _onSwipeLeft() {
    if (isExpanded) {
      nextMonth();
    } else {
      nextWeek();
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
    var lastDayOfCurrentWeek = _lastDayOfWeek(day);

    setState(() {
      _selectedDate = day;
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(day);
    });
    if (_selectedDate.month > day.month) {
      previousMonth();
    }
    if (_selectedDate.month < day.month) {
      nextMonth();
    }
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(day);
    }
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(day);
    }
  }

  _firstDayOfWeek(DateTime date) {
    var day = DateTime.utc(date.year, date.month, date.day, 12);
    return day.subtract(
        Duration(days: day.weekday - (widget.startOnMonday ? 1 : 0)));
  }

  _lastDayOfWeek(DateTime date) {
    return _firstDayOfWeek(date).add(const Duration(days: 7));
  }

  List<DateTime> _daysInMonth(DateTime month) {
    var first = Utils.firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first
        .subtract(Duration(days: daysBefore - 1))
        .subtract(Duration(days: !widget.startOnMonday ? 1 : 0));
    var last = Utils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget? collapsed;
  final Widget? expanded;
  final bool? isExpanded;

  const ExpansionCrossFade({super.key, this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: AnimatedCrossFade(
        firstChild: collapsed!,
        secondChild: expanded!,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded! ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
