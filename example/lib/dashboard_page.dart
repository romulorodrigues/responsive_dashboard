import 'dart:math';

import 'package:easy_flutter_charts/easy_flutter_charts.dart';
import 'package:easy_flutter_charts/models/line_chart_series.dart';
import 'package:easy_flutter_table/easy_flutter_table.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/responsive_dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loading = true;

  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });

    final random = Random();
    final names = [
      'Alice',
      'Bob',
      'Charlie',
      'Diana',
      'Ethan',
      'Fiona',
      'George',
      'Hannah',
      'Ian',
      'Julia'
    ];
    final mothers = ['Mary', 'Susan', 'Linda', 'Patricia', 'Karen', 'Nancy'];
    final followUpOptions = ['Yes', 'No'];

    items = List.generate(2000, (index) {
      final id = index + 1;
      final name = '${names[random.nextInt(names.length)]} ${[
        'Smith',
        'Johnson',
        'Brown',
        'Taylor'
      ][random.nextInt(4)]}';
      final birthDate = DateTime(1970 + random.nextInt(30),
          1 + random.nextInt(12), 1 + random.nextInt(28));
      final appointmentDate =
          DateTime(2025, 7 + random.nextInt(2), 1 + random.nextInt(28));

      return {
        'id': id,
        'name': name,
        'birth_date':
            '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}',
        'mother': mothers[random.nextInt(mothers.length)],
        'next_appointment':
            '${appointmentDate.year}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}',
        'follow_up': followUpOptions[random.nextInt(2)],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final headers = [
      HeaderItem(text: 'ID', value: 'id', filterable: true, align: 'start'),
      HeaderItem(
          textWidget: Tooltip(
            message: 'Username',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.info, size: 16, color: Colors.black),
                SizedBox(width: 4),
                Text('Name'),
              ],
            ),
          ),
          value: 'name',
          filterable: true,
          align: 'start'),
      HeaderItem(
        text: 'Birth Date',
        value: 'birth_date',
        align: 'start',
        width: '150px',
      ),
      HeaderItem(
          text: 'Mother', value: 'mother', filterable: true, align: 'start'),
      HeaderItem(
          text: 'Next Appointment', value: 'next_appointment', align: 'start'),
      HeaderItem(
          textWidget: Tooltip(
            message: 'Follow-up',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                SizedBox(width: 4),
                Text('Status'),
              ],
            ),
          ),
          value: 'follow_up',
          align: 'start',
          sortable: false),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double maxWidth = constraints.maxWidth;
          int columns = 1;
          if (maxWidth >= 1200) {
            columns = 3;
          } else if (maxWidth >= 800) {
            columns = 2;
          }
          final double spacing = 16;
          final double cardWidth =
              (maxWidth - spacing * (columns - 1)) / columns;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Row(
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   width: cardWidth,
              //   child: CustomCard(
              //     margin: EdgeInsets.all(0),
              //     header: const Text(
              //       'Card Title',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     body: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: const [
              //         Text(
              //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et accumsan nibh. Ut at elementum mi. Praesent eu nisi ut dui fringilla tincidunt. In in facilisis erat. Fusce tempor dolor nec mauris pulvinar venenatis. Donec sagittis lorem ac sem iaculis pellentesque. Ut tincidunt posuere purus. Sed mauris massa, dapibus ac aliquam sit amet, posuere sit amet elit.'),
              //         const SizedBox(
              //           height: 8,
              //         ),
              //         Text(
              //             'Aenean ac ullamcorper leo. Nam fermentum venenatis blandit. Duis venenatis, neque eget tincidunt suscipit, elit metus efficitur dolor, et tincidunt arcu massa eget felis. Donec mollis porttitor massa vel blandit. Sed ut dapibus ante. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse potenti.'),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                width: cardWidth,
                child: CustomCard(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(30),
                  body: Center(
                    child: SizedBox(
                      height: 400,
                      width: 600,
                      child: BarChart(
                        title: 'Vendas por país',
                        titleStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        data: [
                          BarChartData(
                              label: 'Alemanha', value: 50, color: Colors.blue),
                          BarChartData(
                              label: 'Brasil', value: 80, color: Colors.red),
                          BarChartData(
                              label: 'Camarões',
                              value: 30,
                              color: Colors.green),
                          BarChartData(
                            label: ['Estados', 'Unidos', 'da América'],
                            value: 100,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: CustomCard(
                    margin: EdgeInsets.all(0),
                    header: const Text(
                      'Data',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    body: Center(
                      child: SizedBox(
                        height: 350,
                        width: 600,
                        child: LineChart(
                          title: 'Temperatura Diária',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          series: [
                            LineChartSeries(
                              name: 'Máxima',
                              color: Colors.red,
                              data: [
                                LineChartData(label: 'Segunda', value: 30),
                                LineChartData(label: 'Terça', value: 32),
                                LineChartData(label: 'Quarta', value: 31),
                                LineChartData(label: 'Quinta', value: 33),
                                LineChartData(label: 'Sexta', value: 29),
                              ],
                            ),
                            LineChartSeries(
                              name: 'Média',
                              color: Colors.orange,
                              data: [
                                LineChartData(label: 'Segunda', value: 27),
                                LineChartData(label: 'Terça', value: 25),
                                LineChartData(label: 'Quarta', value: 21),
                                LineChartData(label: 'Quinta', value: 29),
                              ],
                            ),
                            LineChartSeries(
                              name: 'Mínima',
                              color: Colors.blue,
                              data: [
                                LineChartData(label: 'Segunda', value: 20),
                                LineChartData(label: 'Terça', value: 21),
                                LineChartData(label: 'Quarta', value: 19),
                              ],
                            ),
                          ],
                          yAxisLabelFormatter: (v) =>
                              '${v.toStringAsFixed(0)}°C',
                          yAxisLabelStyle: TextStyle(fontSize: 10),
                          xAxisLabelFormatter: (label) => label.toString(),
                          xAxisLabelStyle: TextStyle(fontSize: 10),
                          showDots: true,
                          showGrid: true,
                          xAxis: [
                            'Segunda',
                            'Terça',
                            ['Quarta', 'feira'],
                          ],
                          // lineTooltipBuilder: (serie, point) =>
                          //     '${serie.name}: ${point.label}: ${point.value} °C',
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: cardWidth,
                child: CustomCard(
                  margin: EdgeInsets.all(0),
                  header: const Text(
                    'Data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  body: Center(
                    child: RadialBarChart(
                      data: [
                        RadialBarData(
                            value: 40, color: Colors.blue, label: 'Azul'),
                        RadialBarData(
                            value: 30, color: Colors.green, label: 'Verde'),
                        RadialBarData(
                            value: 20, color: Colors.orange, label: 'Laranja'),
                        RadialBarData(
                            value: 60, color: Colors.red, label: 'Vermelho'),
                      ],
                      centerTextBuilder: (data) =>
                          '${data.label}\n${data.value} unidades',
                      centerTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      aspectRatio: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomCard(
                  margin: EdgeInsets.all(0),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Card with Actions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      CustomDropdown(
                        button: const Icon(Icons.more_vert),
                        dropdownContent: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit'),
                              onTap: () => debugPrint('Edit clicked'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Delete'),
                              onTap: () => debugPrint('Delete clicked'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  body: EasyTable(
                    headers: headers,
                    items: items,
                    primaryKey: 'id',
                    expanded: true,
                    searchBarStyle: SearchBarStyle(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.filter_list),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    loadingConfig: LoadingItem(
                      enabled: _loading,
                      message: 'Fetching users...',
                      color: Colors.blue,
                    ),
                    showSelect: true,
                    onSelectionChanged: (selectedItems) {
                      print('Selected: $selectedItems');
                    },
                    // rowStyleBuilder: (item, index) {
                    //   return BoxDecoration(
                    //     color: item['follow_up'] == 'Yes' ? Colors.green : Colors.white,
                    //     border: Border(
                    //       bottom: BorderSide(color: Colors.grey.shade300),
                    //     ),
                    //   );
                    // },
                    style: const TableStyle(
                      backgroundColor: Colors.white,
                      striped: true,
                      cellPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                    expandedBuilder: (item) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Details for: ${item['name']}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    cellBuilder: (item, header) {
                      if (header.value == 'birth_date') {
                        final raw = item['birth_date'];
                        if (raw == null || raw is! String)
                          return const Text('-');
                        final date = DateTime.tryParse(raw);
                        if (date == null) return const Text('-');
                        return Text(
                          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                        );
                      }

                      if (header.value == 'mother') {
                        final mother = item['mother'];
                        return Text(
                          '$mother',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                      return Text(item[header.value]?.toString() ?? '');
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
