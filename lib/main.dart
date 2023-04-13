// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:goalgamer/widgets/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

import 'crypto/backbone/dependency_injection.dart' as di;

import 'data/data.dart';

void main() async {
  di.init();

  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isLinux || UniversalPlatform.isMacOS) {
    await windowManager.ensureInitialized();

    WindowManager.instance.setMinimumSize(const Size(1360, 850));
  }

  // initialize hive
  await Hive.initFlutter();

  // open a box
  Box<dynamic> goals = await Hive.openBox('goalsbox');

  Box<dynamic> achievedGoals = await Hive.openBox('achievedgoalsbox');

  Box<dynamic> expenses = await Hive.openBox('expensesbox');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        title: 'GoalGamer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // Set the default light theme
        darkTheme: ThemeData.dark(), // Set the default dark theme
        themeMode: ThemeMode.system, // Use the system's current theme
        home: const Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationUp;
  late Animation<Offset> _animationDown;
  late Animation<Offset> _animationLeft;
  late Animation<Offset> _animationRight;
  late Animation<double> _animationScale;

  bool startExp = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
      reverseDuration: const Duration(milliseconds: 0),
    );

    _animationUp = Tween<Offset>(
      begin: const Offset(0.0, -3.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationDown = Tween<Offset>(
      begin: const Offset(0.0, 3.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationLeft = Tween<Offset>(
      begin: const Offset(-3.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationRight = Tween<Offset>(
      begin: const Offset(3.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
    );

    _animationController.forward();

    Future.delayed(
      const Duration(seconds: 0),
      () => setState(() {
        startExp = !startExp;
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                  position: _animationLeft,
                  child: Column(
                    children: const [
                      NameWidget(),
                      WeatherWidget(),
                    ],
                  )),
              SlideTransition(
                  position: _animationUp, child: const ChatGPTWidget()),
              SlideTransition(
                  position: _animationRight, child: const BatteryWidget()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlideTransition(
                  position: _animationLeft, child: const AnalyticsWidget()),
              SlideTransition(
                position: _animationUp,
                child: const GoalsWidget(),
              ),
              SlideTransition(
                  position: _animationDown, child: const ExpensesWidget()),
              SlideTransition(
                  position: _animationRight, child: const MarketWidget()),
            ],
          ),
          ScaleTransition(
            scale: _animationScale,
            child: ExperienceWidget(
              startExp: startExp,
            ),
          )
        ],
      ),
    );
  }
}
