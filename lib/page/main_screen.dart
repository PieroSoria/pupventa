import 'package:flutter/material.dart';
import 'package:rmc_pricechecker/page/config.dart';
import 'package:rmc_pricechecker/page/index.dart';
import 'package:rmc_pricechecker/page/mostrar.dart';



class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final myList = [
      const Index(),
      const Mostrar(),
      const Config(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: myList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue.shade900,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrito',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuracion',
            ),
          ]),
    );
  }
}
