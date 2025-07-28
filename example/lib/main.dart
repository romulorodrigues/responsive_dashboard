import 'package:flutter/material.dart';
import 'package:responsive_dashboard/responsive_dashboard.dart';
import 'dashboard_page.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _currentPage = const DashboardPage();

  void _setPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

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
            backgroundImage: NetworkImage(
                'https://api.dicebear.com/7.x/adventurer/png?seed=John',
                scale: 1.0),
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
        sideBar: SideBar(
          menuItems: [
            MenuItemModel(
              icon: Icons.dashboard,
              label: 'Dashboard',
              section: 'Overview',
              onTap: () => _setPage(const DashboardPage()),
            ),
            MenuItemModel(
              icon: Icons.pages,
              label: 'Second Page',
              section: 'Overview',
              onTap: () => _setPage(const SecondPage()),
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
        ),
        child: _currentPage,
        footer: Container(
          height: 50,
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Custom Footer © 2025'),
        ),
      ),
    );
  }
}
