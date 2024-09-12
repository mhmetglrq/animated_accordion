import 'package:animated_accordion/src/animated_accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Utility method to pump widget in the test environment
  Future<void> pumpAccordionWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Test Accordion",
            contentWidgets: const [
              ListTile(title: Text("Content 1")),
              ListTile(title: Text("Content 2")),
              ListTile(title: Text("Content 3")),
            ],
            contentAnimationType: AnimatedAccordionAnimationType.slide,
          ),
        ),
      ),
    );
  }

  testWidgets('Accordion starts collapsed', (WidgetTester tester) async {
    // Pump the accordion widget
    await pumpAccordionWidget(tester);

    // Check if initially the content is not visible
    expect(find.text("Content 1"), findsNothing);
    expect(find.text("Content 2"), findsNothing);
    expect(find.text("Content 3"), findsNothing);
  });

  testWidgets('Accordion expands on tap', (WidgetTester tester) async {
    // Pump the accordion widget
    await pumpAccordionWidget(tester);

    // Tap on the accordion header
    await tester.tap(find.text("Test Accordion"));
    await tester.pumpAndSettle(); // Allow animation to complete

    // Check if the content is now visible
    expect(find.text("Content 1"), findsOneWidget);
    expect(find.text("Content 2"), findsOneWidget);
    expect(find.text("Content 3"), findsOneWidget);
  });

  testWidgets('Accordion collapses after tap', (WidgetTester tester) async {
    // Pump the accordion widget
    await pumpAccordionWidget(tester);

    // Tap on the accordion header to expand
    await tester.tap(find.text("Test Accordion"));
    await tester.pumpAndSettle(); // Allow animation to complete

    // Tap again to collapse
    await tester.tap(find.text("Test Accordion"));
    await tester.pumpAndSettle();

    // Check if the content is hidden again
    expect(find.text("Content 1"), findsNothing);
    expect(find.text("Content 2"), findsNothing);
    expect(find.text("Content 3"), findsNothing);
  });

  testWidgets('Accordion uses custom header title style',
      (WidgetTester tester) async {
    // Pump the accordion widget with custom header style
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Styled Accordion",
            contentWidgets: const [
              ListTile(title: Text("Styled Content 1")),
              ListTile(title: Text("Styled Content 2")),
            ],
            headerTitleStyle: const TextStyle(color: Colors.red, fontSize: 20),
            contentAnimationType: AnimatedAccordionAnimationType.fade,
          ),
        ),
      ),
    );

    // Verify the custom header style is applied
    final headerTitle = find.text("Styled Accordion");
    final Text headerText = tester.widget(headerTitle);
    expect(headerText.style?.color, Colors.red);
    expect(headerText.style?.fontSize, 20);
  });

  testWidgets('Accordion applies content height', (WidgetTester tester) async {
    // Pump the accordion widget with a custom content height
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Custom Height Accordion",
            contentWidgets: const [
              ListTile(title: Text("Custom Content 1")),
            ],
            contentHeight: 300, // Set custom height
          ),
        ),
      ),
    );

    // Expand the accordion
    await tester.tap(find.text("Custom Height Accordion"));
    await tester.pumpAndSettle();

    // Use find.byType to find the AnimatedContainer
    final animatedContainerFinder = find.byType(AnimatedContainer);
    expect(animatedContainerFinder, findsOneWidget);

    // Access the BoxConstraints via the container's RenderObject
    final containerRenderObject =
        tester.renderObject<RenderBox>(animatedContainerFinder);
    expect(containerRenderObject.size.height, equals(300));
  });

  testWidgets('Accordion applies fade animation', (WidgetTester tester) async {
    // Pump the accordion widget with fade animation
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Fade Animation Accordion",
            contentWidgets: const [
              ListTile(title: Text("Fade Content 1")),
            ],
            contentAnimationType:
                AnimatedAccordionAnimationType.fade, // Set fade animation
          ),
        ),
      ),
    );

    // Expand the accordion
    await tester.tap(find.text("Fade Animation Accordion"));
    await tester.pumpAndSettle();

    // Check that the FadeTransition widget is present
    final fadeTransitionFinder = find.byType(FadeTransition);
    expect(fadeTransitionFinder, findsOneWidget);

    // Get the FadeTransition and check the opacity value
    final fadeTransition = tester.widget<FadeTransition>(fadeTransitionFinder);
    expect(fadeTransition.opacity.value,
        equals(1.0)); // Opacity should be 1 when fully expanded
  });

  testWidgets('Accordion applies scale animation', (WidgetTester tester) async {
    // Pump the accordion widget with scale animation
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Scale Animation Accordion",
            contentWidgets: const [
              ListTile(title: Text("Scale Content 1")),
            ],
            contentAnimationType:
                AnimatedAccordionAnimationType.scale, // Set scale animation
          ),
        ),
      ),
    );

    // Expand the accordion
    await tester.tap(find.text("Scale Animation Accordion"));
    await tester.pumpAndSettle();

    // Check that the ScaleTransition widget is present
    final scaleTransitionFinder = find.byType(ScaleTransition);
    expect(scaleTransitionFinder, findsOneWidget);

    // Get the ScaleTransition and check the scale value
    final scaleTransition =
        tester.widget<ScaleTransition>(scaleTransitionFinder);
    expect(scaleTransition.scale.value,
        equals(1.0)); // Scale should be 1 when fully expanded
  });

  testWidgets('Accordion applies slide animation', (WidgetTester tester) async {
    // Pump the accordion widget with slide animation
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: "Slide Animation Accordion",
            contentWidgets: const [
              ListTile(title: Text("Slide Content 1")),
            ],
            contentAnimationType:
                AnimatedAccordionAnimationType.slide, // Set slide animation
          ),
        ),
      ),
    );

    // Expand the accordion
    await tester.tap(find.text("Slide Animation Accordion"));
    await tester.pumpAndSettle();

    // Check that the SlideTransition widget is present
    final slideTransitionFinder = find.byType(SlideTransition);
    expect(slideTransitionFinder, findsOneWidget);

    // Get the SlideTransition and check the position value
    final slideTransition =
        tester.widget<SlideTransition>(slideTransitionFinder);
    expect(slideTransition.position.value,
        equals(Offset.zero)); // Position should be 0 when fully expanded
  });
}
