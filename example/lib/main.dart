import 'package:flutter/material.dart';
import 'package:animated_accordion/animated_accordion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animated Accordion Example'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ExampleScreen(),
        ),
      ),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AnimatedAccordion(
          headerTitle: "Default Accordion",
          isScrollable: false,
          contentWidgets: [
            ListTile(title: Text("Content 1")),
            ListTile(title: Text("Content 2")),
            ListTile(title: Text("Content 3")),
            ListTile(title: Text("Content 4")),
            ListTile(title: Text("Content 5")),
          ],
        ),
        const SizedBox(height: 20), // Adds space between tiles
        // Slide Animation Tile
        AnimatedAccordion(
          autoExpandDuration: const Duration(seconds: 5),
          headerTextAlign: TextAlign.center,
          headerTitle: "Slide Animation Title", // The title of the header
          headerTextColor: Colors.black54, // Text color for the header
          headerShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), // The shape of the header with rounded corners
          contentWidgets: [
            // The content that will be shown when the tile is expanded
            const ListTile(
              title: Text("Content 1"),
            ),
            const ListTile(
              title: Text("Content 2"),
            ),
            const ListTile(
              title: Text("Content 3"),
            ),
            // A button in the content area
            ElevatedButton(
                onPressed: () {
                  print("Slide Button Pressed");
                },
                child: const Text("Button in Slide")),
          ],
          contentAnimationType:
              AnimatedAccordionAnimationType.slide, // Slide animation type
          headerTrailing: const Icon(Icons
              .arrow_drop_down), // Icon shown on the right side of the header
          headerBackgroundColor:
              Colors.lightBlue[100], // Background color of the header
          tileBackgroundColor:
              Colors.white, // Background color of the entire tile
          contentBackgroundColor:
              Colors.white, // Background color when content is expanded
          headerTitleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // Styling for the header title
          collapsedTileElevation: 2.0, // Elevation when tile is collapsed
          expandedTileElevation: 4.0, // Elevation when tile is expanded
          animationDuration:
              const Duration(milliseconds: 700), // Duration of the animation
          tileShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), //
        ),
        const SizedBox(height: 20), // Adds space between tiles

        // Fade Animation Tile
        AnimatedAccordion(
          contentHeight: 200, // Custom height for the content area
          headerTitle: "Fade Animation Title", // The title of the header
          headerShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), // The shape of the header with rounded corners

          autoCollapseDuration: const Duration(seconds: 5),
          contentWidgets: [
            // Content shown when the tile is expanded
            const ListTile(
              title: Text("Fade Content 1"),
            ),
            const ListTile(
              title: Text("Fade Content 2"),
            ),
            // A button inside the content area
            ElevatedButton(
                onPressed: () {
                  print("Fade Button Pressed");
                },
                child: const Text("Button in Fade")),
          ],
          contentBorderRadius: BorderRadius.circular(50),
          contentAnimationType:
              AnimatedAccordionAnimationType.flip, // Fade animation type
          headerTrailing: const Icon(Icons
              .arrow_drop_down), // Icon shown on the right side of the header
          headerBackgroundColor:
              Colors.orange[100], // Background color of the header

          contentBackgroundColor:
              Colors.amber[200], // Background color when content is expanded
          headerTitleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // Styling for the header title
          isInitiallyExpanded: false,
          animationDuration:
              const Duration(milliseconds: 700), // Duration of the animation
        ),
        const SizedBox(height: 20), // Adds space between tiles

        // Scale Animation Tile
        AnimatedAccordion(
          contentHeight: 200, // Custom height for the content area
          headerTitle: "Scale Animation Title", // The title of the header
          headerShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), // The shape of the header with rounded corners
          contentWidgets: [
            // Content shown when the tile is expanded
            const ListTile(
              title: Text("Scale Content 1"),
            ),
            const ListTile(
              title: Text("Scale Content 2"),
            ),
            // A button inside the content area
            ElevatedButton(
                onPressed: () {
                  print("Scale Button Pressed");
                },
                child: const Text("Button in Scale")),
          ],
          contentAnimationType:
              AnimatedAccordionAnimationType.scale, // Scale animation type
          headerTrailing: const Icon(Icons
              .arrow_drop_down), // Icon shown on the right side of the header
          headerBackgroundColor:
              Colors.green[100], // Background color of the header
          tileBackgroundColor:
              Colors.green[50], // Background color of the entire tile
          contentBackgroundColor:
              Colors.green[200], // Background color when content is expanded
          headerTitleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // Styling for the header title
          collapsedTileElevation: 2.0, // Elevation when tile is collapsed
          expandedTileElevation: 4.0, // Elevation when tile is expanded
          animationDuration:
              const Duration(milliseconds: 700), // Duration of the animation
          tileShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), // Shape of the entire tile
        ),
        const SizedBox(height: 20), // Adds space between tiles
      ],
    );
  }
}
