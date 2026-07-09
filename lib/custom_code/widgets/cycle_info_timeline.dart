// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'dart:ui' as ui;

class CycleInfoTimeline extends StatefulWidget {
  const CycleInfoTimeline({
    super.key,
    this.width,
    this.height,
    required this.cycles,
    this.selectedDate,
    // Current cycle phase — determines which content to show
    // Possible values: 'Менструация', 'Фолликулярная', 'Овуляция', 'Лютеиновая'
    this.phase,
  });

  final double? width;
  final double? height;
  final List<MonthCycleStruct> cycles;
  final DateTime? selectedDate;
  final String? phase;

  @override
  State<CycleInfoTimeline> createState() => _CycleInfoTimelineState();
}

class _CycleInfoTimelineState extends State<CycleInfoTimeline> {
  // Phase index: 0=Менструация, 1=Фолликулярная, 2=Овуляция, 3=Лютеиновая
  int get _phaseIndex {
    final effectivePhase = widget.selectedDate != null
        ? cyclePhase(widget.cycles, widget.selectedDate) ?? widget.phase
        : widget.phase;

    switch (effectivePhase) {
      case 'Менструация':
        return 0;
      case 'Фолликулярная':
        return 1;
      case 'Овуляция':
        return 2;
      case 'Лютеиновая':
        return 3;
      default:
        return 3; // default to luteal
    }
  }

  // Content indexed by [phaseIndex][sectionIndex]
  // Sections: 0=Ощущения, 1=Ритуалы, 2=Питание, 3=Движение, 4=Вопрос
  static const List<List<String>> _content = [
    // 0 — Менструация
    [
      'Меньше энергии и больше потребности в отдыхе — эстроген и прогестерон на минимуме. Из-за сокращений матки могут быть тянущие ощущения внизу живота.',
      'Замедление: тёплый душ, отдых, ранний сон – поддержка организма. Меньше дел и больше прислушиваться к себе.',
      'Тёплая, сытная еда. В качестве белка отлично подойдут курица, рыба, творог и греческий йогурт. А для поддержки железа — гречка, красное мясо, шпинат. Витамин C дают фрукты и ягоды. Если аппетит стал сильнее, то это нормально.',
      'По самочувствию: прогулка или мягкая растяжка, а если хочется просто лежать, то отдых важнее.',
      'Как я могу позаботиться о себе?',
    ],
    // 1 — Фолликулярная
    [
      'Эстроген растёт, поэтому часто появляется больше энергии, ясности и мотивации. Хочется двигаться быстрее и легче включаться в дела.',
      'Время продуктивности: планирование, новые задачи и привычки. Хорошо подойдут прогулки и больше дневного света.',
      'Лёгкая, но питательная еда: белок, овощи, цельные крупы. Подойдут курица, рыба, творог или йогурт, бобовые, гречка, рис, овсянка.',
      'Если есть силы, то силовые или кардио по самочувствию. Хорошо подходят тренировки средней интенсивности.',
      'На что я хочу направить свой фокус и внимание?',
    ],
    // 2 — Овуляция
    [
      'Эстроген на пике, затем происходит всплеск ЛГ, может ощущаться подъем энергии, либидо становится выше. Иногда бывает легкая тянущая боль с одной стороны.',
      'Пик энергии: свидания, близость, встречи, важные разговоры и дела, где нужно быть на виду. Можно заранее запланировать то, что требует уверенности.',
      'Стабильность и легкость: белок, овощи, ягоды, полезные жиры. Подойдут рыба, курица, творог или йогурт, авокадо, орехи, оливковое масло, меньше избытка сладкого и алкоголя.',
      'Пик формы. Тренировки по желанию, можно интенсивнее. Если тянет низ живота нужно снизить темп.',
      'Где я могу проявиться ярче и смелее?',
    ],
    // 3 — Лютеиновая
    [
      'Повышается прогестерон, темп может замедляться и больше хочется уюта и сна. Гормоны снижаются. ПМС-ощущения: раздражительность, слабость, вздутие, тяга к сладкому, отёки.',
      'Бережность и меньше стресса, больше пауз и любви к себе. Если хочется меньше контактов, лучше выбрать тишину и восстановление.',
      'Сложные углеводы, белок и клетчатка: гречка, овсянка, картофель, овощи, курица или рыба, творог и орехи. При отеках меньше соли и больше воды. Если аппетит стал сильнее, то это нормально.',
      'Прислушиваться к телу. Умеренная ходьба, пилатес. При ПМС лучше без перегруза.',
      'Как я могу дать себе много любви сегодня?',
    ],
  ];

  static const List<String> _labels = [
    'Какие могут\nбыть ощущения',
    'Ритуалы',
    'Питание',
    'Движение',
    'Вопрос к себе',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> content = _content[_phaseIndex];

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < _labels.length; i++) ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: dot + dashed line
                  SizedBox(
                    width: 16.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildDot(),
                        if (i < _labels.length - 1)
                          Expanded(
                            child: Container(
                              width: 1.0,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomPaint(
                                painter: _DashedLinePainter(
                                  color: const Color(0x66FFD6AA),
                                  dashHeight: 4.0,
                                  dashGap: 4.0,
                                  lineWidth: 1.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // Right: label + content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: i < _labels.length - 1 ? 24.0 : 0.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              _labels[i],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                height: 1.38,
                                letterSpacing: -0.65,
                                color: Color(0xA3FFD6AA),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            flex: 2,
                            child: Text(
                              content[i],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                height: 1.38,
                                letterSpacing: -0.65,
                                color: Color(0xE1FFD6AA),
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
          ],
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 16.0,
      height: 16.0,
      decoration: const BoxDecoration(
        color: Color(0x3DFFFFFF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 6.0,
          height: 6.0,
          decoration: const BoxDecoration(
            color: Color(0xE1FFD6AA),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;
  final double dashGap;
  final double lineWidth;

  const _DashedLinePainter({
    required this.color,
    required this.dashHeight,
    required this.dashGap,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double y = 0;
    while (y < size.height) {
      final double end = (y + dashHeight).clamp(0.0, size.height);
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, end),
        paint,
      );
      y += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) =>
      old.color != color ||
      old.dashHeight != dashHeight ||
      old.dashGap != dashGap ||
      old.lineWidth != lineWidth;
}
