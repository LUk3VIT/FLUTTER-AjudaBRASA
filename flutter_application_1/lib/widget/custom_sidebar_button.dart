import 'package:flutter/material.dart';

class CustomSidebarButton extends StatelessWidget {
  final String titulo;
  final IconData icon;
  final bool isCollapsed;
  final bool isActive;
  final bool isLogout;
  final VoidCallback onTap;

  const CustomSidebarButton({
    super.key,
    required this.titulo,
    required this.icon,
    required this.isCollapsed,
    this.isActive = false,
    this.isLogout = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFFFEAE8D2); 

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50,

        margin: EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: isCollapsed ? 8 : 15,
          right: isActive ? 0 : (isCollapsed ? 8 : 15),
        ),

        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: isActive
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              : BorderRadius.circular(30),
        ),

        child: ClipRRect(
          borderRadius: isActive
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              : BorderRadius.circular(30),
          child: Stack(
            alignment: isLogout && !isCollapsed ? Alignment.center : Alignment.centerLeft,
            children: [
              
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isCollapsed ? 15 : (isLogout ? 50 : 20),
                top: isCollapsed ? 13 : -40, 
                child: Icon(
                  icon,
                  color: isLogout 
                      ? Colors.redAccent 
                      : (isActive ? Colors.black87 : Colors.white),
                  size: 24,
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: isCollapsed ? -40 : 15,
                left: isLogout ? 0 : 20,
                right: isLogout ? 0 : null,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCollapsed ? 0.0 : 1.0,
                  child: Text(
                    titulo,
                    textAlign: isLogout ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: isLogout 
                          ? Colors.redAccent 
                          : (isActive ? Colors.black87 : Colors.white),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}