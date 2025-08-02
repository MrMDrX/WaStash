import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wastash/constants/app_assets.dart';
import 'package:wastash/cubits/bottom_nav_cubit.dart';
import 'package:wastash/utils/extensions.dart';
import 'package:wastash/widgets/bottom_nav_item.dart';
import 'package:wastash/widgets/bottom_nav_item_button.dart';

/// A custom bottom navigation bar with dot animation effect.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const double _dotSize = 4.0;
  static const double _bottomPadding = 20.0;
  static const double _navBarHeight = 80.0;
  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const double _verticalSpacing = 8.0;

  bool _isAnimating = false;
  bool _isForward = false;
  late double _maxWidth;
  late double _itemWidth;
  late double _dotWidth;
  late double _dotPosition;

  /// The list of navigation items
  List<BottomNavItem> get _items => [
    BottomNavItem(
      icon: AppAssets.picLine,
      activeIcon: AppAssets.picFill,
      label: context.l10n.status,
      selectedColor: null,
    ),
    BottomNavItem(
      icon: AppAssets.savedLine,
      activeIcon: AppAssets.savedFill,
      label: context.l10n.status,
      selectedColor: null,
    ),
    BottomNavItem(
      icon: AppAssets.settingsLine,
      activeIcon: AppAssets.settingsFill,
      label: context.l10n.settings,
      selectedColor: null,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDimensions();
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateDimensions();
  }

  /// Updates the dimensions based on screen size
  void _updateDimensions() {
    _maxWidth = context.width;
    _itemWidth = _maxWidth / _items.length;
    _dotWidth = _dotSize;
    final currentIndex = context.read<BottomNavCubit>().state;
    _dotPosition = _calculateDotPosition(currentIndex);
  }

  /// Calculate the dot position for a given index
  double _calculateDotPosition(int index) {
    if (context.isRtl) {
      return (_maxWidth - ((index + 1) * _itemWidth)) +
          (_itemWidth - _dotSize) / 2;
    } else {
      return (index * _itemWidth) + (_itemWidth - _dotSize) / 2;
    }
  }

  /// Handles tap on navigation items
  void _onTap(int index) {
    if (_isAnimating) return;
    final currentIndex = context.read<BottomNavCubit>().state;
    if (currentIndex == index) return;

    _animateIndicator(currentIndex, index);
    context.read<BottomNavCubit>().updateIndex(index);
  }

  /// Animates the dot indicator between items
  void _animateIndicator(int currentIndex, int newIndex) async {
    final newPosition = _calculateDotPosition(newIndex);
    final currentPosition = _calculateDotPosition(currentIndex);
    final isMovingForward = context.isRtl
        ? newIndex < currentIndex
        : newIndex > currentIndex;
    final distance = (newPosition - currentPosition).abs();

    setState(() {
      _isAnimating = true;
      _isForward = isMovingForward;
      _dotPosition = isMovingForward ? currentPosition : newPosition;
      _dotWidth = distance + _dotSize;
    });

    await Future.delayed(_animationDuration);

    setState(() {
      _dotWidth = _dotSize;
      _dotPosition = newPosition;
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.read<BottomNavCubit>().state;
    final theme = context.theme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: _navBarHeight + bottomPadding,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildNavigationItems(currentIndex, theme),
          _buildAnimatedIndicator(currentIndex, bottomPadding, theme),
        ],
      ),
    );
  }

  /// Builds the row of navigation items
  Widget _buildNavigationItems(int currentIndex, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: _items.asMap().entries.map((entry) {
        return BottomNavItemButton(
          item: entry.value.copyWith(selectedColor: context.colors.primary),
          isActive: currentIndex == entry.key,
          onTap: () => _onTap(entry.key),
          duration: _animationDuration,
          verticalPadding: _verticalSpacing,
        );
      }).toList(),
    );
  }

  /// Builds the animated dot indicator
  Widget _buildAnimatedIndicator(
    int currentIndex,
    double bottomPadding,
    ThemeData theme,
  ) {
    return AnimatedPositioned(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      bottom: bottomPadding + _bottomPadding,
      left: _dotPosition,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        height: _dotSize,
        width: _dotWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_dotSize / 2),
          gradient: LinearGradient(
            begin: _isForward ? Alignment.centerLeft : Alignment.centerRight,
            end: _isForward ? Alignment.centerRight : Alignment.centerLeft,
            colors: [
              context.colors.primary.withValues(alpha: _isAnimating ? 0.4 : 1),
              context.colors.primary.withValues(alpha: _isAnimating ? 0.7 : 1),
              context.colors.primary,
            ],
          ),
        ),
      ),
    );
  }
}
