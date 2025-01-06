import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.attach_money, 'label': 'Kas', 'route': '/dashboard'},
    {'icon': Icons.group, 'label': 'Pelanggan', 'route': '/dashboard'},
    {'icon': Icons.shopping_cart, 'label': 'Produk', 'route': '/produk'},
    {'icon': Icons.inventory, 'label': 'Inventory', 'route': '/dashboard'},
    {'icon': Icons.point_of_sale, 'label': 'Penjualan', 'route': '/dashboard'},
    {'icon': Icons.account_balance_wallet, 'label': 'Piutang', 'route': '/dashboard'},
    {'icon': Icons.trending_down, 'label': 'Hutang', 'route': '/dashboard'},
    {'icon': Icons.money_off, 'label': 'Pengeluaran', 'route': '/dashboard'},
    {'icon': Icons.bar_chart, 'label': 'Laporan', 'route': '/dashboard'},
    {'icon': Icons.campaign, 'label': 'Promo', 'route': '/dashboard'},
    {'icon': Icons.support, 'label': 'Pendukung', 'route': '/dashboard'},
    {'icon': Icons.store, 'label': 'Toko Saya', 'route': '/dashboard'},
    {'icon': Icons.data_usage, 'label': 'Data', 'route': '/dashboard'},
    {'icon': Icons.settings, 'label': 'Pengaturan', 'route': '/dashboard'},
    {'icon': Icons.star, 'label': 'Tanpa Iklan', 'route': '/dashboard'},
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Toko Ku',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
                context.go('/login');
              },
            ),
          ],
        ),
        body: authState.when(
          data: (user) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue[50],
                        child: const Icon(Icons.store,
                            color: Colors.blue, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat Datang!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'owner ${user!.name}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Grid Menu
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return GestureDetector(
                        onTap: 
                          () => context.go(item['route'])
                        ,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue[50],
                              child: Icon(
                                item['icon'],
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['label'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ));
  }
}
