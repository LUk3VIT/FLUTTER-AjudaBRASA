import 'package:flutter_application_1/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/cabecalho.dart';
import 'package:flutter_application_1/widget/custom_sidebar_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: Routes.getRoutes(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isCollapsed = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Row(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _isCollapsed ? 70 : 200, 
              color: const Color(0xFF0C2D5B),
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      _isCollapsed ? Icons.menu : Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: _isCollapsed ? 45 : 80,
                    height: _isCollapsed ? 45 : 80,
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/12345678?v=4'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (!_isCollapsed) ...[
                    const Text(
                      'Lucas Dias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'info@braseq.com.br',
                      style: TextStyle(
                      color: Colors.white70,
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 30),

                  CustomSidebarButton(
                    titulo: 'Modificação Excel',
                    icon: Icons.settings, 
                    isCollapsed: _isCollapsed,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.modExcel);
                    },
                  ),

                  const SizedBox(height: 10),

                  CustomSidebarButton(
                    titulo: 'Equipamentos',
                    icon: Icons.table_chart, 
                    isCollapsed: _isCollapsed,
                    onTap: () {},
                  ),

                  const Spacer(),

                  CustomSidebarButton(
                    titulo: 'Logout',
                    icon: Icons.logout,
                    isCollapsed: _isCollapsed,
                    isLogout: true,
                    onTap: () {},
                  ),

                  const SizedBox(height: 15),

                ]
              )
            ),

            Expanded(
              child: Container(
                color: const Color(0xFFEAE8D2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Cabecalho(nome: 'Lucas Dias'),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        color: const Color(0xFFEAE8D2),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Bem Vindo!', style: TextStyle(fontSize: 20)),
                              SizedBox(height: 20),
                              Text(
                                'AJUDA BRASA - LUCAS DIAS',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ]
                          )
                        )
                      )
                    )
                  ],
                ),
              )
            ) 
          ]
        )
      );
  }
}