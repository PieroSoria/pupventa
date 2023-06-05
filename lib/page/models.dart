
// ignore_for_file: unused_import

import 'dart:ffi';

class User {
  final int id;
  final String codigo;
  final String codbarra;
  final String descripcion;
  final String medida;
  final String categoria;
  final String precio;
  final String stock;

  User({ required this.id,required this.codigo, required this.codbarra, required this.descripcion,required this.medida,required this.categoria,required this.precio,required this.stock});

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'codigo' : codigo,
      'codbarra' : codbarra,
      'descripcion' : descripcion,
      'medida' : medida,
      'categoria' : categoria,
      'precio' : precio,
      'stock' : stock,
    };
  }

 
}



