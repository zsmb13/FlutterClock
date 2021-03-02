import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(ClockApp());
}

class ClockApp extends StatefulWidget {
  @override
  _ClockAppState createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  Timer timer;
  DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => now = DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Clock(now: now),
        ),
      ),
    );
  }
}

class Clock extends StatelessWidget {
  const Clock({
    Key key,
    @required this.now,
  }) : super(key: key);

  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberColumn(options: [0, 1, 2], selected: now.hour ~/ 10),
        NumberColumn(options: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], selected: now.hour % 10),
        SizedBox(width: 16),
        NumberColumn(options: [0, 1, 2, 3, 4, 5], selected: now.minute ~/ 10),
        NumberColumn(options: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], selected: now.minute % 10),
        SizedBox(width: 16),
        NumberColumn(options: [0, 1, 2, 3, 4, 5], selected: now.second ~/ 10),
        NumberColumn(options: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], selected: now.second % 10),
      ],
    );
  }
}

class NumberColumn extends StatefulWidget {
  NumberColumn({
    Key key,
    @required this.options,
    @required this.selected,
    this.title,
  }) : super(key: key);

  final String title;
  final List<int> options;
  final int selected;

  @override
  _NumberColumnState createState() => _NumberColumnState();
}

class _NumberColumnState extends State<NumberColumn> {
  get selected => widget.selected;

  get options => widget.options;

  @override
  Widget build(BuildContext context) {
    final mid = (options.last - options.first) / 2;
    final offset = 40.0 * (mid - selected);
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(0.0, offset, 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final num in widget.options)
              Number(num: num, selected: selected)
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  const Number({
    Key key,
    @required this.num,
    @required this.selected,
  }) : super(key: key);

  final int num;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      alignment: Alignment.center,
      width: 40.0,
      height: 40.0,
      color: num == selected ? Color(0xFF6200EE) : Color(0xFF3700B3),
      child: Text(
        num.toString(),
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
  }
}
