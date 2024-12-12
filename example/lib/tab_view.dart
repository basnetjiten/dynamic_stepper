import 'package:example/create_task_widget.dart';
import 'package:example/week_view_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 2) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitUp,
          // DeviceOrientation.portraitDown,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.deck)),
              ],
            ),
          ),
          Expanded(
            child: OrientationBuilder(
              builder: (context, orientation) {
                // Check if the user is on the last tab and the orientation is landscape
                if (_tabController.index == 2 &&
                    orientation == Orientation.landscape) {
                  // Push the LandscapePage only when in landscape mode and on the last tab
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandscapePage()),
                    );
                  });
                }

                return TabBarView(
                  controller: _tabController,
                  children:  const [
                    Center(child: Text('Screen 1')),
                    CreateTaskWidget(),
                    WeekViewStepperWidget()
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LandscapePage extends StatefulWidget {
  const LandscapePage({super.key});

  @override
  State<LandscapePage> createState() => _LandscapePageState();
}

class _LandscapePageState extends State<LandscapePage> {
  @override
  void initState() {
    super.initState();
    // Lock the orientation to landscape when entering this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    // Reset orientation to portrait when leaving this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landscape Page')),
      body: const Center(
        child: Text('This page is locked in landscape mode'),
      ),
    );
  }
}
