import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/cabecalho.dart';
import 'package:flutter_application_1/widget/custom_sidebar_button.dart';
import 'package:flutter_application_1/widget/button.dart';
import 'package:flutter_application_1/popup/limpar_html_popup.dart';
import 'package:flutter_application_1/popup/unir_html_popup.dart';

class ModExcel extends StatefulWidget {
  const ModExcel({super.key});

  @override
  State<ModExcel> createState() => _ModExcelState();
}

class _ModExcelState extends State<ModExcel> {
  bool _isCollapsed = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    isActive: true,
                    onTap: () {},
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
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Tela de Modificação Excel',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),

                              const Text(
                                'Escolha uma das opções abaixo',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Button(
                                    titulo: 'Limpar HTML',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const LimparHTML(),
                                      );
                                    },
                                  ),

                                  const SizedBox(width: 20),

                                  Button(
                                    titulo: 'Unir Planilhas',
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => const UnirHTML(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        )
                      )
                    )
                  ],
                ),
              )
            ) 
          ],
        ),
    );  
  }
}