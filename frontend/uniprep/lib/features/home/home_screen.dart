import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neopop/neopop.dart';
import 'package:uniprep/app/provider.dart';
import 'package:uniprep/features/auth/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Column(
          children: [
        
          HeroCarousel(
          items: [
            HeroCarouselItem(
              title: "Kick Off Today's\nTargets",
              subtitle: 'PYQs · CA Quiz · NCERT Connect · CSAT, less than 30 mins',
              ctaLabel: 'Start Now',
              onCtaTap: () {},
              illustration: const Icon(Icons.gps_fixed, color: Colors.white, size: 56),
            ),
            HeroCarouselItem(
              title: 'Refer & Earn',
              subtitle: 'Invite friends, earn coins together',
              ctaLabel: 'Invite Now',
              onCtaTap: () {},
              gradientColors: const [Color(0xFF7B2FF7), Color(0xFFF107A3)],
            ),
          ],
        ),
        
        
            NeoPopButton(
                onTapUp: () async{
                  await ref.read(authControllerProvider.notifier).signOut();
                },
                child: Text('SignOut'), color: Colors.black),
          ],
        )


      )
      );
      }
      }


class HeroCarouselItem {
  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onCtaTap;
  final List<Color> gradientColors;
  final Widget? illustration;

  HeroCarouselItem({
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onCtaTap,
    this.gradientColors = const [Color(0xFF0A2472), Color(0xFF1E5FFF)],
    this.illustration,
  });
}

class HeroCarousel extends StatefulWidget {
  final List<HeroCarouselItem> items;
  final Duration autoSlideDuration;

  const HeroCarousel({
    super.key,
    required this.items,
    this.autoSlideDuration = const Duration(seconds: 4),
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);
    _timer = Timer.periodic(widget.autoSlideDuration, (_) {
      if (!_controller.hasClients) return;
      _currentPage = (_currentPage + 1) % widget.items.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final current = widget.items[_currentPage];

  return SizedBox(
    height: 300,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [


        PageView.builder(
          controller: _controller,
          itemCount: widget.items.length,
          onPageChanged: (i) => setState(() => _currentPage = i),
          itemBuilder: (context, index) {
            return _HeroCard(item: widget.items[index]);
          },
        ),

         Positioned(
          top: 10,
          left: 10,
          child: Row(
            children: [
              Text('ghj')
            ],
          ),
        ),

        Positioned(
          bottom: 40,
          child: GestureDetector(
            onTap: current.onCtaTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    current.ctaLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 13),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


}

class _HeroCard extends StatelessWidget {
  final HeroCarouselItem item;
  const _HeroCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 240,
            padding: const EdgeInsets.fromLTRB(20, 24, 12, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: item.gradientColors,
              ),
             
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (item.illustration != null) item.illustration!,
              ],
            ),
          ),
        ),

       ],
    );
  }
}