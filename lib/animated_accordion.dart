library animated_accordion;

import 'package:animated_accordion/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

/// A Flutter widget that provides an expandable, animated accordion
/// with customizable animation options like fade, scale, and slide.
///
/// The `AnimatedAccordion` can be used to display collapsible sections
/// with a header and content. It supports custom widgets in the header
/// and animated transitions for the content.
///
/// ```dart
/// AnimatedAccordion(
///   headerTitle: 'My Accordion',
///   contentWidgets: [
///     ListTile(title: Text('Item 1')),
///     ListTile(title: Text('Item 2')),
///   ],
///   contentAnimationType: AnimatedAccordionAnimationType.slide,
///   isInitiallyExpanded: false,
/// );
/// ```
///
/// The above code will create an accordion with sliding animations.
class AnimatedAccordion extends StatefulWidget {
  /// The title displayed in the header section.
  final String headerTitle;

  /// A list of widgets to be displayed inside the expandable content area.
  final List<Widget> contentWidgets;

  /// The curve for the animation when the content opens.
  final Curve contentOpenAnimationCurve;

  /// The curve for the animation when the content closes.
  final Curve contentCloseAnimationCurve;

  /// The type of animation to be used for the content (fade, slide, or scale).
  final AnimatedAccordionAnimationType contentAnimationType;

  /// An optional widget displayed at the end of the header (usually an icon or indicator).
  final Widget? headerTrailing;

  /// An optional widget displayed at the start of the header (e.g., an icon).
  final Widget? headerLeading;

  /// An optional widget for the leading position when the content is expanded.
  final Widget? expandedHeaderLeading;

  /// A custom widget for the header, replacing the default text-based title.
  final Widget? headerCustomWidget;

  /// Determines if the accordion is expanded initially when the app starts.
  final bool isInitiallyExpanded;

  /// A callback function triggered when the accordion expands or collapses.
  final Function(bool)? onExpansionChanged;

  /// Padding for the content inside the accordion.
  final EdgeInsetsGeometry? contentPadding;

  /// The background color of the tile.
  final Color? tileBackgroundColor;

  /// The background color of the collapsed content area.
  final Color? collapsedContentBackgroundColor;

  /// The background color of the expanded content area.
  final Color? expandedContentBackgroundColor;

  /// The background color of the header section.
  final Color? headerBackgroundColor;

  /// The text color for the header title.
  final Color? headerTextColor;

  /// The background color of the content area.
  final Color? contentBackgroundColor;

  /// The elevation (shadow depth) when the tile is collapsed.
  final double? collapsedTileElevation;

  /// The elevation (shadow depth) when the tile is expanded.
  final double? expandedTileElevation;

  /// The elevation (shadow depth) of the header section.
  final double? headerElevation;

  /// The shape (e.g., rounded corners) of the entire tile.
  final ShapeBorder? tileShape;

  /// The shape (e.g., rounded corners) of the header.
  final ShapeBorder? headerShape;

  /// The shape (e.g., rounded corners) of the content area.
  final ShapeBorder? contentShape;

  /// Determines how content is clipped (e.g., inside borders).
  final Clip clipBehavior;

  /// Custom styling for the header title (e.g., font size, weight).
  final TextStyle? headerTitleStyle;

  /// Text alignment for the header title (e.g., left, center, right).
  final TextAlign? headerTextAlign;

  /// The duration of the animation when expanding or collapsing.
  final Duration? animationDuration;

  /// Maintains the state of the content when collapsed.
  final bool maintainState;

  /// Specifies whether padding is applied to the collapsed tile.
  final bool tilePaddingCollapsed;

  /// Specifies whether padding is applied to the expanded tile.
  final bool tilePaddingExpanded;

  /// Sets the height of the expanded content. If null, a default height is used.
  final double? contentHeight;

  const AnimatedAccordion({
    super.key,
    required this.headerTitle,
    required this.contentWidgets,
    this.contentOpenAnimationCurve = Curves.easeIn,
    this.contentCloseAnimationCurve = Curves.easeOut,
    this.contentAnimationType = AnimatedAccordionAnimationType.fade,
    this.headerTrailing,
    this.headerLeading,
    this.expandedHeaderLeading,
    this.headerCustomWidget,
    this.isInitiallyExpanded = false,
    this.onExpansionChanged,
    this.contentPadding,
    this.tileBackgroundColor,
    this.collapsedContentBackgroundColor,
    this.expandedContentBackgroundColor,
    this.headerBackgroundColor,
    this.headerTextColor = Colors.black,
    this.contentBackgroundColor,
    this.collapsedTileElevation,
    this.expandedTileElevation,
    this.headerElevation = 2.0,
    this.tileShape,
    this.headerShape,
    this.contentShape,
    this.clipBehavior = Clip.none,
    this.headerTitleStyle,
    this.headerTextAlign = TextAlign.start,
    this.animationDuration,
    this.maintainState = false,
    this.tilePaddingCollapsed = true,
    this.tilePaddingExpanded = true,
    this.contentHeight,
  });

  @override
  State<AnimatedAccordion> createState() => _AnimatedAccordionState();
}

class _AnimatedAccordionState extends State<AnimatedAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;

    /// The animation controller manages the state of all animations.
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 500),
    );

    /// Initialize the controller value if the accordion starts expanded.
    if (_isExpanded) {
      _controller.value = 1.0;
    }

    /// Initialize fade animations for content items.
    _fadeAnimations = List.generate(widget.contentWidgets.length, (index) {
      double start = (index / widget.contentWidgets.length) * 0.5;
      double end = start + 0.5;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: widget.contentOpenAnimationCurve),
        ),
      );
    });

    /// Initialize slide animations for content items.
    _slideAnimations = List.generate(widget.contentWidgets.length, (index) {
      double start = (index / widget.contentWidgets.length) * 0.5;
      double end = start + 0.5;

      return Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: widget.contentOpenAnimationCurve),
        ),
      );
    });

    /// Initialize scale animations for content items.
    _scaleAnimations = List.generate(widget.contentWidgets.length, (index) {
      double start = (index / widget.contentWidgets.length) * 0.5;
      double end = start + 0.5;

      return Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: widget.contentOpenAnimationCurve),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles the tap event for expanding or collapsing the accordion.
  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: widget.tileShape,
      elevation: _isExpanded
          ? widget.expandedTileElevation ?? 2.0
          : widget.collapsedTileElevation ?? 0.0,
      clipBehavior: widget.clipBehavior,
      child: Column(
        children: [
          _buildHeaderSection(),
          AnimatedContainer(
            duration:
                widget.animationDuration ?? const Duration(milliseconds: 500),
            height: _isExpanded
                ? (widget.contentHeight ?? context.dynamicHeight(0.38))

                /// Default or user-defined height
                : 0,
            padding: widget.contentPadding,
            decoration: BoxDecoration(
              color:
                  widget.contentBackgroundColor ?? widget.tileBackgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildAnimatedContent(),
          ),
        ],
      ),
    );
  }

  /// Builds the header section of the accordion.
  Widget _buildHeaderSection() {
    return Material(
      shape: widget.headerShape,
      elevation: widget.headerElevation ?? 2.0,
      color: widget.headerBackgroundColor ?? widget.tileBackgroundColor,
      child: InkWell(
        onTap: _handleTap,
        child: ListTile(
          leading: _isExpanded
              ? widget.expandedHeaderLeading ?? widget.headerLeading
              : widget.headerLeading,
          title: widget.headerCustomWidget ??
              Text(
                widget.headerTitle,
                style: widget.headerTitleStyle?.copyWith(
                      color: widget.headerTextColor,
                    ) ??
                    TextStyle(
                      color: widget.headerTextColor,
                    ),
                textAlign: widget.headerTextAlign,

                /// Custom text alignment
              ),
          trailing: widget.headerTrailing ??
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
              ),
        ),
      ),
    );
  }

  /// Builds the animated content area of the accordion.
  Widget _buildAnimatedContent() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(widget.contentWidgets.length, (index) {
          return _buildAnimatedItem(index);
        }),
      ),
    );
  }

  /// Builds each individual animated content item based on the animation type.
  Widget _buildAnimatedItem(int index) {
    Widget child = Padding(
      padding: EdgeInsets.only(top: 10 + index * 3),
      child: widget.contentWidgets[index],
    );

    switch (widget.contentAnimationType) {
      case AnimatedAccordionAnimationType.fade:
        child = FadeTransition(
          opacity: _fadeAnimations[index],
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.scale:
        child = ScaleTransition(
          scale: _scaleAnimations[index],
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.slide:
        child = SlideTransition(
          position: _slideAnimations[index],
          child: child,
        );
        break;
    }

    return child;
  }
}

/// The type of animation used for the content area in the accordion.
enum AnimatedAccordionAnimationType {
  /// The content fades in and out.
  fade,

  /// The content slides in and out.
  slide,

  /// The content scales in and out.
  scale,
}
