import 'package:flutter/material.dart';

class Licencia extends StatefulWidget {
  const Licencia({super.key});

  @override
  State<Licencia> createState() => _LicenciaState();
}

class _LicenciaState extends State<Licencia> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade200,
                    Colors.grey.shade200,
                  ]
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'CONTACTARSE CON RMC SOLUTIONS BUSINESS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'RICARDO@RMC.PE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      '+51981229283 - +51965367976',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const SizedBox(
                        width: 350,
                        child: Text(
                          'REGISTRE SU USUARIO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const SizedBox(
                        width: 350,
                        child: Text(
                          'VOLVER A LA PAGINA PRINCIPAL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
