library animated_accordion;

import 'dart:async';
import 'dart:ui';

import 'package:animated_accordion/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import 'rotation_y_transition.dart';

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
  final String? headerTitle;

  /// The padding for the header section.
  final EdgeInsetsGeometry? headerPadding;

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

  /// Custom styling for the header title (e.g., font size, weight).
  final TextStyle? headerTitleStyle;

  /// Text alignment for the header title (e.g., left, center, right).
  final TextAlign? headerTextAlign;

  /// The duration of the animation when expanding or collapsing.
  final Duration? animationDuration;

  /// Determines how content is clipped (e.g., inside borders).
  final Clip clipBehavior;

  /// Maintains the state of the content when collapsed.
  final bool maintainState;

  /// Specifies whether padding is applied to the collapsed tile.
  final bool tilePaddingCollapsed;

  /// Specifies whether padding is applied to the expanded tile.
  final bool tilePaddingExpanded;

  /// Sets the height of the expanded content. If null, a default height is used.
  final double? contentHeight;

  /// The gradient to be applied to the content area.
  final Gradient? contentGradient;

  /// The border for the content area.
  final BoxBorder? contentBorder;

  /// The image to be displayed in the content area.
  final DecorationImage? contentImage;

  /// The border radius for the content area.
  final BorderRadius? contentBorderRadius;

  /// The alignment of the content inside the content area.
  final Alignment? contentAlignment;

  /// A list of widgets to be displayed inside the expandable content area.
  final List<Widget> contentWidgets;

  /// The curve for the animation when the content opens.
  final Curve contentOpenAnimationCurve;

  /// The curve for the animation when the content closes.
  final Curve contentCloseAnimationCurve;

  /// The type of animation to be used for the content (fade, slide, or scale).
  final AnimatedAccordionAnimationType contentAnimationType;

  /// The background color of the content area.
  final Color? contentBackgroundColor;

  /// Padding for the content inside the accordion.
  final EdgeInsetsGeometry? contentPadding;

  /// The shape (e.g., rounded corners) of the content area.
  final BoxShape? contentShape;

  /// The duration for the auto-expand feature.
  final Duration? autoExpandDuration;

  /// The duration for the auto-collapse feature.
  final Duration? autoCollapseDuration;

  /// Determines if the content area is scrollable.
  final bool isScrollable;

  /// Creates a new `AnimatedAccordion` widget with the given parameters.
  /// The `contentWidgets` parameter is required and must not be null.
  /// The `contentAnimationType` defaults to `AnimatedAccordionAnimationType.fade`.
  /// The `contentOpenAnimationCurve` defaults to `Curves.easeIn`.
  /// The `contentCloseAnimationCurve` defaults to `Curves.easeOut`.
  /// The `isInitiallyExpanded` defaults to `false`.
  /// The `isScrollable` defaults to `true`.
  /// The `maintainState` defaults to `false`.
  /// The `clipBehavior` defaults to `Clip.none`.
  /// The `tilePaddingCollapsed` defaults to `true`.
  /// The `tilePaddingExpanded` defaults to `true`.

  const AnimatedAccordion({
    super.key,
    this.headerTitle,
    required this.contentWidgets,
    this.contentOpenAnimationCurve = Curves.easeIn,
    this.contentCloseAnimationCurve = Curves.easeOut,
    this.contentAnimationType = AnimatedAccordionAnimationType.fade,
    this.contentPadding,
    this.tileBackgroundColor,
    this.collapsedContentBackgroundColor,
    this.expandedContentBackgroundColor,
    this.contentBackgroundColor,
    this.contentShape,
    this.contentHeight,
    this.contentGradient,
    this.contentBorder,
    this.contentImage,
    this.contentBorderRadius,
    this.contentAlignment,
    this.headerTrailing,
    this.headerLeading,
    this.headerPadding,
    this.headerShape,
    this.headerCustomWidget,
    this.headerBackgroundColor,
    this.headerTextColor = Colors.black,
    this.headerElevation = 2.0,
    this.headerTitleStyle,
    this.headerTextAlign = TextAlign.start,
    this.expandedHeaderLeading,
    this.isInitiallyExpanded = false,
    this.onExpansionChanged,
    this.collapsedTileElevation,
    this.expandedTileElevation,
    this.tileShape,
    this.clipBehavior = Clip.none,
    this.animationDuration,
    this.maintainState = false,
    this.tilePaddingCollapsed = true,
    this.tilePaddingExpanded = true,
    this.autoExpandDuration,
    this.autoCollapseDuration,
    this.isScrollable = true,
  });

  @override
  State<AnimatedAccordion> createState() => _AnimatedAccordionState();
}

class _AnimatedAccordionState extends State<AnimatedAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  Timer? _expandTimer;
  Timer? _collapseTimer;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _rotationAnimations;
  late List<Animation<double>> _shrinkAnimations;
  late List<Animation<double>> _bounceAnimations;
  late List<Animation<double>> _blurAnimations;

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

    if (widget.autoExpandDuration != null) {
      _startAutoExpandTimer();
    }

    if (widget.autoCollapseDuration != null) {
      _startAutoCollapseTimer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    super.dispose();
  }

  /// Starts the timer for auto-expanding the accordion.
  void _startAutoExpandTimer() {
    _expandTimer = Timer(widget.autoExpandDuration!, () {
      setState(() {
        _isExpanded = true;
        _controller.forward();
      });
    });
  }

  /// Starts the timer for auto-collapsing the accordion.
  void _startAutoCollapseTimer() {
    _collapseTimer = Timer(widget.autoCollapseDuration!, () {
      setState(() {
        _isExpanded = false;
        _controller.reverse();
      });
    });
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

  /// Initializes animations dynamically based on the number of content widgets.
  void _initializeAnimations() {
    /// Fade Animations
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

    /// Slide Animations
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

    /// Scale Animations
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

    /// Rotate Animations
    _rotationAnimations = List.generate(widget.contentWidgets.length, (index) {
      double start = (index / widget.contentWidgets.length) * 0.5;
      double end = start + 0.5;

      return Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: widget.contentOpenAnimationCurve),
        ),
      );
    });

    /// Bounce Animations
    _bounceAnimations = List.generate(widget.contentWidgets.length, (index) {
      return Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceIn,
        ),
      );
    });

    /// Blur Animations
    _blurAnimations = List.generate(widget.contentWidgets.length, (index) {
      double start = (index / widget.contentWidgets.length) * 0.5;
      double end = start + 0.5;

      return Tween<double>(begin: 10.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: widget.contentOpenAnimationCurve),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _initializeAnimations();
    return Material(
      shape: widget.tileShape,
      elevation: _isExpanded
          ? widget.expandedTileElevation ?? 0.0
          : widget.collapsedTileElevation ?? 0.0,
      clipBehavior: widget.clipBehavior,
      color: widget.tileBackgroundColor ?? Colors.transparent,
      borderRadius: widget.tileShape == null
          ? widget.contentBorderRadius ?? BorderRadius.circular(10)
          : null,
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
              gradient: widget.contentGradient,
              border: widget.contentBorder ?? Border.all(color: Colors.grey),
              image: widget.contentImage,
              shape: widget.contentShape ?? BoxShape.rectangle,
              borderRadius:
                  widget.contentBorderRadius ?? BorderRadius.circular(10),
            ),
            alignment: widget.contentAlignment ?? Alignment.center,
            child: _buildAnimatedContent(),
          ),
        ],
      ),
    );
  }

  /// Builds the header section of the accordion.
  Widget _buildHeaderSection() {
    return Material(
      shape: widget.headerShape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
      elevation: widget.headerElevation ?? 4.0,
      color: widget.headerBackgroundColor ?? Colors.blue[100],
      shadowColor: Colors.black,
      child: Container(
        child: ListTile(
          onTap: _handleTap,
          contentPadding: widget.headerPadding,
          shape: widget.headerShape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey),
              ),
          leading: _isExpanded
              ? widget.expandedHeaderLeading ?? widget.headerLeading
              : widget.headerLeading,
          title: widget.headerCustomWidget ??
              Text(
                widget.headerTitle ?? 'Accordion',
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
      physics: widget.isScrollable
          ? ScrollPhysics()
          : NeverScrollableScrollPhysics(),
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
      padding: EdgeInsets.only(top: 10),
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
      case AnimatedAccordionAnimationType.rotate:
        child = RotationTransition(
          turns: _fadeAnimations[index],
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.fadeScale:
        child = FadeTransition(
          opacity: _fadeAnimations[index],
          child: ScaleTransition(
            scale: _scaleAnimations[index],
            child: child,
          ),
        );
        break;
      case AnimatedAccordionAnimationType.slideFade:
        child = SlideTransition(
          position: _slideAnimations[index],
          child: FadeTransition(
            opacity: _fadeAnimations[index],
            child: child,
          ),
        );
        break;

      case AnimatedAccordionAnimationType.flip:
        child = RotationYTransition(
          turns: _rotationAnimations[index], // Use the flip animation
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.bounce:
        child = ScaleTransition(
          scale: _bounceAnimations[index], // Use the bounce animation
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.shrink:
        child = SizeTransition(
          sizeFactor: _shrinkAnimations[index], // Use the shrink animation
          child: child,
        );
        break;
      case AnimatedAccordionAnimationType.blur:
        child = AnimatedBuilder(
          animation: _blurAnimations[index], // Use the blur animation
          builder: (context, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: _blurAnimations[index].value,
                  sigmaY: _blurAnimations[index].value),
              child: child,
            );
          },
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

  /// The content rotates in and out.
  rotate,

  /// The content flips in and out.
  flip,

  /// The content fades and scales in and out.
  fadeScale,

  /// The content slides and fades in and out.
  slideFade,

  /// The content bounces in and out.
  bounce,

  /// The content shrinks in and out.
  shrink,

  /// The content blurs in and out.
  blur,
}
