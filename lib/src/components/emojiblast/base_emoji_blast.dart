import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';

enum Position { center, random }

enum Amount { low, medium, large }

class BaseEmojiBlast extends StatefulWidget {
  /// used for positioning of emoji blast
  final Size size;

  /// selected specific emote
  final String? emote;

  /// selected position
  final Position position;

  /// selected amount
  final Amount amount;

  const BaseEmojiBlast({
    this.emote,
    required this.size,
    required this.position,
    required this.amount,
    super.key,
  });

  @override
  State<BaseEmojiBlast> createState() => BaseEmojiBlastState();
}

class BaseEmojiBlastState extends State<BaseEmojiBlast>
    with SingleTickerProviderStateMixin {
  final List<Particle> _particles = [];
  late AnimationController _animationController;

  /// pre made list in case of no specific selection
  static List<String> _emojis = ['😀', '😂', '😍', '🥳', '🎉', '🔥'];

  /// getting starting position for emote blast
  Offset get _offset {
    switch (widget.position) {
      case Position.center:
        return Offset(widget.size.width / 2, widget.size.height / 2);
      case Position.random:
        final random = Random();
        return Offset(widget.size.width * random.nextDouble(),
            widget.size.height * random.nextDouble());
    }
  }

  /// amount of emotes in one blast
  int get _amount {
    switch (widget.amount) {
      case Amount.low:
        return 5;
      case Amount.medium:
        return 10;
      case Amount.large:
        return 15;
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _particles.removeWhere((p) => p.isCompleted());
        if (_particles.isNotEmpty) {
          _animationController.forward(from: 0.0);
        } else {
          _animationController.reset();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void blast() {
    final random = Random();
    final now = DateTime.now().millisecondsSinceEpoch;
    final offset = _offset;

    for (int i = 0; i < _amount; i++) {
      final selectedEmoji =
          widget.emote ?? _emojis[random.nextInt(_emojis.length)];
      final angle = random.nextDouble() * 2 * pi;
      final speed = random.nextDouble() * 40 + 30;
      final upwardVelocity = Offset(0, -120);
      final randomVelocity = Offset(cos(angle) * speed, sin(angle) * speed);
      final velocity = upwardVelocity + randomVelocity;

      final textPainter = TextPainter(
        text: TextSpan(
          text: selectedEmoji,
          style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF)),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      _particles.add(
        Particle(
          emoji: selectedEmoji,
          textPainter: textPainter,
          offset: offset,
          velocity: velocity,
          rotation: random.nextDouble() * 2 * pi,
          scale: random.nextDouble() * 0.6 + 0.6,
          gravity: 50,
          creationTime: now,
          decay: 0.9,
          lifetime: 2800,
        ),
      );
    }
    if (!_animationController.isAnimating) {
      _animationController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: EmojiPainter(
              particles: _particles,
              time:
                  _animationController.lastElapsedDuration?.inMilliseconds ?? 0,
            ),
            child: Container(),
          );
        });
  }
}

class EmojiPainter extends CustomPainter {
  final List<Particle> particles;
  final int time;

  EmojiPainter({required this.particles, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // paiting the new position of each emote
    for (var particle in particles) {
      final progress = (now - particle.creationTime) / particle.lifetime;
      if (progress < 0 || progress > 1) continue;

      final newPosition = Offset(
        particle.offset.dx +
            particle.velocity.dx *
                progress *
                10 *
                pow(particle.decay, progress * 10),
        particle.offset.dy +
            particle.velocity.dy * progress * 10 +
            0.5 * particle.gravity * progress * progress * 100,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: particle.emoji,
          style: TextStyle(
              fontSize: 30 * particle.scale,
              color: UnpingColorExtension.dark.neutral50),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      canvas.save();
      canvas.translate(newPosition.dx, newPosition.dy);
      canvas.rotate(particle.rotation * progress);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  final String emoji;
  final TextPainter textPainter;
  final Offset offset;
  final Offset velocity;
  final double rotation;
  final double scale;
  final double gravity;
  final int creationTime;
  final double decay;
  final int lifetime;

  Particle({
    required this.emoji,
    required this.textPainter,
    required this.offset,
    required this.velocity,
    required this.rotation,
    required this.scale,
    required this.gravity,
    required this.creationTime,
    required this.decay,
    required this.lifetime,
  });

  bool isCompleted() {
    return (DateTime.now().millisecondsSinceEpoch - creationTime) > lifetime;
  }
}
