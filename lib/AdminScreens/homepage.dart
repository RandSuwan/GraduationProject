import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/AdminScreens/pie_chart.dart';
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/utilities/constants.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<PieChartSectionData> sectionsDiamond = [];
  List<LegendItemData> legendDiamond = [];
  List<PieChartSectionData> sectionsGold = [];
  List<LegendItemData> legendGold = [];
  List<DataRow> rowsDiamond = [];
  List<DataRow> rowsGold = [];
  List<PieChartSectionData> diamondSalesSections = [];
  List<LegendItemData> diamondSalesLegendItems = [];
  List<PieChartSectionData> goldSalesSections = [];
  List<LegendItemData> goldSalesLegendItems = [];
  int ringCount = 0;
  int necklaceCount = 0;
  int braceletCount = 0;
  int earringCount = 0;
  int setCount = 0;

  @override
  void initState() {
    super.initState();
    fetchItemCounts().then((_) {
      fetchTotalAmounts().then((_) {
        setState(() {
          diamondSalesSections = getDiamondSalesSections();
          diamondSalesLegendItems = getDiamondSalesLegendItems();
        });
      });
      fetchTotalGoldAmounts().then((_) {
        setState(() {
          goldSalesSections = getGoldSalesSections();
          goldSalesLegendItems = getGoldSalesLegendItems();
        });
      });
      print("Ring Count: $ringCount");
    });
    fetchDiamondPercentages();
    fetchGoldPercentages();
  }

  Future<void> fetchDiamondPercentages() async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchDiamondPercentages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        sectionsDiamond = data.map((item) {
          return PieChartSectionData(
            value: (item['percentage'] as num).toDouble(),
            color: getColorDiamond(item['category']),
            title: '${item['percentage'].toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList();

        legendDiamond = data.map((item) {
          return LegendItemData(
              color: getColorDiamond(item['category']), text: item['category']);
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Color getColorDiamond(String category) {
    switch (category) {
      case 'Ring':
        return Colors.grey[900]!;
      case 'Necklace':
        return Colors.grey[800]!;
      case 'Bracelet':
        return Colors.grey[700]!;
      case 'Earring':
        return Colors.grey[600]!;
      case 'Set':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Future<void> fetchGoldPercentages() async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchGoldPercentages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        sectionsGold = data.map((item) {
          return PieChartSectionData(
            value: (item['percentage'] as num).toDouble(),
            color: getColorGold(item['category']),
            title: '${item['percentage'].toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList();

        legendGold = data.map((item) {
          return LegendItemData(
              color: getColorGold(item['category']), text: item['category']);
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Color getColorGold(String category) {
    switch (category) {
      case 'Ring':
        return Colors.yellow[700]!;
      case 'Necklace':
        return Colors.yellow[600]!;
      case 'Bracelet':
        return Colors.yellow[500]!;
      case 'Earring':
        return Colors.yellow[400]!;
      case 'Set':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }

  Future<void> fetchTotalAmounts() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchTotalAmounts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        rowsDiamond = data.map((item) {
          int count = 0;
          double percentage = 0;
          switch (item['category']) {
            case 'Ring':
              count = ringCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Necklace':
              count = necklaceCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Bracelet':
              count = braceletCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Earring':
              count = earringCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Set':
              count = setCount;
              percentage = count / item['totalAmount'] * 100;
              break;
          }
          return DataRow(cells: [
            DataCell(Text(item['category'])),
            DataCell(
                Text(item['totalAmount'].toString())), // Total amount of items
            DataCell(Text(count.toString())), // Number of sold items
          ]);
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchTotalGoldAmounts() async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:5000/fetchTotalGoldAmounts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        rowsGold = data.map((item) {
          int count = 0;
          double percentage = 0;
          switch (item['category']) {
            case 'Ring':
              count = ringCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Necklace':
              count = necklaceCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Bracelet':
              count = braceletCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Earring':
              count = earringCount;
              percentage = count / item['totalAmount'] * 100;
              break;
            case 'Set':
              count = setCount;
              percentage = count / item['totalAmount'] * 100;
              break;
          }
          return DataRow(cells: [
            DataCell(Text(item['category'])),
            DataCell(
                Text(item['totalAmount'].toString())), // Total amount of items
            DataCell(Text(count.toString())), // Number of sold items
          ]);
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchItemCounts() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:5000/fetchItemCounts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        for (var item in data) {
          switch (item['category']) {
            case 'Ring':
              ringCount = item['count'];
              break;
            case 'Necklace':
              necklaceCount = item['count'];
              break;
            case 'Bracelet':
              braceletCount = item['count'];
              break;
            case 'Earring':
              earringCount = item['count'];
              break;
            case 'Set':
              setCount = item['count'];
              break;
          }
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.97;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kourcolor1,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space between items
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          " App Rating",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "4/5",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Color(0xFFDEDBDB),
                width: containerWidth,
                child: Text(
                  "Items Percentage:",
                  style: TextStyle(
                      fontSize: 22,
                      color: kourcolor1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PieChartWidget(
              title: "Diamond",
              sections: sectionsDiamond,
              legendItems: legendDiamond,
            ),
            SizedBox(
              height: 20,
            ),
            PieChartWidget(
              title: "Gold",
              sections: sectionsGold,
              legendItems: legendGold,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Color(0xFFDEDBDB),
                width: containerWidth,
                child: Text(
                  "Sales Percentage:",
                  style: TextStyle(
                      fontSize: 22,
                      color: kourcolor1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            PieChartWidget(
              title: "Diamond",
              sections: diamondSalesSections,
              legendItems: diamondSalesLegendItems,
            ),
            SizedBox(
              height: 20,
            ),
            PieChartWidget(
              title: "Gold",
              sections: getGoldSalesSections(),
              legendItems: getGoldSalesLegendItems(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Color(0xFFDEDBDB),
                width: containerWidth,
                child: Text(
                  "Number Summary:",
                  style: TextStyle(
                      fontSize: 22,
                      color: kourcolor1,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: containerWidth,
                child: Text(
                  "Diamond:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Color(0xFFDEDBDB),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  child: rowsDiamond.isEmpty
                      ? buildSummaryTable()
                      : buildDataTable(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: containerWidth,
                child: Text(
                  "Gold:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Color(0xFFDEDBDB),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  child: rowsGold.isEmpty
                      ? buildSummaryTable()
                      : buildDataTableGold(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getDiamondSalesSections() {
    final totalCount =
        ringCount + necklaceCount + braceletCount + earringCount + setCount;
    if (totalCount == 0) {
      return [];
    }
    return [
      PieChartSectionData(
        value: ringCount / totalCount * 100,
        color: Colors.blue[900],
        title: '${(ringCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: necklaceCount / totalCount * 100,
        color: Colors.blue[800],
        title: '${(necklaceCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: braceletCount / totalCount * 100,
        color: Colors.blue[700],
        title: '${(braceletCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: earringCount / totalCount * 100,
        color: Colors.blue[600],
        title: '${(earringCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: setCount / totalCount * 100,
        color: Colors.blue,
        title: '${(setCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  List<LegendItemData> getDiamondSalesLegendItems() {
    return [
      LegendItemData(color: Colors.blue[900]!, text: 'Rings'),
      LegendItemData(color: Colors.blue[800]!, text: 'Necklaces'),
      LegendItemData(color: Colors.blue[700]!, text: 'Bracelets'),
      LegendItemData(color: Colors.blue[600]!, text: 'Earrings'),
      LegendItemData(color: Colors.blue, text: 'Sets'),
    ];
  }

  List<PieChartSectionData> getGoldSalesSections() {
    final totalCount =
        ringCount + necklaceCount + braceletCount + earringCount + setCount;
    if (totalCount == 0) {
      return [];
    }
    return [
      PieChartSectionData(
        value: ringCount / totalCount * 100,
        color: Colors.green[900],
        title: '${(ringCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: necklaceCount / totalCount * 100,
        color: Colors.green[800],
        title: '${(necklaceCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: braceletCount / totalCount * 100,
        color: Colors.green[700],
        title: '${(braceletCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: earringCount / totalCount * 100,
        color: Colors.green[600],
        title: '${(earringCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: setCount / totalCount * 100,
        color: Colors.green,
        title: '${(setCount / totalCount * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  List<LegendItemData> getGoldSalesLegendItems() {
    return [
      LegendItemData(color: Colors.green[900]!, text: 'Rings'),
      LegendItemData(color: Colors.green[800]!, text: 'Necklaces'),
      LegendItemData(color: Colors.green[700]!, text: 'Bracelets'),
      LegendItemData(color: Colors.green[600]!, text: 'Earings'),
      LegendItemData(color: Colors.green, text: 'Sets'),
    ];
  }

  Widget buildSummaryTable() {
    return DataTable(
      columnSpacing: 10,
      columns: const [
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Text(
              'Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  'Number ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'of Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 95,
            child: Column(
              children: [
                Text(
                  'Number of',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sold Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      rows: _buildPlaceholderRows(),
    );
  }

  Widget buildDataTable() {
    return DataTable(
      columnSpacing: 10,
      columns: const [
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Text(
              'Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  'Number ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'of Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 95,
            child: Column(
              children: [
                Text(
                  'Number of',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sold Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      rows: rowsDiamond,
    );
  }

  Widget buildDataTableGold() {
    return DataTable(
      columnSpacing: 10,
      columns: const [
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Text(
              'Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  'Number ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'of Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        DataColumn(
          label: SizedBox(
            width: 95,
            child: Column(
              children: [
                Text(
                  'Number of',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sold Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
      rows: rowsGold,
    );
  }

  List<DataRow> _buildPlaceholderRows() {
    return const [
      DataRow(cells: [
        DataCell(Text('Diamond Rings')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Diamond Necklaces')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Diamond Bracelets')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Diamond Earrings')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Diamond Sets')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Gold Rings')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Gold Necklaces')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Gold Bracelets')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Gold Earrings')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
      DataRow(cells: [
        DataCell(Text('Gold Sets')),
        DataCell(Text('0')),
        DataCell(Text('0')),
      ]),
    ];
  }
}

  // Widget buildSummaryTable() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Container(
  //         color: Color(0xFFDEDBDB),
  //         constraints:
  //             BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
  //         child: DataTable(
  //           columnSpacing: 10,
  //           columns: const [
  //             DataColumn(
  //               label: SizedBox(
  //                 width: 100,
  //                 child: Text(
  //                   'Category',
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //             DataColumn(
  //               label: SizedBox(
  //                 width: 100,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       'Number ',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       'of Items',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             DataColumn(
  //               label: SizedBox(
  //                 width: 95,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       'Number of',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       'Sold Items',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //           rows: const [
  //             DataRow(cells: [
  //               DataCell(Text('Diamond Rings')),
  //               DataCell(Text('100')),
  //               DataCell(Text('60')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Diamond Necklaces')),
  //               DataCell(Text('80')),
  //               DataCell(Text('50')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Diamond Bracelets')),
  //               DataCell(Text('70')),
  //               DataCell(Text('45')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Diamond Earrings')),
  //               DataCell(Text('90')),
  //               DataCell(Text('55')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Diamond Sets')),
  //               DataCell(Text('60')),
  //               DataCell(Text('30')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Gold Rings')),
  //               DataCell(Text('120')),
  //               DataCell(Text('80')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Gold Necklaces')),
  //               DataCell(Text('100')),
  //               DataCell(Text('70')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Gold Bracelets')),
  //               DataCell(Text('110')),
  //               DataCell(Text('65')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Gold Earrings')),
  //               DataCell(Text('90')),
  //               DataCell(Text('50')),
  //             ]),
  //             DataRow(cells: [
  //               DataCell(Text('Gold Sets')),
  //               DataCell(Text('70')),
  //               DataCell(Text('40')),
  //             ]),
  //           ],
  //         ),
  //       ),
  //     ),
//   );
// }