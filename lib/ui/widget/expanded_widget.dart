import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  const ExpandedSection({
    Key? key,
    this.expand = false,
    required this.child,
    this.axis = Axis.vertical,
  }) : super(key: key);
  final Widget child;
  final bool expand;
  final Axis axis;

  @override
  ExpandedSectionState createState() => ExpandedSectionState();
}

class ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeOutCubic,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expand != widget.expand) {
      _runExpandCheck();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: widget.axis,
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: widget.child);
  }
}
