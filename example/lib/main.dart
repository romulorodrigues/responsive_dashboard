import 'package:flutter/material.dart';
import 'package:responsive_dashboard/responsive_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Dashboard Example',
      theme: ThemeData(
        fontFamily: 'Lato',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: DashboardLayout(
        topBar: TopBar(
          onSearch: (value) {
            debugPrint('Search: $value');
          },
          child: Row(
            children: [
              ButtonIcon(
                icon: Icons.star,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              ButtonIcon(
                icon: Icons.person,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              CustomDropdown(
                badgeCount: 5,
                button: const Icon(Icons.notifications),
                dropdownContent: Column(
                  children: List.generate(
                    5,
                    (index) => ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text('Notification ${index + 1}'),
                      subtitle: const Text('You have a new message'),
                      onTap: () {
                        print('Click ${index + 1}');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          userAvatar: const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
          ),
          userName: 'Rômulo Rodrigues',
          userDropdownItems: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                print('Profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                print('Settings');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                print('Logout');
              },
            ),
          ],
        ),
        menuItems: [
          MenuItemModel(
            icon: Icons.dashboard,
            label: 'Dashboard',
            section: 'Overview',
            onTap: () => debugPrint('Dashboard'),
          ),
          MenuItemModel(
            icon: Icons.analytics,
            label: 'Reports',
            section: 'Overview',
            children: [
              MenuItemModel(
                icon: Icons.bar_chart,
                label: 'Sales',
                onTap: () => debugPrint('Reports > Sales'),
              ),
              MenuItemModel(
                icon: Icons.people,
                label: 'Users',
                onTap: () => debugPrint('Reports > Users'),
              ),
            ],
          ),
          MenuItemModel(
            icon: Icons.settings,
            label: 'Settings',
            section: 'System',
            children: [
              MenuItemModel(
                icon: Icons.security,
                label: 'Security',
                onTap: () => debugPrint('Settings > Security'),
              ),
              MenuItemModel(
                icon: Icons.language,
                label: 'Language',
                onTap: () => debugPrint('Settings > Language'),
              ),
              MenuItemModel(
                icon: Icons.tune,
                label: 'Advanced',
                children: [
                  MenuItemModel(
                    icon: Icons.admin_panel_settings,
                    label: 'Admin Tools',
                    onTap: () =>
                        debugPrint('Settings > Advanced > Admin Tools'),
                  ),
                  MenuItemModel(
                    icon: Icons.developer_mode,
                    label: 'Developer Options',
                    onTap: () =>
                        debugPrint('Settings > Advanced > Developer Options'),
                  ),
                ],
              ),
            ],
          ),
          MenuItemModel(
            icon: Icons.build,
            label: 'System Config',
            section: 'System',
            children: [
              MenuItemModel(
                icon: Icons.memory,
                label: 'Memory',
                onTap: () => debugPrint('System Config > Memory'),
              ),
              MenuItemModel(
                icon: Icons.storage,
                label: 'Storage',
                onTap: () => debugPrint('System Config > Storage'),
              ),
              MenuItemModel(
                icon: Icons.network_check,
                label: 'Network',
                onTap: () => debugPrint('System Config > Network'),
              ),
            ],
          ),
          MenuItemModel(
            icon: Icons.notifications,
            label: 'Notifications',
            section: 'Apps',
            onTap: () => debugPrint('Notifications'),
          ),
          MenuItemModel(
            icon: Icons.calendar_today,
            label: 'Calendar',
            section: 'Apps',
            onTap: () => debugPrint('Calendar'),
          ),
          MenuItemModel(
            icon: Icons.email,
            label: 'Messages',
            section: 'Apps',
            onTap: () => debugPrint('Messages'),
          ),
          MenuItemModel(
            icon: Icons.help,
            label: 'Help Center',
            section: 'Support',
            children: [
              MenuItemModel(
                icon: Icons.book,
                label: 'Documentation',
                onTap: () => debugPrint('Help Center > Documentation'),
              ),
              MenuItemModel(
                icon: Icons.support,
                label: 'Support',
                onTap: () => debugPrint('Help Center > Support'),
              ),
            ],
          ),
          MenuItemModel(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () => debugPrint('Logout'),
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: isWide
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth,
                    child: CustomCard(
                      header: const Text(
                        'Card Title',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('This is the content of the card.'),
                          SizedBox(height: 8),
                          Text('You can put any widget inside the body.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isWide
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth,
                    child: CustomCard(
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
                      body: const Text(
                        'This card has a dropdown button in the header.',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
