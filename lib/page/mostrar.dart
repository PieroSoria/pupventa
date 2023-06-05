// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pupventa/page/database.dart';

class Mostrar extends StatefulWidget {
  const Mostrar({super.key});

  @override
  State<Mostrar> createState() => _MostrarState();
}

class _MostrarState extends State<Mostrar> {
  

  SQLdb sqLdb = SQLdb();

  Future<List<Map>> getAllproducts() async {
    List<Map> products = await sqLdb.getData("SELECT * FROM 'products'");
    return products;
  }

  Future<void> refreshdata() async {
    setState(() {
      getAllproducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue.shade900,
            onPressed: (){
              refreshdata();
            },
            child: const Icon(Icons.refresh, color: Colors.white, size: 25,),
          ),
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text('Listado de productos en su inventario',),
            backgroundColor: const Color.fromARGB(234, 0, 30, 202),
          ),
          body: RefreshIndicator(
            onRefresh: refreshdata,
            child: Column(
            children: [
              Expanded(
                flex: 11,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Container(
                    child: FutureBuilder(
                      future: getAllproducts(),
                      builder: (ctx, snp){
                        if(snp.hasData){
                          List<Map> listproducts = snp.data!;
                          return ListView.builder(
                            itemCount: listproducts.length,
                            itemBuilder: (ctx,index){
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.blue.shade900,
                                    size: 20,
                                  ),
                                  title: Text("${listproducts[index]['descripcion']}", style: TextStyle(fontSize: 25,color: Colors.blue.shade900),),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Esta seguro que desea eliminar este producto ${listproducts[index]['descripcion']}",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue.shade900),),
                                              actions: [
                                                ElevatedButton(onPressed: () async{
                                                  int rep = await sqLdb.deleteData("DELETE FROM products WHERE id = ${listproducts[index]['id']}");
                                                  if (rep > 0){
                                                    Navigator.of(context).pop();
                                                    setState(() {
                  
                                                    });
                                                  }
                                                }, 
                                                child: const Text('Aceptar'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: ()async{
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancelar'),
                                                ),
                                              ],
                                            )
                                          );
                                        },
                                        child: Icon(Icons.delete,color: Colors.blue.shade900,size: 25,)
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        }else{
                          return const Center(child: CircularProgressIndicator(),);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
          ),
        );
      }
    );
  }
}