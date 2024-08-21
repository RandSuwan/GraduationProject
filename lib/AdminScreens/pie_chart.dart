import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class PieChartWidget extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final List<LegendItemData> legendItems;
  final String title;

  PieChartWidget({required this.sections, required this.legendItems, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        // Pie Chart
        Center(
          child: Container(
            height: 200,
            width: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: sections,
              ),
            ),
          ),
        ),
        // Legend
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendItems.map((item) => LegendItem(color: item.color, text: item.text)).toList(),
          ),
        ),
      ],
    );
  }
}

class LegendItemData {
  final Color color;
  final String text;

  LegendItemData({required this.color, required this.text});
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
