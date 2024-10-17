import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.json');
  }

  void _loadEvents() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        Map<String, dynamic> decodedMap = jsonDecode(contents);
        setState(() {
          _events = decodedMap.map((key, value) => MapEntry(
            DateTime.parse(key),
            (value as List).map((item) => Event.fromMap(item)).toList(),
          ));
        });
      }
    } catch (e) {
      print('Error loading events: $e');
    }
  }

  void _saveEvents() async {
    try {
      final file = await _localFile;
      String encodedMap = jsonEncode(_events.map((key, value) => MapEntry(
        key.toString(),
        value.map((event) => event.toMap()).toList(),
      )));
      await file.writeAsString(encodedMap);
    } catch (e) {
      print('Error saving events: $e');
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _addEvent(String title) {
    if (_selectedDay != null) {
      setState(() {
        if (_events[_selectedDay!] != null) {
          _events[_selectedDay!]!.add(Event(title: title));
        } else {
          _events[_selectedDay!] = [Event(title: title)];
        }
      });
      _saveEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay ?? _focusedDay)
                  .map((event) => ListTile(title: Text(event.title)))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newEventTitle = "";
        return AlertDialog(
          title: Text('Add a new event'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Event Title',
            ),
            onChanged: (value) {
              newEventTitle = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (newEventTitle.isNotEmpty) {
                  _addEvent(newEventTitle);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Event {
  final String title;

  const Event({required this.title});

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(title: map['title']);
  }

  Map<String, dynamic> toMap() {
    return {'title': title};
  }
}