import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class CalendrierWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final List<DateTime>? availableDates;

  const CalendrierWidget({
    Key? key,
    required this.onDateSelected,
    this.availableDates,
  }) : super(key: key);

  @override
  State<CalendrierWidget> createState() => _CalendrierWidgetState();
}

class _CalendrierWidgetState extends State<CalendrierWidget> {
  late DateTime _currentDate;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getMonthNameFr(int month) {
    const List<String> months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre'
    ];
    return months[month - 1];
  }

  bool _isInPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  bool _isDateAvailable(DateTime date) {
    if (widget.availableDates == null) return true;
    return widget.availableDates!.any((d) => _isSameDay(d, date));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // En-tête avec mois et année
        Padding(
          padding: EdgeInsets.all(AppDimensions.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
                  });
                },
                icon: Icon(Icons.chevron_left, color: AppColors.primary),
              ),
              Text(
                '${_getMonthNameFr(_currentDate.month)} ${_currentDate.year}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
                  });
                },
                icon: Icon(Icons.chevron_right, color: AppColors.primary),
              ),
            ],
          ),
        ),
        // Jours de la semaine
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey600,
                              ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(height: AppDimensions.paddingSmall),
        // Grille des jours
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: _getDaysInMonth(_currentDate),
            itemBuilder: (context, index) {
              DateTime date = DateTime(_currentDate.year, _currentDate.month, index + 1);
              bool isToday = _isSameDay(date, DateTime.now());
              bool isSelected = _selectedDate != null && _isSameDay(date, _selectedDate!);
              bool isAvailable = _isDateAvailable(date) && !_isInPast(date);

              return GestureDetector(
                onTap: isAvailable
                    ? () {
                        setState(() {
                          _selectedDate = date;
                        });
                        widget.onDateSelected(date);
                      }
                    : null,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : isToday
                            ? AppColors.primaryLight
                            : Colors.transparent,
                    border: isToday ? Border.all(color: AppColors.primary, width: 2) : null,
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : isAvailable
                                    ? AppColors.onBackground
                                    : AppColors.grey400,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  int _getDaysInMonth(DateTime date) {
    if (date.month == DateTime.december) {
      return DateTime(date.year + 1, 1, 0).day;
    }
    return DateTime(date.year, date.month + 1, 0).day;
  }
}
