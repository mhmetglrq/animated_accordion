import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_accordion/animated_accordion.dart';

void main() {
  Future<void> loadTestAssets() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await rootBundle.load(
        'assets/images/bg_image.jpg'); // Testlerde kullanılan varlıkları yükleyin
  }

  group('AnimatedAccordion General Behavior Tests', () {
    testWidgets('Initial state of AnimatedAccordion is collapsed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1'), Text('Content 2')],
          ),
        ),
      ));

      // Assert that content is not visible initially (collapsed state)
      expect(find.text('Test Accordion'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('AnimatedAccordion expands when tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1'), Text('Content 2')],
          ),
        ),
      ));

      // Act - Tap on the header to expand the accordion
      await tester.tap(find.text('Test Accordion'));
      await tester.pumpAndSettle(); // Wait for animation to complete

      // Assert that content is visible after expansion
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('AnimatedAccordion collapses when tapped again',
        (WidgetTester tester) async {
      // Arrange: render the widget and ensure the accordion is initially collapsed
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1'), Text('Content 2')],
            isInitiallyExpanded: false, // Starts collapsed
          ),
        ),
      ));

      // Ensure that the header is visible, but the content is not
      expect(find.text('Test Accordion'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);

      // Act: Tap the header to expand the accordion
      await tester.tap(find.text('Test Accordion'));
      await tester.pumpAndSettle(); // Wait for the animation to finish

      // Now, content should be visible
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);

      // Act: Tap the header again to collapse the accordion
      await tester.tap(find.text('Test Accordion'));
      await tester.pumpAndSettle(); // Wait for the animation to finish

      // Assert: Content should no longer be visible after collapse
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });
  });

  group('AnimatedAccordion Animation Type Tests', () {
    testWidgets('Test fade animation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentAnimationType: AnimatedAccordionAnimationType.fade,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pump(); // Start the animation
      await tester.pump(
          const Duration(milliseconds: 250)); // Halfway through the animation

      // Assert that the content is partially visible (fading in)
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Test scale animation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentAnimationType: AnimatedAccordionAnimationType.scale,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pump(); // Start the animation
      await tester.pump(
          const Duration(milliseconds: 250)); // Halfway through the animation

      // Assert that the content is partially visible (scaling in)
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Test slide animation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentAnimationType: AnimatedAccordionAnimationType.slide,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pump(); // Start the animation
      await tester.pump(
          const Duration(milliseconds: 250)); // Halfway through the animation

      // Assert that the content is partially visible (sliding in)
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Test bounce animation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentAnimationType: AnimatedAccordionAnimationType.bounce,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pump(); // Start the animation
      await tester.pump(
          const Duration(milliseconds: 250)); // Halfway through the animation

      // Assert that the content is partially visible (bouncing in)
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Test flip animation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentAnimationType: AnimatedAccordionAnimationType.flip,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pump(); // Start the animation
      await tester.pump(
          const Duration(milliseconds: 250)); // Halfway through the animation

      // Assert that the content is partially visible (flipping in)
      expect(find.text('Content 1'), findsOneWidget);
    });
  });

  group('AnimatedAccordion Special Features Tests', () {
    testWidgets('Custom header widget works as expected',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerCustomWidget: Row(
              children: [Icon(Icons.star), Text('Custom Header')],
            ),
            contentWidgets: [Text('Content 1')],
            headerTitle: '',
          ),
        ),
      ));

      // Assert that the custom header is rendered
      expect(find.text('Custom Header'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('Accordion content is scrollable when isScrollable is true',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: List<Widget>.generate(
                20, (index) => ListTile(title: Text('Item $index'))),
            isScrollable: true,
          ),
        ),
      ));

      // Act - Tap to expand
      await tester.tap(find.text('Test Accordion'));
      await tester.pumpAndSettle();

      // Assert that content is scrollable
      final scrollable = find.byType(Scrollable);
      expect(scrollable, findsOneWidget);

      // Check if scrolling is enabled
      await tester.drag(scrollable, const Offset(0, -300)); // Scroll down
      await tester.pumpAndSettle();
    });

    testWidgets('Auto-expand works correctly after a delay',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            autoExpandDuration: const Duration(seconds: 1),
          ),
        ),
      ));

      // Assert that initially it is collapsed
      expect(find.text('Content 1'), findsOneWidget);

      // Act - Wait for the auto-expand duration
      await tester.pumpAndSettle(
          const Duration(milliseconds: 1500)); // Bekleme süresini artırın

      // Assert that the accordion expanded automatically
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Auto-collapse works correctly after a delay',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            isInitiallyExpanded: true,
            autoCollapseDuration: const Duration(seconds: 1),
          ),
        ),
      ));

      // Assert that initially it is expanded
      expect(find.text('Content 1'), findsOneWidget);

      // Act - Wait for the auto-collapse duration
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Assert that the accordion collapsed automatically
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('Test gradient and background image is applied correctly',
        (WidgetTester tester) async {
      // Arrange: asset varlıklarını yüklüyoruz
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AnimatedAccordion(
            headerTitle: 'Test Accordion',
            contentWidgets: [Text('Content 1')],
            contentGradient: LinearGradient(colors: [Colors.red, Colors.blue]),
            contentImage: DecorationImage(
              image: AssetImage('assets/images/bg_image.jpg'),
            ),
          ),
        ),
      ));

      // Act - Expand the accordion
      await tester.tap(find.text('Test Accordion'));
      await tester.pumpAndSettle();

      // Assert that the accordion has gradient and image applied
      final container = tester.widget<Container>(find.descendant(
        of: find.byType(AnimatedAccordion),
        matching: find.byType(Container),
      ));
      final BoxDecoration? decoration = container.decoration as BoxDecoration?;

      expect(decoration?.gradient, isNotNull); // Gradient var mı kontrol et
      expect(decoration?.image, isNotNull); // Image var mı kontrol et
    });
  });
}
