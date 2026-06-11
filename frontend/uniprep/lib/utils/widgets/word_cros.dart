import 'package:flutter/material.dart';
import 'package:uniprep/app/theme/app_colors.dart';

class VerticalWordColumn extends StatelessWidget {
  final List<String> words;

  const VerticalWordColumn({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.primary;
    final muted = AppColors.lightTextMuted;

    return Column(
      children: words.map((word) {
        final highlight =
            word == "SYNC" || word == "UNI" || word == "EXAMS";

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            word,
            style: TextStyle(
              color: highlight
                  ? accent
                  : muted.withValues(alpha: 0.4),
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              fontSize: 22,
            ),
          ),
        );
      }).toList(),
    );
  }
}


class WordCloudBackground extends StatefulWidget {
  const WordCloudBackground();

  @override
  State<WordCloudBackground> createState() => WordCloudBackgroundState();
}

class WordCloudBackgroundState extends State<WordCloudBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  // ── CONFIGURE YOUR HIGHLIGHTS HERE ──────────────────────────────────
  static const List<_WordDef> _highlightWords = [
_WordDef('PRACTICE',   xFrac: 0.10, yFrac: 0.04, size: 22, angleDeg: -4.0, color: const Color(0xFFFFD72F)),
_WordDef('CRACK',      xFrac: 0.62, yFrac: 0.08, size: 20, angleDeg:  3.5, color: Colors.white),

// brand anchor
_WordDef('UNIPREP',    xFrac: 0.30, yFrac: 0.20, size: 30, angleDeg: -2.5, color: Colors.white),

// main highlights
_WordDef('SOLVE',      xFrac: 0.08, yFrac: 0.38, size: 30, angleDeg: -2.5, color: const Color(0xFFFFD72F)),
_WordDef('ANALYZE',    xFrac: 0.68, yFrac: 0.35, size: 28, angleDeg:  3.0, color: const Color(0xFFFFD72F)),
_WordDef('MASTER',     xFrac: 0.35, yFrac: 0.55, size: 26, angleDeg: -1.5, color: const Color(0xFFFFD72F)),

// secondary highlight
_WordDef('IMPROVE',    xFrac: 0.54, yFrac: 0.44, size: 24, angleDeg:  2.0, color: Colors.white),

// closing highlight
_WordDef('PLACE',      xFrac: 0.40, yFrac: 0.70, size: 26, angleDeg: -3.0, color: const Color(0xFFFFD72F)),
 ];
  // ─────────────────────────────────────────────────────────────────────

  static const List<_WordDef> _noiseWords = [
    // — top zone (was empty before)
    _WordDef('APTITUDE',     xFrac: 0.04, yFrac: 0.02, size: 11, angleDeg:  2.0),
_WordDef('REASONING',    xFrac: 0.28, yFrac: 0.00, size: 10, angleDeg: -3.0),
_WordDef('QUANTS',       xFrac: 0.50, yFrac: 0.03, size:  9, angleDeg:  1.5),
_WordDef('PLACEMENTS',   xFrac: 0.76, yFrac: 0.01, size: 11, angleDeg: -2.5),
_WordDef('PRACTICE',     xFrac: 0.88, yFrac: 0.05, size: 10, angleDeg:  3.0),
_WordDef('PATTERNS',     xFrac: 0.38, yFrac: 0.12, size: 10, angleDeg: -1.5),
_WordDef('MOCKTEST',     xFrac: 0.82, yFrac: 0.10, size: 11, angleDeg:  2.5),

_WordDef('SPEED',        xFrac: 0.62, yFrac: 0.04, size: 10, angleDeg:  1.0),
_WordDef('ACCURACY',     xFrac: 0.78, yFrac: 0.08, size: 13, angleDeg: -2.0),
_WordDef('SHORTCUTS',    xFrac: 0.88, yFrac: 0.02, size: 11, angleDeg:  3.5),
_WordDef('ANALYSIS',     xFrac: 0.02, yFrac: 0.16, size: 11, angleDeg: -1.0),
_WordDef('LOGIC',        xFrac: 0.14, yFrac: 0.20, size: 12, angleDeg:  2.0),
_WordDef('PUZZLES',      xFrac: 0.24, yFrac: 0.14, size: 10, angleDeg: -3.5),
_WordDef('FORMULAS',     xFrac: 0.45, yFrac: 0.17, size: 11, angleDeg:  1.5),
_WordDef('NUMBERS',      xFrac: 0.58, yFrac: 0.13, size: 13, angleDeg: -2.0),
_WordDef('SOLVE',        xFrac: 0.70, yFrac: 0.19, size: 10, angleDeg:  3.0),
_WordDef('GUIDANCE',     xFrac: 0.91, yFrac: 0.22, size: 11, angleDeg: -1.5),

_WordDef('INTERVIEW',    xFrac: 0.06, yFrac: 0.30, size: 12, angleDeg:  2.5),
_WordDef('TRACKER',      xFrac: 0.22, yFrac: 0.27, size: 10, angleDeg: -2.0),
_WordDef('PROGRESS',     xFrac: 0.48, yFrac: 0.29, size: 11, angleDeg:  1.0),
_WordDef('LEARN',        xFrac: 0.68, yFrac: 0.31, size: 10, angleDeg: -3.0),
_WordDef('MASTERY',      xFrac: 0.85, yFrac: 0.26, size: 12, angleDeg:  2.0),

_WordDef('SECTIONS',     xFrac: 0.03, yFrac: 0.50, size: 11, angleDeg: -1.5),
_WordDef('VERBAL',       xFrac: 0.18, yFrac: 0.53, size: 10, angleDeg:  3.0),
_WordDef('RANKING',      xFrac: 0.29, yFrac: 0.47, size: 12, angleDeg: -2.5),
_WordDef('STRATEGY',     xFrac: 0.82, yFrac: 0.50, size: 11, angleDeg:  1.5),
_WordDef('FOCUS',        xFrac: 0.91, yFrac: 0.55, size: 10, angleDeg: -2.0),

_WordDef('GOALS',        xFrac: 0.05, yFrac: 0.62, size: 10, angleDeg:  2.5),
_WordDef('TIMEMGMT',     xFrac: 0.20, yFrac: 0.67, size: 12, angleDeg: -1.0),
_WordDef('QUESTIONS',    xFrac: 0.44, yFrac: 0.68, size: 11, angleDeg:  3.0),
_WordDef('REVISION',     xFrac: 0.65, yFrac: 0.63, size: 10, angleDeg: -2.0),
_WordDef('SCORES',       xFrac: 0.80, yFrac: 0.68, size: 12, angleDeg:  1.5),

_WordDef('COMPANIES',    xFrac: 0.25, yFrac: 0.79, size: 10, angleDeg: -3.0),
_WordDef('PREPARATION',  xFrac: 0.50, yFrac: 0.77, size: 12, angleDeg:  2.0),
_WordDef('ATTEMPTS',     xFrac: 0.72, yFrac: 0.80, size: 11, angleDeg: -1.5),

_WordDef('CAREER',       xFrac: 0.18, yFrac: 0.91, size: 12, angleDeg:  3.5),
_WordDef('SUCCESS',      xFrac: 0.40, yFrac: 0.89, size: 11, angleDeg: -2.0),
_WordDef('OFFER',        xFrac: 0.62, yFrac: 0.92, size: 10, angleDeg:  1.0),
_WordDef('SKILLS',       xFrac: 0.80, yFrac: 0.87, size: 12, angleDeg: -3.5),
  ];

  // radians conversion done once at use-site to keep consts clean
  static double _deg2rad(double deg) => deg * 0.017453292519943295;

  Color _resolveHighlightColor({
    required Color? seededColor,
    required Color accent,
    required Color onSurface,
  }) {
    if (seededColor == null) return accent;
    if (seededColor.value == Colors.white.value) {
      return onSurface.withValues(alpha: 0.82);
    }
    if (seededColor.value == const Color(0xFFFFD72F).value) {
      return accent;
    }
    return seededColor;
  }

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  double _carouselHeight(Size size) => size.height * 0.65;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final areaH = _carouselHeight(size);
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;
    final noiseColor = onSurface.withValues(alpha: 0.09);

    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
        stops: [0.0, 0.12, 0.72, 1.0],
      ).createShader(rect),
      blendMode: BlendMode.dstIn,
      child: Stack(
        children: [
          // ── NOISE — fully static, zero rebuild cost
          for (final w in _noiseWords)
            Positioned(
              left: w.xFrac * size.width,
              top: w.yFrac * areaH,
              child: Transform.rotate(
                angle: _deg2rad(w.angleDeg),
                alignment: Alignment.centerLeft,
                child: Text(
                  w.label,
                  style: TextStyle(
                    fontSize: w.size.toDouble(),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: noiseColor,
                  ),
                ),
              ),
            ),

          // ── HIGHLIGHTS — staggered pulse, single controller
          for (int i = 0; i < _highlightWords.length; i++)
            Positioned(
              left: _highlightWords[i].xFrac * size.width,
              top: _highlightWords[i].yFrac * areaH,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (_, __) {
                  final t = ((_pulse.value + i * (1.0 / _highlightWords.length)) % 1.0);
                  final opacity = 0.6 + 0.4 * Curves.easeInOut.transform(
                    t < 0.5 ? t * 2 : (1.0 - t) * 2,
                  );
                  return Opacity(
                    opacity: opacity,
                    child: Transform.rotate(
                      angle: _deg2rad(_highlightWords[i].angleDeg),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _highlightWords[i].label,
                        style: TextStyle(
                          fontSize: _highlightWords[i].size.toDouble(),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: _resolveHighlightColor(
                            seededColor: _highlightWords[i].color,
                            accent: accent,
                            onSurface: onSurface,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

@immutable
class _WordDef {
  final String label;
  final double xFrac;
  final double yFrac;
  final int size;
  final double angleDeg; // positive = clockwise tilt, negative = counter-clockwise
  final Color? color;

  const _WordDef(
    this.label, {
    required this.xFrac,
    required this.yFrac,
    required this.size,
    this.angleDeg = 0.0,
    this.color,
  });
}