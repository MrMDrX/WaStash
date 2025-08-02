import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wastash/cubits/bottom_nav_cubit.dart';
import 'package:wastash/widgets/bottom_nav.dart';
import 'package:wastash/widgets/page_transition.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        final pages = [
          Scaffold(body: const Center(child: Text('Status Page'))),
          Scaffold(body: const Center(child: Text('Saved Page'))),
          Scaffold(body: const Center(child: Text('Settings Page'))),
        ];

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: pages.asMap().entries.map((entry) {
              return PageTransition(
                isActive: currentIndex == entry.key,
                child: entry.value,
              );
            }).toList(),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
