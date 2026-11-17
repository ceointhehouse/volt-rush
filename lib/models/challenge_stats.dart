/// G2 fixture — medium cross-fork PR (ceointhehouse fork).
class ChallengeStats {
  final double metric1;
  final double metric2;
  final double metric3;
  final double metric4;
  final double metric5;
  final double metric6;
  final double metric7;
  final double metric8;
  final double metric9;
  final double metric10;
  final double metric11;
  final double metric12;
  final double metric13;
  final double metric14;
  final double metric15;
  final double metric16;
  final double metric17;
  final double metric18;
  final double metric19;
  final double metric20;
  final double metric21;
  final double metric22;
  final double metric23;
  final double metric24;
  ChallengeStats({
    required this.metric1,
    required this.metric2,
    required this.metric3,
    required this.metric4,
    required this.metric5,
    required this.metric6,
    required this.metric7,
    required this.metric8,
    required this.metric9,
    required this.metric10,
    required this.metric11,
    required this.metric12,
    required this.metric13,
    required this.metric14,
    required this.metric15,
    required this.metric16,
    required this.metric17,
    required this.metric18,
    required this.metric19,
    required this.metric20,
    required this.metric21,
    required this.metric22,
    required this.metric23,
    required this.metric24,
  });

  double get composite {
    final values = <double>[
      metric1,
      metric2,
      metric3,
      metric4,
      metric5,
      metric6,
      metric7,
      metric8,
      metric9,
      metric10,
      metric11,
      metric12,
      metric13,
      metric14,
      metric15,
      metric16,
      metric17,
      metric18,
      metric19,
      metric20,
      metric21,
      metric22,
      metric23,
      metric24,
    ];
    return values.reduce((a, b) => a + b) / values.length;
  }

  Map<String, double> toMap() => {
      'metric1': metric1,
      'metric2': metric2,
      'metric3': metric3,
      'metric4': metric4,
      'metric5': metric5,
      'metric6': metric6,
      'metric7': metric7,
      'metric8': metric8,
      'metric9': metric9,
      'metric10': metric10,
      'metric11': metric11,
      'metric12': metric12,
      'metric13': metric13,
      'metric14': metric14,
      'metric15': metric15,
      'metric16': metric16,
      'metric17': metric17,
      'metric18': metric18,
      'metric19': metric19,
      'metric20': metric20,
      'metric21': metric21,
      'metric22': metric22,
      'metric23': metric23,
      'metric24': metric24,
  };

  static ChallengeStats fromMap(Map<String, dynamic> map) => ChallengeStats(
      metric1: (map['metric1'] as num?)?.toDouble() ?? 0.0,
      metric2: (map['metric2'] as num?)?.toDouble() ?? 0.0,
      metric3: (map['metric3'] as num?)?.toDouble() ?? 0.0,
      metric4: (map['metric4'] as num?)?.toDouble() ?? 0.0,
      metric5: (map['metric5'] as num?)?.toDouble() ?? 0.0,
      metric6: (map['metric6'] as num?)?.toDouble() ?? 0.0,
      metric7: (map['metric7'] as num?)?.toDouble() ?? 0.0,
      metric8: (map['metric8'] as num?)?.toDouble() ?? 0.0,
      metric9: (map['metric9'] as num?)?.toDouble() ?? 0.0,
      metric10: (map['metric10'] as num?)?.toDouble() ?? 0.0,
      metric11: (map['metric11'] as num?)?.toDouble() ?? 0.0,
      metric12: (map['metric12'] as num?)?.toDouble() ?? 0.0,
      metric13: (map['metric13'] as num?)?.toDouble() ?? 0.0,
      metric14: (map['metric14'] as num?)?.toDouble() ?? 0.0,
      metric15: (map['metric15'] as num?)?.toDouble() ?? 0.0,
      metric16: (map['metric16'] as num?)?.toDouble() ?? 0.0,
      metric17: (map['metric17'] as num?)?.toDouble() ?? 0.0,
      metric18: (map['metric18'] as num?)?.toDouble() ?? 0.0,
      metric19: (map['metric19'] as num?)?.toDouble() ?? 0.0,
      metric20: (map['metric20'] as num?)?.toDouble() ?? 0.0,
      metric21: (map['metric21'] as num?)?.toDouble() ?? 0.0,
      metric22: (map['metric22'] as num?)?.toDouble() ?? 0.0,
      metric23: (map['metric23'] as num?)?.toDouble() ?? 0.0,
      metric24: (map['metric24'] as num?)?.toDouble() ?? 0.0,
  );

  @override
  String toString() => \"ChallengeStats(composite: \${composite.toStringAsFixed(2)})\";
}
