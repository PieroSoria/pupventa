// ignore_for_file: unused_local_variable, prefer_const_declarations, depend_on_referenced_packages, unrelated_type_equality_checks, unused_import, use_build_context_synchronously

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:navigator/navigator.dart';

import 'package:mysql1/mysql1.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController razonsocialController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController selecteddepaController = TextEditingController();
  final TextEditingController fechaingresoController = TextEditingController();
  final TextEditingController distritoController = TextEditingController();
  final TextEditingController selectedpaisController = TextEditingController();

  List<String> dataList = ['PERU'];
  List<String> departamentList = [
    'AMAZONAS',
    'ANCASH',
    'APURIMAC',
    'AREQUIPA',
    'AYACUCHO',
    'CAJAMARCA',
    'CUZCO',
    'HUANCAVELICA',
    'HUANUCO',
    'ICA',
    'HUANCAYO',
    'LA LIBERTAD',
    'LAMBAYEQUE',
    'LIMA',
    'LORETO',
    'MADRE DE DIOS',
    'MOQUEGUA',
    'PASCO',
    'PIURA',
    'PUNO',
    'SAN MARTIN',
    'TACNA',
    'TUMBES',
    'UCAYALI'
  ];


  String? selectpais ;
  String? selectdepa;
  String? selectpro ;
  String? selectdis ;

  List<String> getdepar() {
    if (selectpais == 'PERU') {
      return [
        'AMAZONAS',
        'ANCASH',
        'APURIMAC',
        'AREQUIPA',
        'AYACUCHO',
        'CAJAMARCA',
        'CUSCO',
        'HUANCAVELICA',
        'HUANUCO',
        'ICA',
        'HUANCAYO',
        'LA LIBERTAD',
        'LAMBAYEQUE',
        'LIMA',
        'LORETO',
        'MADRE DE DIOS',
        'MOQUEGUA',
        'PASCO',
        'PIURA',
        'PUNO',
        'SAN MARTIN',
        'TACNA',
        'TUMBES',
        'UCAYALI'
      ];
    } else if (selectpais == 'BOLIVIA') {
      return [];
    }
    return [];
  }

  Future<bool> existecliente(String ruc) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    var result = await con.query("SELECT * FROM clientes WHERE ruc = ?", [ruc]);
    return result.isNotEmpty;
  }

  Future<void> guardardatos(
    String nombre,
    String user,
    String telefono,
    String ruc,
    String razonsocial,
    String pais,
    String direccion,
    String departamento,
  ) async {
    bool existeempresa = await existecliente(ruc);
    int licencia = 1;
    if (existeempresa == false) {
      var config = ConnectionSettings(
          host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice');
      var hoy = DateTime.now().toUtc();
      var los = DateFormat('yyyy-MM-dd').format(hoy);
      var con = await MySqlConnection.connect(config);
      var result = await con.query(
          'insert into clientes (nombres,usuario,telefono,ruc,razonsocial,pais,direccion,departamento,fecharegistro,nlicencia_free,nlicencia_anual) values (?,?,?,?,?,?,?,?,?,?,?)',
          [
            nombre,
            user,
            telefono,
            ruc,
            razonsocial,
            pais,
            direccion,
            departamento,
            los,
            licencia,
            licencia
          ]);
      if (result.affectedRows! > 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'MENSAJE',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'Los datos se ingresaron correctamente',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/user');
                      },
                      child: const Text('Aceptar')),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'MENSAJE',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'OCURRIO UN PROBLEMA, REVISE SUS DATOS',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aceptar')),
                ],
              );
            });
      }
    } else if (existeempresa == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'MENSAJE',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'ESTA EMPRESA YA EXISTE',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aceptar')),
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
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
            Colors.blue,
          ],
        ),
      ),
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('REGISTRE SU EMPRESA'),
            backgroundColor: const Color.fromARGB(255, 32, 84, 253),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Colors.grey.shade200,
          body: _form(),
        );
      }),
    );
  }

  Widget _form() {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade200,
                      Colors.grey.shade200,
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          children: [
                            Text(
                              'INFORMACION DE LA EMPRESA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.blue.shade900
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'SELECCIONAR PAIS',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            DropdownButton<String>(
                              value: selectpais,
                              onChanged: (String? selectedValue) async {
                                setState(() {
                                  selectedpaisController.text =
                                      selectedValue ?? '';
                                  selectpais = selectedValue!;
                                });
                              },
                              items: dataList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue.shade900,
                              ),
                              dropdownColor: Colors.white,
                              hint: SizedBox(
                                width: 260,
                                child: Text(
                                  'PAIS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'SELECCIONAR DEPARTAMENTO',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue.shade900),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            DropdownButton<String>(
                              value: selectdepa,
                              onChanged: (String? selectedValue) {
                                setState(() {
                                  selecteddepaController.text =
                                      selectedValue ?? '';
                                  selectdepa = selectedValue!;
                                });
                              },
                              items: getdepar().map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue.shade900,
                              ),
                              dropdownColor: Colors.white,
                              hint: SizedBox(
                                width: 260,
                                child: Text(
                                  'DEPARTAMENTO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _inputField('INGRESE RUC', true, rucController),
                            const SizedBox(
                              height: 20,
                            ),
                            _inputField('RAZON SOCIAL', false, razonsocialController),
                            const SizedBox(
                              height: 18,
                            ),
                            _inputField('DIRECCION Y DISTRITO', false, direccionController),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade200,
                        Colors.grey.shade200,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          'INFORMACION DEL CONTACTO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        _inputField(
                            'NOMBRE DEL CONTACTO', false, nombreController),
                        const SizedBox(
                          height: 20,
                        ),
                        _inputField('TELEFONO', true, telefonoController),
                        const SizedBox(
                          height: 18,
                        ),
                        _inputField('CORREO', false, userController),
                        const SizedBox(
                          height: 20,
                        ),
                        _registrarbtn(),
                        const SizedBox(
                          height: 18,
                        ),
                        _backbtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      String hinText, bool only, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.blue.shade900),
    );
    if (only) {
      return TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.blue.shade900,
        ),
        textCapitalization: TextCapitalization.characters,
        controller: controller,
        decoration: InputDecoration(
          hintText: hinText,
          hintStyle:  TextStyle(
            color: Colors.blue.shade900,
          ),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      );
    } else {
      return TextField(
        style: TextStyle(
          color: Colors.blue.shade900,
        ),
        textCapitalization: TextCapitalization.characters,
        controller: controller,
        decoration: InputDecoration(
          hintText: hinText,
          hintStyle: TextStyle(
            color: Colors.blue.shade900,
          ),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      );
    }
  }

  Widget _registrarbtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("nombre : ${nombreController.text}");
        debugPrint("user : ${userController.text}");
        debugPrint("telefono : ${telefonoController.text}");
        debugPrint("ruc : ${rucController.text}");
        debugPrint("razonSocial : ${razonsocialController.text}");
        debugPrint("pais : ${selectedpaisController.text}");
        debugPrint("direccion : ${direccionController.text}");
        debugPrint("distrito : ${distritoController.text}");
        debugPrint("provincia : ${provinciaController.text}");
        debugPrint("departamento : ${selecteddepaController.text}");

        String nombre = nombreController.text;
        String user = userController.text;
        String telefono = telefonoController.text;
        String ruc = rucController.text;
        String razonsocial = razonsocialController.text;
        String direccion = direccionController.text;
        String provincia = provinciaController.text;
        String departamento = selecteddepaController.text;
        String distrito = distritoController.text;
        String pais = selectedpaisController.text;

        if (nombre != '' &&
            user != '' &&
            telefono != '' &&
            ruc != '' &&
            razonsocial != '' &&
            pais != '' &&
            direccion != '' &&
            departamento != '') {
          guardardatos(nombre, user, telefono, ruc, razonsocial, pais,
              direccion, departamento);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('ADVERTENCIA'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'REVISE QUE TODOS LOS CAMPOS ESTE CORRECTAMENTE LLENADOS',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: const Text('ACEPTAR'),
                  ),
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: 270,
        child: Text(
          'Guardar Datos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _backbtn() {
    return Builder(builder: (context) {
      return ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: const Color.fromARGB(255, 228, 226, 226),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(16.0)),
        icon: const Icon(Icons.arrow_back),
        label: const Text(
          'Volver al menu principal',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    });
  }
}
