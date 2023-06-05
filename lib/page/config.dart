// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rmc_pricechecker/page/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  BoxDecoration wallpaperDecoration = const BoxDecoration();
  String defaultWallpaperImagePath = 'assets/image/lopp.png';
  TextEditingController configController = TextEditingController();

  Future<void> changeWallpaper() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      String imagePath = pickedImage.path;

      setState(() {
        wallpaperDecoration = BoxDecoration(
          image: DecorationImage(
            image: FileImage(imageFile),
            fit: BoxFit.cover,
          ),
        );
      });

      // Guarda la ruta de la imagen seleccionada en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('wallpaperImagePath', imagePath);
    }
  }

  Future<void> accesoconfig(String config) async {
    if (config == 'rmc123') {
      return showDialog(
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
                        width: 600,
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _btnupdate(),
                              const SizedBox(
                                height: 20,
                              ),
                              _btndelete(),
                              const SizedBox(
                                height: 20,
                              ),
                              _cerrarsesion(),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: changeWallpaper,
                                child: const Text('Cambiar fondo'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/config',
                                (route) => false,
                              );
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
                      'SU CLAVE ES INCORRECTA',
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

  Future<void> loadWallpaper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? wallpaperImagePath = prefs.getString('wallpaperImagePath');
    if (wallpaperImagePath == null) {
      setState(() {
        wallpaperDecoration = BoxDecoration(
          image: DecorationImage(
            image: AssetImage(defaultWallpaperImagePath),
            fit: BoxFit.cover,
          ),
        );
      });
    } else {
      setState(() {
        wallpaperDecoration = BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(wallpaperImagePath)),
            fit: BoxFit.cover,
          ),
        );
      });
    }
  }

  SQLdb sqLdb = SQLdb();

  Future<void> insertarDatosDesdeExcel(String filePath) async {
    List<List<dynamic>> excelData = await leerExcel(filePath);
    await insertarDatos(excelData);
  }

  Future<List<List<dynamic>>> leerExcel(String filePath) async {
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    var sheet = excel.tables[excel.tables.keys.first];
    var rows = sheet!.rows;

    return rows;
  }

  Future<void> insertarDatos(List<List<dynamic>> data) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'productos.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY AUTOINCREMENT, codigo TEXT, codbarra TEXT, descripcion TEXT,medida TEXT, categoria TEXT,precio REAL, stock REAL)');
      },
      version: 1,
    );

    for (var fila in data) {
      var id = fila[0]?.value;
      var codigo = fila[1]?.value;
      var codbarra = fila[2]?.value;
      var descripcion = fila[3]?.value;
      var medida = fila[4]?.value;
      var categoria = fila[5]?.value;
      var precio = fila[6]?.value;
      var stock = fila[7]?.value;

      await database.insert(
        'products',
        {
          'id': id != null ? id.toString() : '',
          'codigo': codigo != null ? codigo.toString() : '',
          'codbarra': codbarra != null ? codbarra.toString() : '',
          'descripcion': descripcion != null ? descripcion.toString() : '',
          'medida': medida != null ? medida.toString() : '',
          'categoria': categoria != null ? categoria.toString() : '',
          'precio': precio != null ? precio.toString() : '',
          'stock': stock != null ? stock.toString() : '',
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return Center(
        child: Container(
          decoration: wallpaperDecoration,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 40.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey,
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15)),
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    config(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget config() {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  width: 600,
                  height: 380,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
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
                              colors: [Colors.transparent, Colors.transparent],
                            ),
                          ),
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                _inputField(
                                    'INGRESE CLAVE', false, configController),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        String config = configController.text;
                                        if (config != '') {
                                          accesoconfig(config);
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
                                                  content:
                                                      const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: [
                                                        Text(
                                                          'RELLENE EL CAMPO',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('ACEPTAR'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        backgroundColor: const Color.fromARGB(
                                            255, 228, 226, 226),
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                      ),
                                      child: const SizedBox(
                                        width: 200,
                                        child: Text(
                                          'ACEPTAR',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        backgroundColor: const Color.fromARGB(
                                            255, 228, 226, 226),
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                      ),
                                      child: const SizedBox(
                                        width: 200,
                                        child: Text(
                                          'CANCELAR',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
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
        width: 400,
        child: Text(
          'INGRESE A LA CONFIGURACION',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
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

  Widget _btnupdate() {
    return ElevatedButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xlsx', 'xls'],
        );

        if (result != null && result.files.isNotEmpty) {
          String filePath = result.files.first.path!;
          await insertarDatosDesdeExcel(filePath);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('MENSAJE'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          'Los datos fueron importados correctamente',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/principal',
                          (route) => false,
                        );
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text('ADVERTENCIA'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          'El documento no se cargo en la base de datos',
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
        width: 300.0,
        child: Text(
          'Cargar datos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _btndelete() {
    return ElevatedButton(
      onPressed: () async {
        int rep = await sqLdb.deleteData("DELETE FROM products");
        if (rep > 0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('MENSAJE'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'los datos se eliminaron exitosamente',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/principal',
                      (route) => false,
                    );
                    setState(() {});
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            ),
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
        width: 300,
        child: Text(
          'Eliminar los datos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _cerrarsesion() {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: 300,
        child: Text(
          'Cerrar Sesion',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
