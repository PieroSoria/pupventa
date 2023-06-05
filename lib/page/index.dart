// ignore_for_file: must_be_immutable, sized_box_for_whitespace, unused_local_variable, depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pupventa/page/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  BoxDecoration wallpaperDecoration = const BoxDecoration();
  String defaultWallpaperImagePath = 'assets/image/fondo.jpg';
  final TextEditingController configController = TextEditingController();

  Future<void> changeWallpaper() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
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
    }else{
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

  final TextEditingController dataController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  SQLdb sqLdb = SQLdb();

  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      symbol: '\$', // Símbolo de la moneda
      decimalDigits: 2, // Cantidad de decimales
    );
    return formatter.format(value);
  }

  Future<void> guardarImagen(int index, List<Map> searchResults) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, 'images');
      await Directory(imagePath).create(recursive: true);

      final imageName = '$imagePath/image_$index.jpg';
      await File(imageName).writeAsBytes(imageBytes);

      final database = await sqLdb.db;

      final mutableRow = Map<String, dynamic>.from(searchResults[index]);
      mutableRow['image'] = imageName;

      await database!.update(
        'products',
        mutableRow,
        where: 'id = ?',
        whereArgs: [searchResults[index]['id']],
      );

      if (File(imageName).existsSync()) {
        debugPrint('La imagen ha sido cargada exitosamente');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/principal');
      } else {
        debugPrint('Error al guardar la imagen');
      }
    }
  }

  Future<List<Map>> searchItems(String query) async {
    final List<Map> results = await sqLdb.getData(
      "SELECT * FROM products WHERE codbarra LIKE '%$query%'",
    );
    return results;
  }

  Future<void> showSearchResults(List<Map> searchResults) async {
    if (searchResults.isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultados de la busqueda'),
            content: const Text('No se encontraron porductos'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(10)),
                    
                child: const Text("ACEPTAR"),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'RESULTADOS DE LA BUSQUEDA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '========================================================================',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              SingleChildScrollView(
                                child: Container(
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount: searchResults.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListBody(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        searchResults[index]
                                                            ['descripcion'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        searchResults[index]
                                                            ['medida'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            formatCurrency(double
                                                                .parse(searchResults[
                                                                            index]
                                                                        [
                                                                        'precio']
                                                                    .toString())),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      onPressed: () =>
                                                          guardarImagen(index,
                                                              searchResults),
                                                      icon: const Icon(Icons
                                                          .camera_alt_outlined),
                                                      label: const Text(
                                                          'CAPTURA IMAGEN'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: searchResults.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final imagePath =
                                          searchResults[index]['image'] ?? '';
                                      final file = File(imagePath);

                                      Widget imageWidget;
                                      if (file.existsSync()) {
                                        imageWidget = Center(
                                          child: Image.file(file),
                                        );
                                      } else {
                                        imageWidget =
                                            const Text('Imagen no encontrada');
                                      }
                                      return ListBody(
                                        children: [
                                          Container(
                                            child: imageWidget,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                              'BUSCAR OTRO PRODUCTO',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> accesoconfig2() async {
    return showDialog(
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
                                _inputField2(
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
  }
  
  Future<void> accesoconfig(String config) async {
    if (config == 'rmc123') {
      changeWallpaper();
    }else{
      showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('ADVERTENCIA'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'SU CLAVE ES ICORRECTA',
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
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    loadWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder:(BuildContext context, Orientation orientation){
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              accesoconfig2();
            },
            backgroundColor: Colors.blue.shade900,
            splashColor: Colors.blue.shade900,
            child: const Icon(Icons.image),
          ),
          body: Container(
            decoration: wallpaperDecoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 40.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _inputField('LEA SU CÓDIGO DE BARRAS', dataController),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _inputField(String hinText, TextEditingController controller) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );
    return Center(
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        focusNode: _focusNode,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        onSubmitted: (String value) async {
          List<Map> searchResults = await searchItems(value);
          await showSearchResults(searchResults);
          dataController.text = '';
        },
        textInputAction: TextInputAction.none,
        decoration: InputDecoration(
          hintText: hinText,
          filled: true,
          fillColor: Colors.white.withOpacity(0),
          hintStyle:  TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold
          ),
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
  Widget _inputField2(
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
}
