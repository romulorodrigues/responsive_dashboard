import 'package:flutter/material.dart';
import 'package:responsive_dashboard/responsive_dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;
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
              SizedBox(
                width: isWide
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth,
                child: CustomCard(
                  margin: EdgeInsets.all(0),
                  header: const Text(
                    'Card Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et accumsan nibh. Ut at elementum mi. Praesent eu nisi ut dui fringilla tincidunt. In in facilisis erat. Fusce tempor dolor nec mauris pulvinar venenatis. Donec sagittis lorem ac sem iaculis pellentesque. Ut tincidunt posuere purus. Sed mauris massa, dapibus ac aliquam sit amet, posuere sit amet elit.'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          'Aenean ac ullamcorper leo. Nam fermentum venenatis blandit. Duis venenatis, neque eget tincidunt suscipit, elit metus efficitur dolor, et tincidunt arcu massa eget felis. Donec mollis porttitor massa vel blandit. Sed ut dapibus ante. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse potenti.'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: isWide
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth,
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
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
                        },
                        children: const [
                          TableRow(
                            decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Age',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Alice Johnson'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('alice@example.com'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('28'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Bob Smith'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('bob@example.com'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('35'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Alan Smith'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('alan@example.com'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('30'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
