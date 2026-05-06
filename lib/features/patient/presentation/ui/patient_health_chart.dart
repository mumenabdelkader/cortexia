import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientVitalChart extends StatelessWidget {
  final List<dynamic> records;

  const PatientVitalChart({super.key, required this.records});

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is bool) return value ? 1.0 : 0.0;
    return double.tryParse(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    // 1. التحقق من القائمة
    if (records.isEmpty) {
      return const Center(child: Text('لا توجد بيانات متاحة'));
    }

    // 2. أخذ نسخة من القائمة لتجنب تعديل القائمة الأصلية أثناء الترتيب
    List<dynamic> sortedRecords = List.from(records);
    sortedRecords.sort((a, b) {
      final dateA = DateTime.parse(a['recordedAt']);
      final dateB = DateTime.parse(b['recordedAt']);
      return dateA.compareTo(dateB);
    });

    // 3. تحديد الحدود
    final double minX = DateTime.parse(sortedRecords.first['recordedAt'])
        .toLocal()
        .millisecondsSinceEpoch
        .toDouble();
    final double maxX = DateTime.parse(sortedRecords.last['recordedAt'])
        .toLocal()
        .millisecondsSinceEpoch
        .toDouble();

    // 4. تجهيز النقاط
    List<FlSpot> tempSpots = [];
    List<FlSpot> sysSpots = [];
    List<FlSpot> diaSpots = [];
    List<FlSpot> hrSpots = [];
    List<FlSpot> rrSpots = [];
    List<FlSpot> spo2Spots = [];
    List<FlSpot> o2Spots = [];

    for (var record in sortedRecords) {
      final double timeX = DateTime.parse(record['recordedAt'])
          .toLocal()
          .millisecondsSinceEpoch
          .toDouble();

      final temp = _parseDouble(record['temperature']);
      final sys = _parseDouble(record['bpSystolic'] ?? record['bP_Systolic']); // للتعامل مع أي من الاسمين
      final dia = _parseDouble(record['bpDiastolic'] ?? record['bP_Diastolic']);
      final hr = _parseDouble(record['heartRate']);
      final rr = _parseDouble(record['respRate']);
      final spo2 = _parseDouble(record['pulseOxy']);
      final o2 = _parseDouble(record['supplementalOxygen']);

      if (temp != null) tempSpots.add(FlSpot(timeX, temp));
      if (sys != null) sysSpots.add(FlSpot(timeX, sys));
      if (dia != null) diaSpots.add(FlSpot(timeX, dia));
      if (hr != null) hrSpots.add(FlSpot(timeX, hr));
      if (rr != null) rrSpots.add(FlSpot(timeX, rr));
      if (spo2 != null) spo2Spots.add(FlSpot(timeX, spo2));
      if (o2 != null) o2Spots.add(FlSpot(timeX, o2));
    }

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              getTitlesWidget: (value, meta) {
                final DateTime date =
                DateTime.fromMillisecondsSinceEpoch(value.toInt());
                final String timeStr = DateFormat('HH:mm').format(date);
                final String dateStr = DateFormat('d MMM').format(date);

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(timeStr,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      Text(dateStr,
                          style: const TextStyle(
                              fontSize: 9, color: Colors.grey)),
                    ],
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 40 == 0) return Text(value.toInt().toString());
                return const Text('');
              },
              reservedSize: 35,
            ),
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(
            show: true, border: Border.all(color: Colors.grey.withOpacity(0.5))),
        minX: minX,
        maxX: minX == maxX ? maxX + 3600000 : maxX,
        minY: 0,
        maxY: 200,
        lineBarsData: [
          LineChartBarData(
            spots: tempSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: sysSpots,
            isCurved: true,
            color: Colors.indigo,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: diaSpots,
            isCurved: true,
            color: Colors.lightBlue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: hrSpots,
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: rrSpots,
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: spo2Spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: o2Spots,
            isCurved: true,
            color: Colors.brown,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}