import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:dio/dio.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Tasker'),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            FloatingSearchBar(
              elevation: 10,
              closeOnBackdropTap: true,
              hint: "Buscar tareas...",
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: isPortrait ? 0.0 : -1.0,
              openAxisAlignment: 0.0,
              width: isPortrait ? 600 : 500,
              debounceDelay: const Duration(milliseconds: 500),
              onQueryChanged: (query) {
              },
              onSubmitted: (e){
                
              },
              // Specify a custom transition to be used for
              // animating between opened and closed stated.
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: Colors.accents.map((color) {
                        return Container(height: 112, color: color);
                      }).toList(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: DotNavigationBar(
            margin: EdgeInsets.only(left: 5, right: 5),
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            dotIndicatorColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            // enableFloatingNavBar: false,
            onTap: _handleIndexChanged,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: Icon(Icons.home),
                selectedColor: Colors.blue,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: Icon(Icons.assignment),
                selectedColor: Colors.blue,
              ),

              DotNavigationBarItem(
                icon: Icon(Icons.people),
                selectedColor: Colors.blue,
              ),

              /// Profile
              DotNavigationBarItem(
                icon: Icon(Icons.person),
                selectedColor: Colors.blue,
              ),
            ],
          ),
        ));
  }
}

enum _SelectedTab { home, favorite, search, person }
