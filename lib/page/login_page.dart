// ignore_for_file: use_build_context_synchronously, avoid_print, unused_catch_clause, unused_import, unused_local_variable, unrelated_type_equality_checks

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:mysql1/mysql1.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> login(String correo, String pass) async {
    bool isValid = await verificarUsuario(correo, pass);
    bool isvolt = await verificarUsuario1(correo, pass);
    bool tiempo = await duracion(correo);
    bool tiempo2 = await duracion2(correo);
    if (isValid == true && tiempo == true) {
      Navigator.pushNamed(context, '/principal');
    } else if (isvolt == true && tiempo2 == true) {
      Navigator.pushNamed(context, '/principal');
    } else if (isValid == true && tiempo == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('ADVERTENCIA'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'SE HA ACABADO SU TIEMPO DE PRUEBA',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'OBTEN UN LICENCIA',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'ACEPTAR',
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
                    Navigator.pushNamed(context, '/licencia');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'OBTENER LICENCIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    } else if (isvolt == true && tiempo2 == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('ADVERTENCIA'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'SU LICENCIA SE HA ACABADO',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'RENUEVE SU LICENCIA',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Pulse el boton OBTENER LICENCIA para hablar con el proveedor',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'ACEPTAR',
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
                    Navigator.pushNamed(context, '/licencia');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'OBTENER LICENCIA ANUAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    } else if (isValid == false || isvolt == false) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('ADVERTENCIA'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'VERIFIQUE SU USUARIO Y CONTRASEÑA',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'ACEPTAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  Future<bool> duracion(String correo) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice',
    ));

    final results = await conn
        .query('SELECT fechafinal FROM licencia_free WHERE user = ?', [correo]);

    if (results.isNotEmpty) {
      final fechaGuardada = results.first[0] as DateTime;
      final fechaActual = DateTime.now();
      await conn.close();
      return fechaActual.isBefore(fechaGuardada);
    } else {
      await conn.close();
      return false;
    }
  }

  Future<bool> duracion2(String correo) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice',
    ));

    final results = await conn.query(
        'SELECT fechafinal FROM licencia_anual WHERE user = ?', [correo]);

    if (results.isNotEmpty) {
      final fechaGuardada = results.first[0] as DateTime;
      final fechaActual = DateTime.now();
      await conn.close();
      return fechaActual.isBefore(fechaGuardada);
    } else {
      await conn.close();
      return false;
    }
  }

  Future<bool> verificarUsuario(String correo, String pass) async {
    bool isConnected = await checkInternetConnection();

    if (!isConnected) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ADVERTENCIA'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    'NO HAY CONEXION A INTERNET',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'ACEPTAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return false;
    }

    var config = ConnectionSettings(
        host: '201.148.107.172',
        port: 3306,
        user: 'rmcpe_data',
        password: '0x#w6{aOWVP@',
        db: 'rmcpe_db_checkprice');
    try {
      var con = await MySqlConnection.connect(config);
      var result = await con.query(
          'SELECT * FROM licencia_free WHERE user = ? and clave = ?',
          [correo, pass]);
      return result.isNotEmpty;
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ADVERTENCIA'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    'NO SE PUEDE ESTABLECER CONEXION CON LA BASE DE DATOS',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: const Color.fromARGB(255, 228, 226, 226),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'ACEPTAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verificarUsuario1(String correo, String pass) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
        port: 3306,
        user: 'rmcpe_data',
        password: '0x#w6{aOWVP@',
        db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    var result = await con.query(
        "SELECT * FROM licencia_anual WHERE user = ? and clave = ?",
        [correo, pass]);
    return result.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color.fromRGBO(255, 117, 25, 1),
          ],
        ),
      ),
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: _page(),
        );
      }),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            children: [
                              FittedBox(
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/image/lopp.png'),
                                    radius: 180,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 400,
                                child: Column(
                                  children: [
                                    const Text(
                                      'INGRESE SU USUARIO',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 38,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _inputField("Usuario", userController),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _inputField("Password", passController,
                                        isPassword: true),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _loginbtn(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _extratext(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _btnuser(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const FittedBox(
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/image/lopp.png'),
                                    radius: 120,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'INGRESE SU USUARIO',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              _inputField("Usuario", userController),
                              const SizedBox(
                                height: 30,
                              ),
                              _inputField("Contraseña", passController,
                                  isPassword: true),
                              const SizedBox(
                                height: 30,
                              ),
                              _loginbtn(),
                              const SizedBox(
                                height: 30,
                              ),
                              _extratext(),
                              const SizedBox(
                                height: 30,
                              ),
                              _btnuser(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hinText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextField(
      style: const TextStyle(
        color: Colors.white,
      ),
      textCapitalization: TextCapitalization.characters,
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginbtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("User : ${userController.text}");
        debugPrint("Pass : ${passController.text}");

        String correo = userController.text.trim();
        String pass = passController.text.trim();

        if (correo != '' && pass != '' ||
            correo.isNotEmpty && pass.isNotEmpty) {
          login(correo, pass);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('ADVENTENCIA'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'VERIFIQUE SU USUARIO',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  BackButton(),
                ],
              );
            },
          );
        }
        userController.text = '';
        passController.text = '';
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
          'INICIAR SESION',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _btnuser() {
    return ElevatedButton(
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
          'CREA NUEVO USUARIO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _extratext() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/registrar');
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
          'REGISTRE SU EMPRESA',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
