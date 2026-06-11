import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:uniprep/app/theme/app_colors.dart';
import 'package:uniprep/utils/widgets/neo_pop_button.dart';
import 'package:uniprep/utils/widgets/word_cros.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final List<String> headlineTexts = [
  'Aptitude that actually gets you placed.',
  'Practice. Improve. Crack placements.',
  'Your complete placement prep companion.',
  'Mock tests, shortcuts, results. One place.',
];
  int activeHeadlineIndex = 0;

  void _showNextHeadline() {
    setState(() {
      activeHeadlineIndex = (activeHeadlineIndex + 1) % headlineTexts.length;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final shadowColor = theme.shadowColor.withValues(alpha: 0.12);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final loginCardHeight = height * 0.35; // ~35% of screen
    final carouselAreaHeight = height - loginCardHeight;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: carouselAreaHeight,
              child: WordCloudBackground(),
            ),
         
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    // topLeft: Radius.circular(32),
                    // topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                  width * 0.05,
                  height * 0.05,
                  width * 0.08,
                  height * 0.03,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    NeoPopLogoButton(
                      // onPressed: _showNextHeadline,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     border: Border.all(color: border)
                    //   ),
                    //   height: 70,
                    //   child: ClipOval(
                    //     child: Image.asset(
                    //       'assets/icons/UniSync1.png'
                    //     ),
                    //   ),
                    // ),

                    // const CarouselItem(imagePath: 'assets/icons/Uni7.png'),
                    SizedBox(height: height * 0.02),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.18),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        headlineTexts[activeHeadlineIndex],
                        key: ValueKey(headlineTexts[activeHeadlineIndex]),
                        textAlign: TextAlign.center,
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontSize: width * 0.065, // Responsive font size
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    // Sign in text
Text(
  'Sign in & dive into newer experiences.\nNo hassle, just innovation.',
  textAlign: TextAlign.center,
  style: textTheme.bodyMedium?.copyWith(
    fontSize: width * 0.032,
    fontWeight: FontWeight.w400, // lighter feels softer
    height: 1.5,                 // breathe between lines
    letterSpacing: 0.1,
  ),
),

const SizedBox(height: 10),

// Badge
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        colorScheme.primary.withValues(alpha: 0.12),
        colorScheme.primary.withValues(alpha: 0.04),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: colorScheme.primary.withValues(alpha: 0.4),
      width: 1,
    ),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  child: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.primary.withValues(alpha: 0.12),
        boxShadow: [
          BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.45),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        Icons.favorite,
        size: 11,
        color: colorScheme.primary,
      ),
    ),

    const SizedBox(width: 8),

    Text(
      'Loved by 5k+ students',
      style: textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        fontSize: width * 0.030,
      ),
    ),
  ],
)
),
                    SizedBox(height: height * 0.01),


NeoPopButton(
    color: AppColors.lightFab,
    bottomShadowColor: colorScheme.primary.withValues(alpha: 0.25),
                        rightShadowColor: colorScheme.primary.withValues(alpha: 0.25),
    onTapUp: () => HapticFeedback.vibrate(),
    onTapDown: () => HapticFeedback.vibrate(),
    child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
      'Continue with Google',
      style: textTheme.bodyLarge?.copyWith(
        color: AppColors.lightSurface,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        fontSize: 14,
      ),
    ),
            ],
        ),
    ),
),
                      
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
