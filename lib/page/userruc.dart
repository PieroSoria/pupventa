// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

class Userruc extends StatefulWidget {
  const Userruc({super.key});

  @override
  State<Userruc> createState() => _UserrucState();
}

class _UserrucState extends State<Userruc> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController anualController = TextEditingController();

  Future<bool> existeUsuario(String user) async {
    var config = ConnectionSettings(
      host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice',
    );

    var con = await MySqlConnection.connect(config);
    var result = await con.query(
      'SELECT COUNT(*) AS count FROM licencia_free WHERE user = ?',
      [user],
    );

    var count = result.first.fields['count'] as int;
    return count > 0;
  }

  Future<bool> existeUsuario2(String user) async {
    var config = ConnectionSettings(
      host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice',
    );

    var con = await MySqlConnection.connect(config);
    var result = await con.query(
      'SELECT COUNT(*) AS count FROM licencia_anual WHERE user = ?',
      [user],
    );

    var count = result.first.fields['count'] as int;
    return count > 0;
  }

  Future<bool> verificarlicencia(String anual) async {
    int activo = 1;
    var contro = ConnectionSettings(
        host: '201.148.107.172',
        port: 3306,
        user: 'rmcpe_data',
        password: '0x#w6{aOWVP@',
        db: 'rmcpe_db_checkprice');
    var ser = await MySqlConnection.connect(contro);
    var result = await ser.query(
        "SELECT * FROM clavesdelicencia WHERE claves = ? and activo = ?",
        [anual, activo]);
    return result.isNotEmpty;
  }

  Future<bool> veriruc(String ruc) async {
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

  Future<dynamic> veridad(fus) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
        port: 3306,
        user: 'rmcpe_data',
        password: '0x#w6{aOWVP@',
        db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    final god =
        await con.query("SELECT dias FROM lic_dias WHERE id = ?", [fus]);
    for (var row in god) {
      var dias = int.parse(row['dias'].toString());
      return dias;
    }
  }

  Future<bool> vericantusuario(String ruc) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
        port: 3306,
        user: 'rmcpe_data',
        password: '0x#w6{aOWVP@',
        db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    var result = await con
        .query("SELECT nlicencia_anual FROM clientes WHERE ruc = ?", [ruc]);
    var cont = result.first.fields['nlicencia_anual'] as int;
    var result2 = await con.query(
        "SELECT COUNT(*) AS cont FROM licencia_anual WHERE ruc = ?", [ruc]);
    var cont2 = result2.first.fields['cont'] as int;
    if (cont > cont2) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> registraranual(
      String user, String pass, String ruc, String anual, String fus) async {
    bool isValid = await verificarlicencia(anual);
    bool existe2 = await existeUsuario2(user);
    bool veri = await veriruc(ruc);
    var data = await veridad(fus);
    bool cantusuario = await vericantusuario(ruc);
    int cantuser = 1;
    String activi = '2';
    if (isValid == true &&
        existe2 == false &&
        veri == true &&
        cantusuario == true) {
      var config = ConnectionSettings(
          host: '201.148.107.172',
          port: 3306,
          user: 'rmcpe_data',
          password: '0x#w6{aOWVP@',
          db: 'rmcpe_db_checkprice');
      var des = DateTime.now().toUtc();
      var hoy = DateFormat('yyyy-MM-dd').format(des);
      var fre = des.add(Duration(days: data));
      var fin = DateFormat('yyyy-MM-dd').format(fre);

      var con = await MySqlConnection.connect(config);
      var comple = await con.query(
          "INSERT INTO licencia_anual (user, clave, ruc, fechareg, fechafinal) VALUES (?,?,?,?,?)",
          [user, pass, ruc, hoy, fin]);
      // ignore: unused_local_variable
      var sup = await con.query(
          "UPDATE clavesdelicencia SET ruc = ?, usuario = ?, activo = ? WHERE claves = ?",
          [ruc, user, activi, anual]);
      // ignore: unused_local_variable
      var read = await con.query(
          "UPDATE clientes SET nlicencia_anual = ? WHERE ruc = ?",
          [cantuser, ruc]);
      // ignore: unused_local_variable
      var delete = await con.query("DELETE FROM licencia_free WHERE user = ?",[user]);

      if (comple.affectedRows! > 0) {
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
                        'Los datos se ingresaron correctamente.',
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
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('ACEPTAR'),
                  ),
                ],
              );
            });
      }
    } else if (isValid == false) {
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
                      'LA LICENCIA YA ESTA EN USO O ESTA INACTIVA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    } else if (existe2 == true) {
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
                      'EL USUARIO YA EXISTE EN EL SISTEMA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    } else if (veri == false) {
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
                      'RUC NO EXISTE EN EL SISTEMA, VERIFIQUE SU RUC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    } else if (cantusuario == false) {
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
                      'EL NUMERO DE LICENCIAS ESTA LLENO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    }
  }

  Future<dynamic> veridias(String mus) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    var result =
        await con.query("SELECT dias FROM lic_dias WHERE id = ?", [mus]);
    for (var row in result) {
      var dias = int.parse(row['dias'].toString());
      return dias;
    }
  }

  Future<bool> cantusuUsuario(String ruc) async {
    var config = ConnectionSettings(
        host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice');
    var con = await MySqlConnection.connect(config);
    var result = await con
        .query("SELECT nlicencia_free FROM clientes WHERE ruc = ?", [ruc]);
    var cont = result.first.fields['nlicencia_free'] as int;
    var result2 = await con.query(
        "SELECT COUNT(*) as cont FROM licencia_free WHERE ruc = ?", [ruc]);
    var cont2 = result2.first.fields['cont'] as int;

    if (cont > cont2) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> registrar(
      String user, String pass, String ruc, String mus) async {
    bool existe = await existeUsuario(user);
    bool veri = await veriruc(ruc);
    bool cantusu = await cantusuUsuario(ruc);
    var data = await veridias(mus);
    if (existe == false && veri == true && cantusu == true) {
      int datas = 1;
      var config = ConnectionSettings(
          host: '201.148.107.172',
      port: 3306,
      user: 'rmcpe_data',
      password: '0x#w6{aOWVP@',
      db: 'rmcpe_db_checkprice');
      var des = DateTime.now().toUtc();
      var hoy = DateFormat('yyyy-MM-dd').format(des);
      var fre = des.add(Duration(days: data));
      var fin = DateFormat('yyyy-MM-dd').format(fre);
      var con = await MySqlConnection.connect(config);
      var comple = await con.query(
          "INSERT INTO licencia_free (user, clave, ruc, fechareg, fechafinal) VALUES (?,?,?,?,?)",
          [user, pass, ruc, hoy, fin]);
      // ignore: unused_local_variable
      var cantlicencia = await con.query(
          "UPDATE clientes SET nlicencia_free = ? WHERE ruc = ?", [datas, ruc]);
      if (comple.affectedRows! > 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'BIENVENIDO AL SISTEMA',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'SU USUARIO FUE REGISTRADO CORRECTAMENTE',
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
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('ACEPTAR'),
                  ),
                ],
              );
            });
      }
    } else if (existe == true) {
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
                      'EL USUARIO YA EXISTE EN EL SISTEMA.',
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    } else if (veri == false) {
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
                      'SU EMPRESA NO EXISTE EN EL SISTEMA, REVISE EL RUC INGRESADO',
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    } else if (cantusu == false) {
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
                      'EL NUMERO DE USUARIO DE LA EMPRESA YA ESTA LLENO',
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
                  child: const Text('ACEPTAR'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CREA UNA CUENTA DE USUARIO',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.grey.shade200,
        body: _page(),
      );
    });
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade200,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'INGRESE UN USUARIO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _inputField('Ingrese su usuario', false, userController),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'INGRESE UNA CONTRASEÑA',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.blue.shade900),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _inputField('Ingrese una contraseña', false, passController,
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'INGRESE EL RUC DE SU EMPRESA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _inputField(
                      'Ingrese el Ruc de su empresa', true, rucController),
                  const SizedBox(
                    height: 20,
                  ),
                  _btnregistrar(),
                  const SizedBox(
                    height: 20,
                  ),
                  _btnregistraranual(),
                  const SizedBox(
                    height: 20,
                  ),
                  _backebtn(),
                ],
              ),
            ),
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
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.blue.shade900,
        ),
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
    } else {
      return TextField(
        textCapitalization: TextCapitalization.characters,
        style: TextStyle(
          color: Colors.blue.shade900,
        ),
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

  Widget _btnregistrar() {
    return ElevatedButton(
      onPressed: () {
        String user = userController.text;
        String pass = passController.text;
        String ruc = rucController.text;
        String mus = '1';
        if (user != '' && pass != '' && ruc != '') {
          registrar(user, pass, ruc, mus);
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
                          'PORFAVOR, RELLENE SUS DATOS CORRECTAMENTE',
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
                      child: const Text('ACEPTAR'),
                    ),
                  ],
                );
              });
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: 500,
        child: Text(
          'REGISTRAR EL USUARIO CON LA LICENCIA FREE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _btnregistraranual() {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Container(
                  width: 600,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blueGrey,
                        Colors.blueGrey,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'MENSAJE',
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          height: 180.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                _inputField('INGRESE LA LICENCIA ADQUIRIDA',
                                    false, anualController),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                String user = userController.text;
                                String pass = passController.text;
                                String ruc = rucController.text;
                                String anual = anualController.text;
                                String fus = '2';
                                if (user != '' &&
                                    pass != '' &&
                                    ruc != '' &&
                                    anual != '') {
                                  registraranual(user, pass, ruc, anual, fus);
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
                                                  'PORFAVOR RELLENE SUS DATOS CORRECTAMENTE',
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
                                              child: const Text('ACEPTAR'),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor:
                                    const Color.fromARGB(255, 228, 226, 226),
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: const Text(
                                'ACEPTAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor:
                                    const Color.fromARGB(255, 228, 226, 226),
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              child: const Text(
                                'CANCELAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: 500,
        child: Text(
          'REGISTRAR EL USUARIO CON LA LICENCIA ANUAL(PLAZO DE 1 AÑO)',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _backebtn() {
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
