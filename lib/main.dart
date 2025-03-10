import 'package:flutter/material.dart';
import 'screens/calculator/standard_calculator.dart';
import 'screens/calculator/scientific_calculator.dart';
import 'screens/calculator/programmer_calculator.dart';
import 'screens/converter/length_converter.dart';
import 'screens/converter/weight_converter.dart';
import 'screens/converter/temperature_converter.dart';
import 'screens/converter/volume_converter.dart';
import 'screens/converter/energy_converter.dart';
import 'screens/converter/area_converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '多功能计算器',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentPage = const StandardCalculator();
  String _currentTitle = "标准计算器";

  void _navigateToPage(Widget page, String title) {
    setState(() {
      _currentPage = page;
      _currentTitle = title;
      Navigator.pop(context); // 关闭抽屉
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2D2D2D),
              ),
              child: Text(
                '多功能计算器',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ExpansionTile(
              title: const Text('计算器'),
              leading: const Icon(Icons.calculate),
              initiallyExpanded: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.calculate_outlined),
                  title: const Text('标准'),
                  onTap: () => _navigateToPage(
                    const StandardCalculator(),
                    '标准计算器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.science),
                  title: const Text('科学'),
                  onTap: () => _navigateToPage(
                    const ScientificCalculator(),
                    '科学计算器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('程序员'),
                  onTap: () => _navigateToPage(
                    const ProgrammerCalculator(),
                    '程序员计算器',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('转换器'),
              leading: const Icon(Icons.swap_horiz),
              initiallyExpanded: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.water_drop),
                  title: const Text('容量'),
                  onTap: () => _navigateToPage(
                    const VolumeConverter(),
                    '容量转换器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.straighten),
                  title: const Text('长度'),
                  onTap: () => _navigateToPage(
                    const LengthConverter(),
                    '长度转换器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.scale),
                  title: const Text('重量'),
                  onTap: () => _navigateToPage(
                    const WeightConverter(),
                    '重量转换器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.thermostat),
                  title: const Text('温度'),
                  onTap: () => _navigateToPage(
                    const TemperatureConverter(),
                    '温度转换器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.bolt),
                  title: const Text('能量'),
                  onTap: () => _navigateToPage(
                    const EnergyConverter(),
                    '能量转换器',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.square_foot),
                  title: const Text('面积'),
                  onTap: () => _navigateToPage(
                    const AreaConverter(),
                    '面积转换器',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _currentPage,
    );
  }
}
