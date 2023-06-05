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

  List<String> getpro() {
    if (selectdepa == 'AMAZONAS' ) {
      return [
        'CHACHAPOYAS',
        'BAGUA',
        'BONGARA',
        'CONDORCANQUI',
        'LUYA',
        'RODRIGUEZ DE MENDOZA',
        'UTCUBAMBA'
      ];
    } else if (selectdepa == 'ANCASH') {
      return [
        'HUARAZ',
        'PROVINCIA DE AIJA',
        'ANTONIO RAYMONDI',
        'ASUNCIÓN',
        'BOLOGNESI',
        'CARHUAZ',
        'CARLOS F. FITZCARRALD.',
        'HUARI',
        'HUARMEY',
        'HUAYLAS',
        'MARISCAL LUZURIAGA',
        'OCROS',
        'PALLASCA',
        'POMAPAMPA',
        'SANTA',
        'SIHUAS',
        'YUNGAY'
      ];
    } else if (selectdepa == 'APURIMAC') {
      return [
        'ABANCAY',
        'ANDAHUAYLAS',
        'ANTABAMBA',
        'AYMARAES',
        'COTABAMBAS',
        'CHINCHEROS',
        'GRAU'
      ];
    } else if (selectdepa == 'AREQUIPA') {
      return [
        'AREQUIPA',
        'CAMANÁ',
        'CARAVELLI',
        'CASTILLA',
        'CAYLLOMA',
        'CONDESUYOS',
        'LA UNIÓN'
      ];
    } else if (selectdepa == 'AYACUCHO') {
      return [
        'HUAMANGA',
        'CANGALLO',
        'HUANCA SANCOS',
        'HUANTA',
        'LA MAR',
        'LUCANAS',
        'PARINACOCHAS',
        'SUCRE',
        'VICTOR FAJARDO',
        'VILCAS HUAMAN'
      ];
    } else if (selectdepa == 'CAJAMARCA') {
      return [
        'SAN IGNACION',
        'JAEN',
        'CUTERVO',
        'CHOTA',
        'SANTA CRUZ',
        'HUALGAYOC',
        'CELENDIN',
        'SNA PABLO',
        'SAN MIGUEL',
        'CONTUMAZA',
        'CAJAMARCA',
        'SAN MARCOS'
      ];
    } else if (selectdepa == 'CUSCO') {
      return [
        'CUSCO',
        'ACOMAYO',
        'ANTA',
        'CALCA',
        'CANCHIS',
        'CHUMBIVILCA',
        'ESPINAR',
        'ESPINAR',
        'LA CONVENCION',
        'PARURO',
        'PAUCARTAMBO',
        'QUISPICANCHI',
        'URUBAMBA'
      ];
    } else if (selectdepa == 'HUANCAVELICA') {
      return [
        'HUANCAVELICA',
        'ACOBAMBA',
        'ANGARAES',
        'CASTROVIRREYNA',
        'CHURCAMPA',
        'HUAYTARA',
        'TAYACAJA'
      ];
    } else if (selectdepa == 'HUANUCO') {
      return [
        'HUANUCO',
        'AMBO',
        'DOS DE MAYO',
        'HUAMALIES',
        'LEONCIO PRADO',
        'MARAÑON',
        'PACHITEA',
        'PUERTO INCA',
        'LAURICOCHA',
        'YAROWILCA'
      ];
    } else if (selectdepa == 'ICA') {
      return ['ICA', 'CHINCHA', 'NAZCA', 'PALPA', 'PISCO'];
    } else if (selectdepa == 'HUANCAYO') {
      return [
        'HUANCAYO',
        'CHANCHAMAYO',
        'CONCEPCION',
        'JUNIN',
        'SATIPO',
        'JAUJA',
        'YAULI',
        'CHUPACA'
      ];
    } else if (selectdepa == 'LA LIBERTAD') {
      return [
        'TRUJILLO',
        'ASCOPE',
        'BOLIVAR',
        'CHEPEN',
        'JULCAN',
        'OTUZCO',
        'GRAN CHIMU',
        'VIRU',
        'PACASMAYO',
        'PATAZ',
        'SANCHEZ CARRION',
        'SANTIAGO DE CHUCO'
      ];
    } else if (selectdepa == 'LAMBAYEQUE') {
      return ['CHICLAYO', 'FERREÑAFE', 'LAMBAYEQUE'];
    } else if (selectdepa == 'LIMA') {
      return [
        'LIMA',
        'BARRANCA',
        'CAJATAMBO',
        'CAÑETE',
        'CANTA',
        'HUARAL',
        'HUAROCHIRI',
        'HUAURA',
        'OYON',
        'TAUYOS',
        'CALLAO'
      ];
    } else if (selectdepa == 'LORETO') {
      return [
        'MAYNAS',
        'ALTO AMAZONAS',
        'DATEM DEL MARAÑON',
        'LORETO',
        'MARISCAL RAMON CASTILLA',
        'REQUENA',
        'UCAYALI'
      ];
    } else if (selectdepa == 'MADRE DE DIOS') {
      return ['TAMBOPATA', 'MANU', 'TAHUAMANU'];
    } else if (selectdepa == 'MOQUEGUA') {
      return ['MARISCAL NIETO', 'GENERAL SANCHEZ CERRO', 'ILO'];
    } else if (selectdepa == 'PASCO') {
      return ['PASCO', 'DANIEL ALCIDES CARRION', 'OXAPAMPA'];
    } else if (selectdepa == 'PIURA') {
      return [
        'PIURA',
        'AYABACA',
        'HUANCABAMBA',
        'PAITA',
        'MORROPON',
        'SECHURA',
        'SULLANA',
        'TALARA'
      ];
    } else if (selectdepa == 'PUNO') {
      return [
        'PUNO',
        'AZANGARO',
        'CARABAYA',
        'CHUCUITO',
        'EL COLLAO',
        'HUANCANE',
        'LAMPA',
        'MELGAR',
        'MOHO',
        'SAN ANTONIO DE PUTINA',
        'SAN ROMAN',
        'SANDIA',
        'YUNGUYO'
      ];
    } else if (selectdepa == 'SAN MARTIN') {
      return [
        'BELLAVISTA',
        'HUALLAGA',
        'LAMAS',
        'MARISCAL CACERES',
        'MOYOBAMBA',
        'PICOTA',
        'RIOJA',
        'SAN MARTIN',
        'TOCACHE',
        'EL DORADO'
      ];
    } else if (selectdepa == 'TACNA') {
      return ['TACNA', 'CANDARAVE', 'JORGE BASADRES', 'TARATA'];
    } else if (selectdepa == 'TUMBES') {
      return ['ZARUMILLA', 'TUMBES', 'CONTRALMIRANTE VILLAR'];
    } else if (selectdepa == 'UCAYALI') {
      return ['CORONEL PORTILLO', 'ATALAYA', 'PADRE ABAD', 'PURUS'];
    }
    return [];
  }

  List<String> getdis() {
    if (selectpro == 'CHACHAPOYAS') {
      return [
        "CHACHAPOYAS",
        "ASUNCION",
        "BALSAS",
        "CHETO",
        "CHILIQUIN",
        "CHUQUIBAMBA",
        "GRANADA",
        "HUANCAS",
        "LA JALCA",
        "LEIMEBAMBA",
        "LEVANTO",
        "MAGDALENA",
        "MARISCAL CASTILLA (Duraznopampa)",
        "MOLINOPAMPA",
        "MONTEVIDEO",
        "OLLEROS",
        "QUINJALCA",
        "SAN FRANCISCO DE DAGUAS (Daguas)",
        "SAN ISIDRO DE MAINO (Maíno)",
        "SOLOCO",
        "SONCHE (San Juan de Sonche)"
      ];
    } else if (selectpro == 'BAGUA') {
      return [
        "LA PECA (Bagua)",
        "ARAMANGO",
        "COPALLIN",
        "EL PARCO",
        "IMAZA (Chiriaco)"
      ];
    } else if (selectpro == 'BONGARA') {
      return [
        "JUMBILLA",
        "CHISQUILLA",
        "CHURUJA",
        "COROSHA",
        "CUISPES",
        "FLORIDA",
        "JAZAN (Pedro Ruíz Gallo)",
        "RECTA",
        "SAN CARLOS",
        "SHIPASBAMBA",
        "VALERA",
        "YAMBRASBAMBA"
      ];
    } else if (selectpro == 'CONDORCANQUI') {
      return [
        "NIEVA (Santa María de Nieva)",
        "EL CENEPA (Huampami)",
        "RIO SANTIAGO (Puerto Galilea)"
      ];
    } else if (selectpro == 'LUYA') {
      return [
        "LAMUD",
        "CAMPORREDONDO",
        "COCABAMBA",
        "COLCAMAR",
        "CONILA (Cohechán)",
        "INGUILPATA",
        "LONGUITA",
        "LONYA CHICO",
        "LUYA",
        "LUYA VIEJO",
        "MARIA",
        "OCALLI",
        "OCUMAL (Collonce)",
        "PISUQUIA (Yomblón)",
        "PROVIDENCIA",
        "SAN CRISTOBAL (Olto)",
        "SAN FRANCISCO DEL YESO",
        "SAN JERONIMO (Paclas)",
        "SAN JUAN DE LOPECANCHA",
        "SANTA CATALINA",
        "SANTO TOMAS",
        "TINGO",
        "TRITA"
      ];
    } else if (selectpro == 'RODRIGUEZ DE MENDOZA') {
      return [
        "SAN NICOLAS (Mendoza)",
        "CHIRIMOTO",
        "COCHAMAL",
        "HUAMBO",
        "LIMABAMBA",
        "LONGAR",
        "MARISCAL BENAVIDES",
        "MILPUC",
        "OMIA",
        "SANTA ROSA (Sta. Rosa de Huayabamba)",
        "TOTORA",
        "VISTA ALEGRE"
      ];
    } else if (selectpro == 'UCTUBAMBA') {
      return [
        "BAGUA GRANDE",
        "CAJARURO",
        "CUMBA",
        "EL MILAGRO",
        "JAMALCA",
        "LONYA GRANDE",
        "YAMON"
      ];
    } else if (selectpro == 'HUARAZ') {
      return [
        "COCHABAMBA",
        "COLCABAMBA",
        "HUANCHAY",
        "HUARAZ",
        "INDEPENDENCIA",
        "JANGAS",
        "LA LIBERTAD",
        "OLLEROS",
        "PAMPAS",
        "PARIACOTO",
        "PIRA",
        "TARICA"
      ];
    } else if (selectpro == 'PROVINCIA DE AIJA') {
      return ["AIJA", "CORIS", "HUACLLAN", "LA MERCED", "SUCCHA"];
    } else if (selectpro == 'ANTONIO RAYMONDI') {
      return [
        "ACZO",
        "CHACCHO",
        "CHINGAS",
        "LLAMELLIN",
        "MIRGAS",
        "SAN JUAN DE RONTOY"
      ];
    } else if (selectpro == 'ASUNCIÓN') {
      return ["ACOCHACA", "CHACAS"];
    } else if (selectpro == 'BOLOGNESI') {
      return [
        "ABELARDO PARDO LEZAMETA",
        "ANTONIO RAYMONDI",
        "AQUIA",
        "CAJACAY",
        "CANIS",
        "CHIQUIAN",
        "COLQUIOC",
        "HUALLANCA",
        "HUASTA",
        "HUAYLLACAYAN",
        "LA PRIMAVERA",
        "MANGAS",
        "PACLLON",
        "SAN MIGUEL DE CORPANGQUI",
        "TICLLOS"
      ];
    } else if (selectpro == 'CARHUAZ') {
      return [
        "ACOPAMPA",
        "AMASHCA",
        "ANTA",
        "ATAQUERO",
        "CARHUAZ",
        "MARCARA",
        "PARIAHUANCA",
        "SAN MIGUEL DE ACO",
        "SHILLA",
        "TINCO",
        "YUNGAR"
      ];
    } else if (selectpro == 'CARLOS F. FITZCARRALD.') {
      return [
        "SAN LUIS",
        "SAN NICOLAS",
        "YAUYA",
        "PROVINCIA DE CASMA",
        "BUENA VISTA ALTA",
        "CASMA",
        "COMANDANTE NOEL",
        "YAUTAN",
        "PROVINCIA DE CORONGO",
        "ACO",
        "BAMBAS",
        "CORONGO",
        "CUSCA",
        "LA PAMPA",
        "YANAC",
        "YUPAN"
      ];
    } else if (selectpro == 'HUARI') {
      return [
        "ANRA",
        "CAJAY",
        "CHAVIN DE HUANTAR",
        "HUACACHI",
        "HUACCHIS",
        "HUACHIS",
        "HUANTAR",
        "HUARI",
        "MASIN",
        "PAUCAS",
        "PONTO",
        "RAHUAPAMPA",
        "RAPAYAN",
        "SAN MARCOS",
        "SAN PEDRO DE CHANA",
        "UCO"
      ];
    } else if (selectpro == 'HUARMEY') {
      return ["COCHAPETI", "CPEBRAS", "HUARMEY", "HUAYAN", "MALVAS"];
    } else if (selectpro == 'MARISCAL LUZURIAGA') {
      return [
        "CARAZ",
        "HUALLANCA",
        "HUATA",
        "HUAYLAS",
        "MATO",
        "PAMPAROMAS",
        "PUEBLO LIBRE",
        "SANTA CRUZ",
        "SANTO TORIBIO",
        "YURACMARCA",
        "CASCA",
        "ELEAZAR GUMAN BARRON",
        "FIDEL OLIVAS ESCUDERO",
        "LLAMA",
        "LLUMPA",
        "LUCMA",
        "MUSGA",
        "PISCOBAMBA"
      ];
    } else if (selectpro == 'OCROS') {
      return [
        "ACAS",
        "CAJAMARQUILLA",
        "CARHUAPAMPA",
        "COCHAS",
        "CONGAS",
        "LLIPA",
        "OCROS",
        "SAN CRISTOBAL DE RAJAN",
        "SAN PEDRO",
        "SANTIAGO DE CHILCAS"
      ];
    } else if (selectpro == 'PALLASCA') {
      return [
        "BOLGNESI",
        "CABANA",
        "CONCHUCOS",
        "HUACASCHUQUE",
        "HUANDOVAL",
        "LACABAMBA",
        "LLAPO",
        "PALLASCA",
        "PAMPAS",
        "SANTA ROSA",
        "TAUCA"
      ];
    } else if (selectpro == 'POMAPAMPA') {
      return [
        "HUAYLLAN",
        "PAROBAMBA",
        "POMABAMBA",
        "QUINUABAMBA",
        "PROVINCIA DE RECUAY",
        "CATAC",
        "COTAPARACO",
        "HUAYLLAPAMPA",
        "LLACLLIN",
        "MARCA",
        "PAMPAS CHICO",
        "PARARIN",
        "RECUAY",
        "TAPACOCHA",
        "TICAPAMPA"
      ];
    } else if (selectpro == 'SANTA') {
      return [
        "CACERES DEL PERU",
        "CHIMBOTE",
        "COISHCO",
        "MACATE",
        "MORO",
        "NEPEÑA",
        "NUEVO CHIMBOTE",
        "SAMANCO",
        "SANTA"
      ];
    } else if (selectpro == 'SIHUAS') {
      return [
        "ACOBAMBA",
        "ALFONSO UGARTE",
        "CASHAPAMPA",
        "CHINGALPO",
        "HUAYLLABAMBA",
        "QUICHES",
        "RAGASH",
        "SAN JUAN",
        "SICSIBAMBA",
        "SIHUAS"
      ];
    } else if (selectpro == 'YUNGAY') {
      return [
        "CASCAPARA",
        "MANCOS",
        "MATACOTO",
        "QUILLO",
        "RANRAHIRCA",
        "SHUPLUY",
        "YANAMA",
        "YUNGAY"
      ];
    } else if (selectpro == 'ABANCAY') {
      return [
        "ABANCAY",
        "CHACOCHE",
        "CIRCA",
        "CURAHUASI",
        "HUANIPACA",
        "LAMBRAMA",
        "PICHIRHUA",
        "SAN PEDRO DE CACHORA",
        "TAMBURCO"
      ];
    } else if (selectpro == 'ANDAHUAYLAS') {
      return [
        "ANDAHUAYLAS",
        "ANDARAPA",
        "CHIARA",
        "HUANCARAMA",
        "HUANCARAY",
        "HUAYANA",
        "KAQUIABAMBA",
        "KISHUARA",
        "PACOBAMBA",
        "PACUCHA",
        "PAMPACHIRI",
        "POMACOCHA",
        "SAN ANTONIO DE CACHI",
        "SAN JERONIMO",
        "SANMIGUEL DE CHACCRAMPA",
        "SANTA MARIA DE CHICMO",
        "TALAVERA",
        "TUMAY HUARACA",
        "TURPO"
      ];
    } else if (selectpro == 'ANTABAMBA') {
      return [
        "ANTABAMBA",
        "EL ORO",
        "HUAQUIRCA",
        "JUAN ESPINOZA MEDRANO",
        "OROPESA",
        "PACHACONAS",
        "SABAINO"
      ];
    } else if (selectpro == 'AYMARAES') {
      return [
        "CAPAYA",
        "CARAYBAMBA",
        "CHALHUANCA",
        "CHAPIMARCA",
        "COLCABAMBA",
        "COTARUSE",
        "HAUAYLLO",
        "JUSTO APU SAHUARAURA",
        "LUCRE",
        "POCOHUANCA",
        "SAN JUAN DE CHACÑA",
        "SAÑAYCA",
        "SORAYA",
        "TAPAIRIHUA",
        "TINTAY",
        "TORAYA",
        "YANACA"
      ];
    } else if (selectpro == 'COTABAMBAS') {
      return [
        "CHALLHUAHUACHO",
        "COTABAMBAS",
        "COYLLURQUI",
        "HAQUIRA",
        "MARA",
        "TAMBOBAMBA"
      ];
    } else if (selectpro == 'CHINCHEROS') {
      return [
        "ANCO HUALLO",
        "CHINCHEROS",
        "COCHARCAS",
        "HUACCANA",
        "OCOBAMBA",
        "ONGOY",
        "RANRACANCHA",
        "URANMARCA"
      ];
    } else if (selectpro == 'GRAU') {
      return [
        "CHUQUIBAMBILLA",
        "CURASCO",
        "CURPAHUASI",
        "GAMARRA",
        "HUAYLLATI",
        "MAMARA",
        "MICAELA BASTIDAS",
        "PATAYPAMPA",
        "PROGRESO",
        "SAN ANTONIO",
        "SANTA ROSA",
        "TURPAY",
        "VILCABAMBA",
        "VIRUNDO"
      ];
    } else if (selectpro == 'AREQUIPA') {
      return [
        "ALTO SELVA ALEGRE",
        "AREQUIPA",
        "CAYMA",
        "CERRO COLORADO",
        "CHARACATO",
        "CHIGUATA",
        "JACOBO HUNTER",
        "JOSE LUIS BUSTAMANTE Y RIVERO",
        "LA JOVA",
        "MARIANO MELGAR",
        "MIRAFLORES",
        "MOLLEBAYA",
        "PAUCARPATA",
        "POCSI",
        "POLOBAYA",
        "QUEQUEÑA",
        "SABANDIA",
        "SACHACA",
        "SAN JUAN DE SIGUAS",
        "SAN JUAN DE TARUCANI",
        "SANTA ISABEL DE SIGUAS",
        "SANTA RITA DE SIGUAS",
        "SOCABAYA",
        "TIABAYA",
        "UCHUMAYO",
        "VITOR",
        "YANAHUARA",
        "YARABAMBA",
        "YURA"
      ];
    } else if (selectpro == 'CAMANÁ') {
      return [
        "CAMANA",
        "JOS EMARIA QUIMPER",
        "MARIANO NICOLAS VALCARCEL",
        "MARISCAL CACERES",
        "NIOLAS E PIEROLA",
        "OCOÑA",
        "QUILCA",
        "SAMUEL PASTOR"
      ];
    } else if (selectpro == 'CARAVELLI') {
      return [
        "ACARI",
        "ATICO",
        "ATIQUIPA",
        "BELLA UNION",
        "CAHUACHO",
        "CARAVELI",
        "CHALA",
        "CHAPARRA",
        "HUANUHUANU",
        "JAQUI",
        "LOMAS",
        "QUICACHA",
        "YAUCA"
      ];
    } else if (selectpro == 'CASTILLA') {
      return [
        "ANDAGUA",
        "APLAO",
        "AYO",
        "CHACHAS",
        "CHILCAYMARCA",
        "CHOCO",
        "HUANCARQUI",
        "MACHAGUAY",
        "ORCOPAMPA",
        "PAMPACOLCA",
        "TIPAN",
        "UÑON",
        "URACA",
        "VIRACO"
      ];
    } else if (selectpro == 'CAYLLOMA') {
      return [
        "ACHOMA",
        "CABANACONDE",
        "CALLALLI",
        "CAYLLOMA",
        "CHIVAY",
        "COPORAQUE",
        "HUAMBO",
        "HUANCA",
        "ICHUPAMPA",
        "LARI",
        "LLUTA",
        "MACA",
        "MADRIGAL",
        "MAJES",
        "SAN ANTONIO DE CHUCA",
        "SIBAYO",
        "TAPAY",
        "TISCO",
        "TUTI",
        "YANQUE"
      ];
    } else if (selectpro == 'CONDESUYOS') {
      return [
        "ANDARAY",
        "CAYARANI",
        "CHICHAS",
        "CHUQUIBAMBA",
        "IRAY",
        "RIO GRANDE",
        "SALAMANCA",
        "YANAQUIHUA",
        "PROVINCIA DE ISLAY",
        "COCACHACRA",
        "DEAN VALDIVIA",
        "ISLAY",
        "MEJIA",
        "MOLLENDO",
        "PUNTA DE BOMBON"
      ];
    } else if (selectpro == 'UNIÓN') {
      return [
        "ALCA",
        "CHARCANA",
        "COTAHUASI",
        "HUAYNACOTAS",
        "PAMPAMARCA",
        "PUYCA",
        "QUECHUALLA",
        "SAYLA",
        "TAURIA",
        "TOMEPAMPA",
        "TORO"
      ];
    } else if (selectpro == 'HUAMANGA') {
      return [
        "AYACUCHO",
        "ACOCRO",
        "ACOS VINCHOS",
        "CARMEN ALTO",
        "CHIARA",
        "OCROS",
        "PACAYCASA",
        "QUINUA",
        "SAN JOSE DE TICLLAS (Ticllas)",
        "SAN JUAN BAUTISTA",
        "SANTIAGO DE PISCHA (San Pedro de Cachi)",
        "SOCOS",
        "TAMBILLO",
        "VINCHOS",
        "JESUS NAZARENO"
      ];
    } else if (selectpro == 'CANGALLO') {
      return [
        "CANGALLO",
        "CHUSCHI",
        "LOS MOROCHUCOS (Pampa-Cangallo)",
        "MARIA PARADO DE BELLIDO (Pomabamba)",
        "PARAS",
        "TOTOS"
      ];
    } else if (selectpro == 'HUANCA SANCOS') {
      return [
        "SANCOS(Huanca Sancos)",
        "CARAPO",
        "SACSAMARCA",
        "SANTIAGO DE LUCANAMARCA"
      ];
    } else if (selectpro == 'HUANTA') {
      return [
        "HUANTA",
        "HAYAHUANCO",
        "HUAMANGUILLA",
        "IGUAIN (Macachacra)",
        "LURICOCHA",
        "SANTILLANA (San Jose de Secce)",
        "SIVIA"
      ];
    } else if (selectpro == 'LA MAR') {
      return [
        "SAN MIGUEL",
        "ANCO (Chiquintirca)",
        "AYNA (San Francisco)",
        "CHILCAS (Chilcas)",
        "CHUNGUI",
        "LUIS CARRANZA",
        "TAMBO",
        "SANTA ROSA"
      ];
    } else if (selectpro == 'LUCANAS') {
      return [
        "PUQUIO",
        "AUCARA",
        "CABANA",
        "CARMEN SALCEDO (Andamarca)",
        "CHAVIÑA",
        "CHIPAO",
        "HUAC-HUAS",
        "LARAMATE",
        "LEONCIO PRADO (Tambo Quemado)",
        "LLAUTA",
        "LUCANAS",
        "OCAÑA",
        "OTOCA",
        "SAISA",
        "SAN CRISTOBAL",
        "SAN JUAN",
        "SAN PEDRO",
        "SAN PEDRO DE PALCO",
        "SANCOS",
        "SANTA ANA DE HUAYCAHUACHO",
        "SANTA LUCIA"
      ];
    } else if (selectpro == 'PARINACOCHAS') {
      return [
        "CORACORA",
        "CHUMPI",
        "CORONEL CASTAÑEDA (Aniso)",
        "PACAPAUSA",
        "PULLO",
        "PUYUSCA (Incuyo)",
        "SAN FRANCISCO DE RAVACAYCO",
        "UPAHUACHO"
      ];
    } else if (selectpro == 'PAUCAR DEL SARA') {
      return [
        "PAUSA",
        "COLTA",
        "CORCULLA",
        "LAMPA",
        "MARCABAMBA",
        "OYOLO",
        "PARARCA",
        "SAN JAVIER DEL ALPABAMBA",
        "SAN JOSE DE USHUA",
        "SARA SARA (Quilcata)"
      ];
    } else if (selectpro == 'SUCRE') {
      return [
        "QUEROBAMBA",
        "BELEN",
        "CHALCOS",
        "CHILCAYOC",
        "HUACAÑA",
        "MORCOLLA",
        "PAICO",
        "SAN PEDRO DE LARCAY",
        "SAN SALVADOR DE QUIJE",
        "SANTIAGO DE PAUCARAY",
        "SORAS"
      ];
    } else if (selectpro == 'VICTOR FAJARDO') {
      return [
        "HUANCAPI",
        "ALCAMENCA",
        "APONGO",
        "ASQUIPATA",
        "CANARIA",
        "CAYARA",
        "COLCA",
        "HUAMANQUIQUIA",
        "HUANCARAYLLA",
        "HUAYA (San Pedro de Huaya)",
        "SARHUA",
        "VILCANCHOS"
      ];
    } else if (selectpro == 'VILCAS HUAMAN') {
      return [
        "VILCAS HUAMAN",
        "ACCOMARCA",
        "CARHUANCA",
        "CONCEPCION",
        "HUAMBALPA",
        "INDEPENDENCIA (Paccha Huallhua)",
        "SAURAMA",
        "VISCHONGO"
      ];
    } else if (selectpro == 'SAN IGNACIO') {
      return [
        "SAN IGNACIO",
        "CHIRINOS",
        "HUARANGO",
        "LA COIPA",
        "NAMBALLE",
        "SAN JOSE DE LOURDES",
        "TABACONAS"
      ];
    } else if (selectpro == 'JAEN') {
      return [
        "JAEN",
        "BELLAVISTA",
        "CHONTALI",
        "COLASAY",
        "HUABAL",
        "LAS PIRIAS",
        "POMAHUACA",
        "PUCARA",
        "SALLIQUE",
        "SAN FELIPE",
        "SAN JOSE DEL ALTO",
        "SANTA ROSA"
      ];
    } else if (selectpro == 'CUTERVO') {
      return [
        "CUTERVO",
        "CALLAYUC",
        "CHOROS",
        "CUJILLO",
        "LA RAMADA",
        "PIMPINGOS",
        "QUEROCOTILLO",
        "SAN ANDRES DE CUTERVO",
        "SAN JUAN DE CUTERVO",
        "SAN LUIS DE LUCMA",
        "SANTA CRUZ",
        "SANTO DOMINGO DE LA CAPILLA",
        "SANTO TOMAS",
        "SOCOTA",
        "TORIBIO CASANOVA (La Sacilia)"
      ];
    } else if (selectpro == 'CHOTA') {
      return [
        "CHOTA",
        "ANGUIA",
        "CHADIN",
        "CHIGUIRIP",
        "CHIMBAN",
        "COCHABAMBA",
        "CONCHAN",
        "HUAMBOS",
        "LAJAS",
        "LLAMA",
        "MIRACOSTA",
        "PACCHA",
        "PION",
        "QUEROCOTO",
        "SAN JUAN DE LICUPIS (Licupis)",
        "TACABAMBA",
        "TOCMOCHE",
        "CHOROPAMPA",
        "CHALAMARCA"
      ];
    } else if (selectpro == 'SANTA CRUZ') {
      return [
        "SANTA CRUZ (Santa Cruz de Succhabamba)",
        "ANDABAMBA",
        "CATACHE",
        "CHANCAYBAÑOS",
        "LA ESPERANZA",
        "NINABAMBA",
        "PULAN",
        "SAUCEPAMPA",
        "SEXI",
        "UTICYACU",
        "YAUYUCAN"
      ];
    } else if (selectpro == 'HUALGAYOC') {
      return ["BAMBAMARCA", "CHUGUR", "HUALGAYOC"];
    } else if (selectpro == 'CELENDIN') {
      return [
        "CELENDIN",
        "CHUMUCH",
        "CORTEGANA (Chimuch)",
        "HUASMIN",
        "JORGE CHAVEZ (Lucmapampa)",
        "JOSE GALVEZ (Huacapampa)",
        "MIGUEL IGLESIAS (Chalán)",
        "OXAMARCA",
        "SOROCHUCO",
        "SUCRE",
        "UTCO",
        "LA LIBERTAD DE PALLAN"
      ];
    } else if (selectpro == 'SAN PABLO') {
      return [
        "SAN PABLO",
        "SAN BERNARDINO",
        "SAN LUIS (San Luis Grande)",
        "TUMBADEN"
      ];
    } else if (selectpro == 'SAN MIGUEL') {
      return [
        "SAN MIGUEL (San Miguel de Pallaques)",
        "BOLIVAR",
        "CALQUIS",
        "CATILLUC",
        "EL PRADO",
        "LA FLORIDA",
        "LLAPA",
        "NANCHOC",
        "NIEPOS",
        "SAN GREGORIO",
        "SAN SILVESTRE DE COCHAN",
        "TONGOD",
        "UNION AGUA BLANCA (Agua Blanca)"
      ];
    } else if (selectpro == 'CONTUMAZA') {
      return [
        "CONTUMAZA",
        "CHILETE",
        "CUPISNIQUE (El Trinidad)",
        "GUZMANGO",
        "SAN BENITO",
        "SANTA CRUZ DE TOLED",
        "TANTARICA (Catán)",
        "YONAN (Tembladera)"
      ];
    } else if (selectpro == 'CAJAMARCA') {
      return [
        "CAJAMARCA",
        "ASUNCION",
        "CHETILLA",
        "COSPAN",
        "ENCAÑADA",
        "JESUS",
        "LLACANORA",
        "LOS BAÑOS DEL INCA",
        "MAGDALENA",
        "MATARA",
        "NAMORA",
        "SAN JUAN"
      ];
    } else if (selectpro == 'CAJABAMBA') {
      return [
        "CAJABAMBA",
        "CACHACHI",
        "CONDEBAMBA (Cauday)",
        "SITACOCHA (Lluchubamba)"
      ];
    } else if (selectpro == 'SAN MARCOS') {
      return [
        "PEDRO GALVEZ (San Marcos)",
        "EDUARDO VILLANUEVA (La Grama)",
        "GREGORIO PITA (Paucamarca)",
        "ICHOCAN",
        "JOSE MANUEL QUIROZ (Shirac)",
        "JOSE SABOGAL (Venecia)",
        "CHANCAY"
      ];
    } else if (selectpro == 'CUSCO') {
      return [
        "CUSCO",
        "CCORCA",
        "POROY",
        "SAN JERONIMO",
        "SAN SEBASTIAN",
        "SANTIAGO",
        "SAYLLA",
        "WANCHAQ"
      ];
    } else if (selectpro == 'ACOMAYO') {
      return [
        "ACOMAYO",
        "ACOPIA",
        "ACOS",
        "MOSOC LLACTA",
        "POMACANCHI",
        "RONDOCAN",
        "SANGARARA"
      ];
    } else if (selectpro == 'ANTA') {
      return [
        "ANTA",
        "ANCAHUASI",
        "CACHIMAYO",
        "CHINCHAYPUJIO",
        "HUAROCONDO",
        "LIMATAMBO",
        "MOLLEPATA",
        "PUCYURA",
        "ZURITE"
      ];
    } else if (selectpro == 'CALCA') {
      return [
        "CALCA",
        "COYA",
        "LAMAY",
        "LARES",
        "PISAC",
        "SAN SALVADOR",
        "TARAY",
        "YANATILE"
      ];
    } else if (selectpro == 'CANAS') {
      return [
        "YANAOCA",
        "CHECCA",
        "KUNTURKANKI",
        "LANGUI",
        "LAYO",
        "PAMPAMARCA",
        "QUEHUE",
        "TUPAC AMARU"
      ];
    } else if (selectpro == 'CANCHIS') {
      return [
        "SICUANI",
        "CHECACUPE",
        "COMBAPATA",
        "MARANGANI",
        "PITUMARCA",
        "SAN PABLO",
        "SAN PEDRO",
        "TINTA"
      ];
    } else if (selectpro == 'CHUMBIVILCAS') {
      return [
        "SANTO TOMAS",
        "CAPACMARCA",
        "CHAMACA",
        "COLQUEMARCA",
        "LIVITACA",
        "LLUSCO",
        "QUIÑOTA",
        "VELILLE"
      ];
    } else if (selectpro == 'ESPINAR') {
      return [
        "ESPINAR",
        "CONDOROMA",
        "COPORAQUE",
        "OCORURO",
        "PALLPATA",
        "PICHIGUA",
        "SUYCKUTAMBO",
        "ALTO PICHIGUA"
      ];
    } else if (selectpro == 'LA CONVENCION') {
      return [
        "SANTA ANA",
        "ECHARATE",
        "HUAYOPATA",
        "MARANURA",
        "OCOBAMBA",
        "QUELLOUNO",
        "QUIMBIRI",
        "SANTA TERESA",
        "VILCABAMBA",
        "PICHARI"
      ];
    } else if (selectpro == 'PARURO') {
      return [
        "PARURO",
        "ACCHA",
        "CCAPI",
        "COLCHA",
        "HUANOQUITE",
        "OMACHA",
        "PACCARITAMBO",
        "PILLPINTO",
        "YAURISQUE"
      ];
    } else if (selectpro == 'PAUCARTAMBO') {
      return [
        "PAUCARTAMBO",
        "CAICAY",
        "CHALLABAMBA",
        "COLQUEPATA",
        "HUANCARANI",
        "KOSÑIPATA"
      ];
    } else if (selectpro == 'QUISPICANCHI') {
      return [
        "URCOS",
        "ANDAHUAYLILLAS",
        "CAMANTI",
        "CCARHUAYO",
        "CCATCA",
        "CUSIPATA",
        "HUARO",
        "LUCRE",
        "MARCAPATA",
        "OCONGATE",
        "OROPESA",
        "QUIQUIJANA"
      ];
    } else if (selectpro == 'URUBAMBA') {
      return [
        "URUBAMBA",
        "CHINCHERO",
        "HUAYLLABAMBA",
        "MACHUPICCHU",
        "MARAS",
        "OLLANTAYTAMBO",
        "YUCAY"
      ];
    } else if (selectpro == 'HUANCAVELICA') {
      return [
        "HUANCAVELICA",
        "ACOBAMBILLA",
        "ACORIA",
        "CONAYCA",
        "CUENCA",
        "HUACHOCOLPA",
        "HUAYLLAHUARA",
        "IZCUCHACA",
        "LARIA",
        "MANTA",
        "MARISCAL CACERES",
        "MOYA",
        "NUEVO OCCORO",
        "PALCA",
        "PILCHACA",
        "VILCA",
        "YAULI",
        "ASCENCION"
      ];
    } else if (selectpro == 'ACOBAMBA') {
      return [
        "ACOBAMBA",
        "ANDABAMBA",
        "ANTA",
        "CAJA",
        "MARCAS",
        "PAUCARA",
        "POMACOCHA",
        "ROSARIO"
      ];
    } else if (selectpro == 'ANGARAES') {
      return [
        "LIRCAY",
        "ANCHONGA",
        "CALLANMARCA",
        "CCOCHACCASA",
        "CHINCHO",
        "CONGALLA",
        "HUANCA-HUANCA",
        "HUAYLLAY GRANDE",
        "JULCAMARCA",
        "SAN ANTONIO DE ANTAPARCO (Antaparco)",
        "SANTO TOMAS DE PATA",
        "SECCLLA"
      ];
    } else if (selectpro == 'CASTROVIRREYNA') {
      return [
        "CASTROVIRREYNA",
        "ARMA",
        "AURAHUA",
        "CAPILLAS",
        "CHUPAMARCA",
        "COCAS",
        "HUACHOS",
        "HUAMATAMBO",
        "MOLLEPAMPA",
        "SAN JUAN",
        "SANTA ANA",
        "TANTARA",
        "TICRAPO"
      ];
    } else if (selectpro == 'CHURCAMPA') {
      return [
        "CHURCAMPA",
        "ANCO (La Esmeralda)",
        "CHINCHIHUASI",
        "EL CARMEN",
        "LA MERCED",
        "LOCROJA",
        "PACHAMARCA *",
        "PAUCARBAMBA",
        "SAN MIGUEL DE MAYOCC (Mayocc)",
        "SAN PEDRO DE CORIS"
      ];
    } else if (selectpro == 'HUAYTARA') {
      return [
        "HUAYTARA",
        "AYAVI",
        "CORDOVA",
        "HUAYACUNDO ARMA",
        "LARAMARCA",
        "OCOYO",
        "PILPICHACA",
        "QUERCO",
        "QUITO-ARMA",
        "SAN ANTONIO DE CUSICANCHA (Cusicancha)",
        "SAN FRANCISCO DE SANGAYAICO",
        "SAN ISIDRO (San Juan de Huirpacancha)",
        "SANTIAGO DE CHOCORVOS",
        "SANTIAGO DE QUIRAHUARA",
        "SANTO DOMINGO DE CAPILLAS",
        "TAMBO"
      ];
    } else if (selectpro == 'TAYACAJA') {
      return [
        "PAMPAS",
        "ACOSTAMBO",
        "ACRAQUIA",
        "AHUAYCHA",
        "COLCABAMBA",
        "DANIEL HERNANDEZ (Mcal. Cáceres)",
        "HUACHOCOLPA",
        "HUANDO",
        "HUARIBAMBA",
        "ÑAHUIMPUQUIO",
        "PAZOS",
        "QUISHUAR",
        "SALCABAMBA",
        "SALCAHUASI",
        "SAN MARCOS DE ROCCHAC",
        "SURCUBAMBA",
        "TINTAY PUNCU (Tintay)"
      ];
    } else if (selectpro == 'HUANUCO') {
      return [
        "HUANUCO",
        "AMARILIS(Paucarbamba)",
        "CHINCHAO(Acomayo)",
        "CHURUBAMBA",
        "MARGOS",
        "QUISQUI(Huancapallac)",
        "SAN FRANCISCO DE CAYRAN(Cayran)",
        "SAN PEDRO DE CHAULAN(Chaulan)",
        "SANTA MARIA DEL VALLE",
        "YARUMAYO",
        "PILLCO MARCA"
      ];
    } else if (selectpro == 'AMBO') {
      return [
        "AMBO",
        "CAYNA",
        "COLPAS",
        "CONCHAMARCA",
        "HUACAR",
        "SAN FRANCISCO(Mosca)",
        "SAN RAFAEL",
        "TOMAY KICHWA"
      ];
    } else if (selectpro == 'DOS DE MAYO') {
      return [
        "LA UNION",
        "CHUQUIS",
        "MARIAS",
        "PACHAS",
        "QUIVILLA",
        "RIPAN",
        "SHUNQUI",
        "SILLAPATA",
        "YANAS"
      ];
    } else if (selectpro == 'HUACAYBAMBA') {
      return ["HUACAYBAMBA", "CANCHABAMBA", "COCHABAMBA", "PINRA"];
    } else if (selectpro == 'HUAMALIES') {
      return [
        "LLATA",
        "ARANCAY",
        "CHAVIN DE PARIARCA",
        "JACAS GRANDE",
        "JIRCAN",
        "MIRAFLORES",
        "MONZON",
        "PUNCHAO",
        "PUÑOS",
        "SINGA",
        "TANTAMAYO"
      ];
    } else if (selectpro == 'LEONCIO PRADO') {
      return [
        "RUPA-RUPA(Tingo María)",
        "DANIEL ALOMIA ROBLES",
        "HERMILIO VALDIZAN",
        "JOSE CRESPO Y CASTILLO(Aucayacu)",
        "LUYANDO 1/",
        "MARIANO DAMASO BERAUN(Las Palmas)"
      ];
    } else if (selectpro == 'MARAÑON') {
      return ["HUACRACHUCO", "CHOLON(San Pedro de Chonta)", "SAN BUENAVENTURA"];
    } else if (selectpro == 'PACHITEA') {
      return ["PANAO", "CHAGLLA", "MOLINO", "UMARI 2/"];
    } else if (selectpro == 'PUERTO INCA') {
      return [
        "PUERTO INCA",
        "CODO DEL POZUZO",
        "HONORIA",
        "TOURNAVISTA",
        "YUYAPICHIS"
      ];
    } else if (selectpro == 'LAURICOCHA') {
      return [
        "JESUS",
        "BAÑOS",
        "JIVIA",
        "QUEROPALCA",
        "RONDOS",
        "SAN FRANCISCO DE ASIS(Huarin)",
        "SAN MIGUEL DE CAURI(Cauri)"
      ];
    } else if (selectpro == 'YAROWILCA') {
      return [
        "CHAVINILLO",
        "CAHUAC",
        "CHACABAMBA",
        "CHUPAN",
        "JACAS CHICO(San Cristobal de Jacas Chico)",
        "OBAS",
        "PAMPAMARCA"
      ];
    } else if (selectpro == 'ICA') {
      return [
        "ICA",
        "LA TINGUIÑA",
        "LOS AQUIJES",
        "OCUCAJE",
        "PACHACUTEC (Pampa de Tate)",
        "PARCONA",
        "PUEBLO NUEVO",
        "SALAS (Guadalupe)",
        "SAN JOSE DE LOS MOLINOS",
        "SAN JUAN BAUTISTA",
        "SANTIAGO",
        "SUBTANJALLA",
        "TATE (Tate de la Capilla)",
        "YAUCA DEL ROSARIO (Curis) 1/"
      ];
    } else if (selectpro == 'CHINCHA') {
      return [
        "CHINCHA ALTA",
        "ALTO LARAN",
        "CHAVIN",
        "CHINCHA BAJA",
        "EL CARMEN",
        "GROCIO PRADO (San Pedro)",
        "PUEBLO NUEVO",
        "SAN JUAN DE YANAC",
        "SAN PEDRO DE HUACARPANA",
        "SUNAMPE",
        "TAMBO DE MORA"
      ];
    } else if (selectpro == 'NAZCA') {
      return [
        "NAZCA",
        "CHANGUILLO",
        "EL INGENIO",
        "MARCONA (San Juan)",
        "VISTA ALEGRE"
      ];
    } else if (selectpro == 'PALPA') {
      return ["PALPA", "LLIPATA", "RIO GRANDE", "SANTA CRUZ", "TIBILLO"];
    } else if (selectpro == 'PISCO') {
      return [
        "PISCO",
        "HUANCANO",
        "HUMAY",
        "INDEPENDENCIA",
        "PARACAS",
        "SAN ANDRES",
        "SAN CLEMENTE",
        "TUPAC AMARU INCA (Tupac Amaru)"
      ];
    } else if (selectpro == 'HUANCAYO') {
      return [
        "HUANCAYO",
        "CARHUACALLANGA",
        "CHACAPAMPA",
        "CHICCHE",
        "CHILCA",
        "CHONGOS ALTO",
        "CHUPURO",
        "COLCA",
        "CULLHUAS",
        "EL TAMBO",
        "HUACRAPUQUIO",
        "HUALHUAS",
        "HUANCAN",
        "HUASICANCHA",
        "HUAYUCACHI",
        "INGENIO",
        "PARIAHUANCA",
        "PILCOMAYO",
        "PUCARA",
        "QUICHUAY",
        "QUILCAS",
        "SAN AGUSTIN",
        "SAN JERONIMO DE TUNAN",
        "SAÑO (San Pedro de Saño)",
        "SANTO DOMINGO DE ACOBAMBA",
        "SAPALLANGA",
        "SICAYA",
        "VIQUES"
      ];
    } else if (selectpro == 'CHANCHAMAYO') {
      return [
        "CHANCHAMAYO (La Merced)",
        "PERENE",
        "PICHANAQUI (Bajo Pichanaqui)",
        "SAN LUIS DE SHUARO",
        "SAN RAMON",
        "VITOC (Pucará)"
      ];
    } else if (selectpro == 'CONCEPCION') {
      return [
        "CONCEPCION",
        "ACO",
        "ANDAMARCA",
        "CHAMBARA",
        "COCHAS",
        "COMAS",
        "HEROINAS TOLEDO (San Antonio de Ocopa)",
        "MANZANARES (San Miguel)",
        "MARISCAL CASTILLA (Mucllo)",
        "MATAHUASI",
        "MITO",
        "NUEVE DE JULIO (Santo Domingo del Prado)",
        "ORCOTUNA",
        "SAN JOSE DE QUERO",
        "SANTA ROSA DE OCOPA (Santa Rosa)"
      ];
    } else if (selectpro == 'JUNIN') {
      return ["JUNIN", "CARHUAMAYO", "ONDORES", "ULCUMAYO"];
    } else if (selectpro == 'SATIPO') {
      return [
        "SATIPO",
        "COVIRIALI",
        "LLAYLLA",
        "MAZAMARI",
        "PAMPA HERMOSA (Mariposa)",
        "PANGOA (San Martín de Pangoa)",
        "RIO NEGRO",
        "RIO TAMBO (Puerto Ocopa)"
      ];
    } else if (selectpro == 'JAUJA') {
      return [
        "JAUJA",
        "ACOLLA",
        "APATA",
        "ATAURA",
        "CANCHAYLLO",
        "CURICACA (El Rosario)",
        "EL MANTARO (Pucucho)",
        "HUAMALI",
        "HUARIPAMPA",
        "HUERTAS",
        "JANJAILLO",
        "JULCAN",
        "LEONOR ORDOÑEZ (Huancani)",
        "LLOCLLAPAMPA",
        "MARCO",
        "MASMA",
        "MASMA CHICCHE",
        "MOLINOS",
        "MONOBAMBA",
        "MUQUI",
        "MUQUIYAUYO",
        "PACA",
        "PACCHA",
        "PANCAN",
        "PARCO",
        "POMACANCHA",
        "RICRAN",
        "SAN LORENZO",
        "SAN PEDRO DE CHUNAN",
        "SAUSA",
        "SINCOS",
        "TUNAN MARCA (Concho)",
        "YAULI",
        "YAUYOS"
      ];
    } else if (selectpro == 'TARMA') {
      return [
        "TARMA",
        "ACOBAMBA",
        "HUARICOLCA",
        "HUASAHUASI",
        "LA UNION (Leticia)",
        "PALCA",
        "PALCAMAYO",
        "SAN PEDRO DE CAJAS",
        "TAPO"
      ];
    } else if (selectpro == 'YAULI') {
      return [
        "LA OROYA",
        "CHACAPALPA",
        "HUAY-HUAY",
        "MARCAPOMACOCHA",
        "MOROCOCHA",
        "PACCHA",
        "SANTA BARBARA DE CARHUACAYAN",
        "SANTA ROSA DE SACCO",
        "SUITUCANCHA",
        "YAULI"
      ];
    } else if (selectpro == 'CHUPACA') {
      return [
        "CHUPACA",
        "AHUAC",
        "CHONGOS BAJO",
        "HUACHAC",
        "HUAMANCACA CHICO",
        "SAN JUAN DE YSCOS (Yscos)",
        "SAN JUAN DE JARPA (Jarpa)",
        "TRES DE DICIEMBRE",
        "YANACANCHA"
      ];
    } else if (selectpro == 'TRUJILLO') {
      return [
        "TRUJILLO",
        "EL PORVENIR",
        "FLORENCIA DE MORA",
        "HUANCHACO",
        "LA ESPERANZA",
        "LAREDO",
        "MOCHE",
        "POROTO",
        "SALAVERRY",
        "SIMBAL",
        "VICTOR LARCO HERRERA (Buenos Aires)"
      ];
    } else if (selectpro == 'ASCOPE') {
      return [
        "ASCOPE",
        "CHICAMA",
        "CHOCOPE",
        "MAGDALENA DE CAO",
        "PAIJAN",
        "RAZURI (Puerto de Malabrigo)",
        "SANTIAGO DE CAO",
        "CASA GRANDE"
      ];
    } else if (selectpro == 'BOLIVAR') {
      return [
        "BOLIVAR",
        "BAMBAMARCA",
        "CONDORMARCA",
        "LONGOTEA",
        "UCHUMARCA",
        "UCUNCHA"
      ];
    } else if (selectpro == 'CHEPEN') {
      return ["CHEPEN", "PACANGA", "PUEBLO NUEVO"];
    } else if (selectpro == 'JULCAN') {
      return ["JULCAN", "CALAMARCA", "CARABAMBA", "HUASO"];
    } else if (selectpro == 'OTUZCO') {
      return [
        "OTUZCO",
        "AGALLPAMPA",
        "CHARAT",
        "HUARANCHAL",
        "LA CUESTA",
        "MACHE",
        "PARANDAY",
        "SALPO",
        "SINSICAP",
        "USQUIL"
      ];
    } else if (selectpro == 'GRAN CHIMU') {
      return ["CASCAS", "LUCMA", "MARMOT 1/", "SAYAPULLO"];
    } else if (selectpro == 'VIRU') {
      return ["VIRU", "CHAO", "GUADALUPITO"];
    } else if (selectpro == 'PACASMAYO') {
      return [
        "SAN PEDRO DE LLOC",
        "GUADALUPE",
        "JEQUETEPEQUE",
        "PACASMAYO",
        "SAN JOSE"
      ];
    } else if (selectpro == 'PATAZ') {
      return [
        "TAYABAMBA",
        "BULDIBUYO",
        "CHILLIA",
        "HUANCASPATA",
        "HUAYLILLAS",
        "HUAYO",
        "ONGON",
        "PARCOY",
        "PATAZ",
        "PIAS",
        "SANTIAGO DE CHALLAS (Challas)",
        "TAURIJA",
        "URPAY"
      ];
    } else if (selectpro == 'SANCHEZ CARRION') {
      return [
        "HUAMACHUCO",
        "CHUGAY",
        "COCHORCO (Aricapampa)",
        "CURGOS",
        "MARCABAL",
        "SANAGORAN",
        "SARIN",
        "SARTIMBAMBA"
      ];
    } else if (selectpro == 'SANTIAGO DE CHUCO') {
      return [
        "SANTIAGO DE CHUCO",
        "ANGASMARCA",
        "CACHICADAN",
        "MOLLEBAMBA",
        "MOLLEPATA",
        "QUIRUVILCA",
        "SANTA CRUZ DE CHUCA",
        "SITABAMBA"
      ];
    } else if (selectpro == 'CHICLAYO') {
      return [
        "CHICLAYO",
        "CHONGOYAPE",
        "ETEN",
        "ETEN PUERTO",
        "JOSE LEONARDO ORTIZ",
        "LA VICTORIA",
        "LAGUNAS (Mocupe) 1/",
        "MONSEFU",
        "NUEVA ARICA",
        "OYOTUN",
        "PICSI",
        "PIMENTEL",
        "REQUE",
        "SANTA ROSA",
        "SAÑA",
        "SANTA ROSA",
        "CAYALTI",
        "PATAPO",
        "POMALCA",
        "PUCALA",
        "TUMAN"
      ];
    } else if (selectpro == 'FERREÑAFE') {
      return [
        "FERREÑAFE",
        "CAÑARIS",
        "INCAHUASI",
        "MANUEL ATONIO MESONES MURO",
        "PITIPO",
        "PUEBLO NUEVO"
      ];
    } else if (selectpro == 'LAMBAYEQUE') {
      return [
        "LAMBAYEQUE",
        "CHOCHOPE",
        "ILLIMO",
        "JAYANCA",
        "MOCHUMI",
        "MORROPE",
        "MOTUPE",
        "OLMOS",
        "PACORA",
        "SALAS",
        "SAN JOSE",
        "TUCUME"
      ];
    } else if (selectpro == 'LIMA') {
      return [
        "ANCON",
        "ATE",
        "BARRANCO",
        "BREÑA",
        "CARABAYLLO",
        "CHACLACAYO",
        "CHORRILLOS",
        "CIENEGUILLA",
        "COMAS (La Libertad)",
        "EL AGUSTINO",
        "INDEPENDENCIA",
        "JESUS MARIA",
        "LA MOLINA",
        "LA VICTORIA",
        "LINCE",
        "LOS OLIVOS (Las Palmeras)",
        "LURIGANCHO (Chosica)",
        "LURIN",
        "MAGDALENA DEL MAR",
        "MAGDALENA VIEJA (Pueblo Libre)",
        "MIRAFLORES",
        "PACHACAMAC",
        "PUCUSANA",
        "PUENTE PIEDRA",
        "PUNTA HERMOSA",
        "PUNTA NEGRA",
        "RIMAC",
        "SAN BARTOLO",
        "SAN BORJA (San Fco. de Borja)",
        "SAN ISIDRO",
        "SAN JUAN DE LURIGANCHO",
        "SAN JUAN DE MIRAFLORES (Ciudad de Dios)",
        "SAN LUIS",
        "SAN MARTIN DE PORRES (B. Obrero Industrial)",
        "SAN MIGUEL",
        "SANTA ANITA",
        "SANTA MARIA DEL MAR",
        "SANTA ROSA",
        "SANTIAGO DE SURCO",
        "SURQUILLO",
        "VILLA EL SALVADOR",
        "VILLA MARIA DEL TRIUNFO"
      ];
    } else if (selectpro == 'BARRANCA') {
      return ["BARRANCA", "PARAMONGA", "PATIVILCA", "SUPE", "SUPE PUERTO"];
    } else if (selectpro == 'CAJATAMBO') {
      return ["CAJATAMBO", "COPA", "GORGOR", "HUANCAPON", "MANAS"];
    } else if (selectpro == 'CAÑETE') {
      return [
        "SAN VICENTE DE CAÑETE",
        "ASIA",
        "CALANGO",
        "CERRO AZUL",
        "CHILCA",
        "COAYLLO",
        "IMPERIAL",
        "LUNAHUANA",
        "MALA",
        "NUEVO IMPERIAL",
        "PACARAN",
        "QUILMANA",
        "SAN ANTONIO",
        "SAN LUIS",
        "SANTA CRUZ DE FLORES",
        "ZUÑIGA"
      ];
    } else if (selectpro == 'CANTA') {
      return [
        "CANTA",
        "ARAHUAY",
        "HUAMANTANGA",
        "HUAROS",
        "LACHAQUI",
        "SAN BUENAVENTURA",
        "SANTA ROSA DE QUIVES (Yangas)"
      ];
    } else if (selectpro == 'HUARAL') {
      return [
        "HUARAL",
        "ATAVILLOS ALTO (Pirca)",
        "ATAVILLOS BAJO (Sn. Agustín de Huayapampa)",
        "AUCALLAMA",
        "CHANCAY",
        "IHUARI",
        "LAMPIAN",
        "PACARAOS",
        "SAN MIGUEL DE ACOS (Acos)",
        "SANTA CRUZ DE ANDAMARCA",
        "SUMBILCA",
        "VEINTISIETE DE NOVIEMBRE (Carac)"
      ];
    } else if (selectpro == 'HUAROCHIRI') {
      return [
        "MATUCANA",
        "ANTIOQUIA",
        "CALLAHUANCA",
        "CARAMPOMA",
        "CHICLA",
        "CUENCA (Sn. José de los Chorrillos)",
        "HUACHUPAMPA (Sn. Lorenzo de Huachupampa)",
        "HUANZA",
        "HUAROCHIRI",
        "LAHUAYTAMBO",
        "LANGA",
        "LARAOS",
        "MARIATANA",
        "RICARDO PALMA",
        "SAN ANDRES DE TUPICOCHA",
        "SAN ANTONIO (Chaclla)",
        "SAN BARTOLOME",
        "SAN DAMIAN",
        "SAN JUAN DE IRIS",
        "SAN JUAN DE TANTARANCHE",
        "SAN LORENZO DE QUINTI",
        "SAN MATEO",
        "SAN MATEO DE OTAO (Sn. Juan de Lanca)",
        "SAN PEDRO DE CASTA",
        "SAN PEDRO DE HUANCAYRE (Sn. Pedro)",
        "SANGALLAYA",
        "SANTA CRUZ DE COCACHACRA (Cocachacra)",
        "SANTA EULALIA",
        "SANTIAGO DE ANCHUCAYA",
        "SANTIAGO DE TUNA",
        "SANTO DOMINGO DE LOS OLLEROS",
        "SURCO"
      ];
    } else if (selectpro == 'HUAURA') {
      return [
        "HUACHO",
        "AMBAR",
        "CALETA DE CARQUIN",
        "CHECRAS (Maray)",
        "HUALMAY",
        "HUAURA",
        "LEONCIO PRADO (Sta. Cruz)",
        "PACCHO",
        "SANTA LEONOR (Jucul)",
        "SANTA MARIA (Cruz Blanca)",
        "SAYAN",
        "VEGUETA"
      ];
    } else if (selectpro == 'OYON') {
      return [
        "OYON",
        "ANDAJES",
        "CAUJUL",
        "COCHAMARCA",
        "NAVAN",
        "PACHANGARA (Churín)"
      ];
    } else if (selectpro == 'YAUYOS') {
      return [
        "YAUYOS",
        "ALIS",
        "AYAUCA",
        "AYAVIRI",
        "AZANGARO",
        "CACRA",
        "CARANIA",
        "CATAHUASI",
        "CHOCOS",
        "COCHAS",
        "COLONIA",
        "HONGOS",
        "HUAMPARA",
        "HUANCAYA",
        "HUANGASCAR",
        "HUANTAN",
        "HUAÑEC",
        "LARAOS",
        "LINCHA",
        "MADEAN",
        "MIRAFLORES",
        "OMAS",
        "PUTINZA (Sn. Lorenzo de Putinza)",
        "QUINCHES",
        "QUINOCAY",
        "SAN JOAQUIN",
        "SAN PEDRO DE PILAS",
        "TANTA",
        "TAURIPAMPA",
        "TOMAS",
        "TUPE",
        "VIÑAC",
        "VITIS"
      ];
    } else if (selectpro == 'CALLAO') {
      return [
        "CALLAO",
        "BELLAVISTA",
        "CARMEN DE LA LEGUA REYNOSO",
        "LA PERLA",
        "LA PUNTA",
        "VENTANILLA"
      ];
    } else if (selectpro == 'MAYNAS') {
      return [
        "IQUITOS",
        "ALTO NANAY (Sta. María de Nanay)",
        "FERNANDO LORES (Tamshiyacu)",
        "INDIANA",
        "LAS AMAZONAS (Fco. de Orellana)",
        "MAZAN",
        "NAPO (Sta. Clotilde)",
        "PUNCHANA",
        "PUTUMAYO (Puca Urco) 1/",
        "TORRES CAUSANA (Pantoja)",
        "BELEN",
        "SAN JUAN BAUTISTA",
        "TENIENTE MANUEL CAVERO"
      ];
    } else if (selectpro == 'ALTO AMAZONAS') {
      return [
        "YURIMAGUAS",
        "BALSAPUERTO",
        "JEBEROS",
        "LAGUNAS",
        "SANTA CRUZ",
        "TENIENTE CESAR LOPEZ ROJAS (Shucushuyacu)"
      ];
    } else if (selectpro == 'DATEM DEL MARAÑON') {
      return [
        "BARRANCA",
        "CAHUAPANAS",
        "MANSERICHE (Borja)",
        "MORONA (Pto. América)",
        "PASTAZA",
        "ANDOAS"
      ];
    } else if (selectpro == 'LORETO') {
      return [
        "NAUTA",
        "PARINARI 2/",
        "TIGRE (Intutu)",
        "TROMPETEROS (Villa Trompeteros)",
        "URARINAS (Concordia) 3/"
      ];
    } else if (selectpro == 'MARISCAL RAMON CASTILLA') {
      return [
        "RAMON CASTILLA (Caballococha)",
        "PEBAS",
        "YAVARI (Amelia)",
        "SAN PABLO"
      ];
    } else if (selectpro == 'REQUENA') {
      return [
        "REQUENA",
        "ALTO TAPICHE (Sta. Elena)",
        "CAPELO (Flor de Punga)",
        "EMILIO SAN MARTIN (Tamango)",
        "MAQUIA (Sta. Isabel)",
        "PUINAHUA (Bretaña)",
        "SAQUENA (Bagazán)",
        "SOPLIN (Nva. Alejandría) 4/",
        "TAPICHE (Iberia)",
        "YAQUERANA (Bolognesi) * 5/",
        "JENARO HERRERA"
      ];
    } else if (selectpro == 'UCAYALI') {
      return [
        "CONTAMANA",
        "INAHUAYA",
        "PADRE MARQUEZ (Tiruntán)",
        "PAMPA HERMOSA",
        "SARAYACU (Dos de Mayo)",
        "VARGAS GUERRA (Orellana)"
      ];
    } else if (selectpro == 'TAMBOPATA') {
      return [
        "TAMBOPATA (Pto. Maldonado)",
        "INAMBARI (Mazuco)",
        "LAS PIEDRAS 1/",
        "LABERINTO (Pto. Rosario de Laberinto)"
      ];
    } else if (selectpro == 'MANU') {
      return ["FITZCARRALD 3/", "MANU 2/", "MADRE DE DIOS 4/", "HEUPETUHE"];
    } else if (selectpro == 'TAHUAMANU') {
      return ["IÑAPARI", "IBERIA", "TAHUAMANU (San Lorenzo)"];
    } else if (selectpro == 'MARISCAL NIETO') {
      return [
        "MOQUEGUA",
        "CARUMAS",
        "CUCHUMBAYA",
        "SAMEGUA",
        "SAN CRISTOBAL(Calacoa)",
        "TORATA"
      ];
    } else if (selectpro == 'GENERAL SANCHEZ CERRO') {
      return [
        "OMATE",
        "CHOJATA",
        "COALAQUE",
        "ICHUÑA",
        "LA CAPILLA",
        "LLOQUE",
        "MATALAQUE",
        "PUQUINA",
        "QUINISTAQUILLAS",
        "UBINAS",
        "YUNGA"
      ];
    } else if (selectpro == 'ILO') {
      return ["ILO", "EL ALGARROBAL", "PACOCHA(Pueblo Nuevo)"];
    } else if (selectpro == 'PASCO') {
      return [
        "CHAUPIMARCA (C. de Pasco)",
        "HUACHON",
        "HUARIACA",
        "HUAYLLAY",
        "NINACACA",
        "PALLANCHACRA",
        "PAUCARTAMBO",
        "SAN FCO.DE ASIS DE YARUSYACAN (Yarustacán)",
        "SIMON BOLIVAR (San Antonio de Rancas)",
        "TICLACAYAN",
        "TINYAHUARCO",
        "VICCO",
        "YANACANCHA"
      ];
    } else if (selectpro == 'DANIEL ALCIDES CARRION') {
      return [
        "YANAHUANCA",
        "CHACAYAN",
        "GOYLLARISQUIZGA",
        "PAUCAR",
        "SAN PEDRO DE PILLAO",
        "SANTA ANA DE TUSI",
        "TAPUC",
        "VILCABAMBA"
      ];
    } else if (selectpro == 'OXAPAMPA') {
      return [
        "OXAPAMPA",
        "CHONTABAMBA",
        "HUANCABAMBA",
        "PALCAZU (Lacozacin)",
        "POZUZO",
        "PUERTO BERMUDEZ",
        "VILLA RICA"
      ];
    } else if (selectpro == 'PIURA') {
      return [
        "PIURA",
        "CASTILLA",
        "CATACAOS",
        "CURA MORI (Cucungara)",
        "EL TALLAN (Sinchao)",
        "LA ARENA",
        "LA UNION",
        "LAS LOMAS",
        "TAMBO GRANDE"
      ];
    } else if (selectpro == 'AYABACA') {
      return [
        "AYABACA",
        "FRIAS",
        "JILILI",
        "LAGUNAS",
        "MONTERO",
        "PACAIPAMPA",
        "PAIMAS",
        "SAPILLICA",
        "SICCHEZ",
        "SUYO"
      ];
    } else if (selectpro == 'HUANCABAMBA') {
      return [
        "HUANCABAMBA",
        "CANCHAQUE",
        "EL CARMEN DE LA FRONTERA (Sapalacha)",
        "HUARMACA",
        "LALAQUIZ (Tunal)",
        "SAN MIGUEL DE EL FAIQUE",
        "SONDOR",
        "SONDORILLO"
      ];
    } else if (selectpro == 'PAITA') {
      return [
        "PAITA",
        "AMOTAPE",
        "ARENAL",
        "COLAN (San Lucas)",
        "LA HUACA",
        "TAMARINDO",
        "VICHAYAL (Sn. Felino de Vichayal)"
      ];
    } else if (selectpro == 'MORROPON') {
      return [
        "CHULUCANAS",
        "BUENOS AIRES",
        "CHALACO",
        "LA MATANZA",
        "MORROPON",
        "SALITRAL",
        "SAN JUAN DE BIGOTE (Bogote)",
        "SANTA CATALINA DE MOSSA (Paltashaco)",
        "SANTO DOMINGO",
        "YAMANGO"
      ];
    } else if (selectpro == 'SECHURA') {
      return [
        "SECHURA",
        "BELLAVISTA LA UNION (Bellavista)",
        "BERNAL",
        "CRISTO NOS VALGA (San Cristo)",
        "RINCONADA LLICUAR (Dos Pueblos)",
        "VICE"
      ];
    } else if (selectpro == 'SULLANA') {
      return [
        "SULLANA",
        "BELLAVISTA",
        "IGNACIO ESCUDERO (San Jacinto)",
        "LANCONES",
        "MARCAVELICA",
        "MIGUEL CHECA (Sojo)",
        "QUERECOTILLO",
        "SALITRAL"
      ];
    } else if (selectpro == 'TALARA') {
      return [
        "PARIÑAS (Talara)",
        "EL ALTO",
        "LA BREA (Negritos)",
        "LOBITOS",
        "LOS ORGANOS",
        "MANCORA"
      ];
    } else if (selectpro == 'PUNO') {
      return [
        "PUNO",
        "ACORA",
        "AMANTANI",
        "ATUNCOLLA",
        "CAPACHICA",
        "CHUCUITO",
        "COATA",
        "HUATA",
        "MAÑAZO",
        "PAUCARCOLLA",
        "PICHACANI (Laraqueri)",
        "PLATERIA",
        "SAN ANTONIO (San Antonio de Esquilache)",
        "TIQUILLACA",
        "VILQUE"
      ];
    } else if (selectpro == 'AZANGARO') {
      return [
        "AZANGARO",
        "ACHAYA",
        "ARAPA",
        "ASILLO",
        "CAMINACA",
        "CHUPA",
        "JOSE DOMINGO CHOQUEHUANCA (Estación de Pucará)",
        "MUÑANI",
        "POTONI",
        "SAMAN",
        "SAN ANTON",
        "SAN JOSE",
        "SAN JUAN DE SALINAS",
        "SANTIAGO DE PUPUJA",
        "TIRAPATA"
      ];
    } else if (selectpro == 'CARABAYA') {
      return [
        "MACUSANI",
        "AJOYANI",
        "AYAPATA",
        "COASA",
        "CORANI",
        "CRUCERO",
        "ITUATA (Tambillos)",
        "OLLACHEA",
        "SAN GABAN (Lanlacuni Bajo)",
        "USICAYOS"
      ];
    } else if (selectpro == 'CHUCUITO') {
      return [
        "JULI",
        "DESAGUADERO",
        "HUACULLANI",
        "KELLUYO",
        "PISACOMA",
        "POMATA",
        "ZEPITA"
      ];
    } else if (selectpro == 'EL COLLAO') {
      return [
        "ILAVE",
        "CAPAZO",
        "PILCUYO",
        "SANTA ROSA (Mazo Cruz)",
        "CONDURIRI"
      ];
    } else if (selectpro == 'HUANCANE') {
      return [
        "HUANCANE",
        "COJATA",
        "HUATASANI",
        "INCHUPALLA",
        "PUSI",
        "ROSASPATA",
        "TARACO",
        "VILQUE CHICO"
      ];
    } else if (selectpro == 'LAMPA') {
      return [
        "LAMPA",
        "CABANILLA",
        "CALAPUJA",
        "NICASIO",
        "OCUVIRI",
        "PALCA",
        "PARATIA",
        "PUCARA",
        "SANTA LUCIA",
        "VILAVILA"
      ];
    } else if (selectpro == 'MELGAR') {
      return [
        "AYAVIRI",
        "ANTAUTA",
        "CUPI",
        "LLALLI",
        "MACARI",
        "NUÑOA",
        "ORURILLO",
        "SANTA ROSA",
        "UMACHIRI"
      ];
    } else if (selectpro == 'MOHO') {
      return ["MOHO", "CONIMA", "HUAYRAPATA", "TILALI"];
    } else if (selectpro == 'SAN ANTONIO DE PUTINA') {
      return [
        "PUTINA",
        "ANANEA",
        "PEDRO VILCA APAZA (Ayrampuni)",
        "QUILCAPUNCU",
        "SINA"
      ];
    } else if (selectpro == 'SAN ROMAN') {
      return ["JULIACA", "CABANA", "CABANILLAS (Deustua)", "CARACOTO"];
    } else if (selectpro == 'SANDIA') {
      return [
        "SANDIA",
        "CUYOCUYO",
        "LIMBANI",
        "PATAMBUCO",
        "PHARA",
        "QUIACA",
        "SAN JUAN DEL ORO",
        "YANAHUAYA",
        "ALTO INAMBARI (Massiapo)"
      ];
    } else if (selectpro == 'YUNGUYO') {
      return [
        "YUNGUYO",
        "ANAPIA",
        "COPANI",
        "CUTURAPI (San Juan de Cuturapi)",
        "OLLARAYA (San Miguel de Ollaraya)",
        "TINICACHI",
        "UNICACHI (Marcaja)"
      ];
    } else if (selectpro == 'BELLAVISTA') {
      return [
        "BELLAVISTA",
        "ALTO BIAVO (Cuzco)",
        "BAJO BIAVO (Nueva Lima)",
        "HUALLAGA (Ledoy)",
        "SAN PABLO",
        "SAN RAFAEL"
      ];
    } else if (selectpro == 'HUALLAGA') {
      return [
        "SAPOSOA",
        "ALTO SAPOSOA (Pasarraya)",
        "EL ESLABON",
        "PISCOYACU",
        "SACANCHE",
        "TINGO DE SAPOA"
      ];
    } else if (selectpro == 'LAMAS') {
      return [
        "LAMAS",
        "ALONSO DE ALVARA (Roque)",
        "BARRANQUITA",
        "CAYNARACHI (Shanusi) 1/",
        "CUÑUMBUQUI",
        "PINTO RECODO",
        "RUMISAPA",
        "SAN ROQUE DE CUMBAZA",
        "SHANAO",
        "TABALOSOS",
        "ZAPATERO"
      ];
    } else if (selectpro == 'MARISCAL CACERES') {
      return ["JUANJUI", "CAMPANILLA", "HUICUNGO", "PACHIZA", "PAJARILLO"];
    } else if (selectpro == 'MOYOBAMBA') {
      return [
        "MOYOBAMBA",
        "CALZADDA",
        "HABANA",
        "JEPELACIO",
        "SORITOR",
        "YANTALO"
      ];
    } else if (selectpro == 'PICOTA') {
      return [
        "PICOTA",
        "BUENOS AIRES",
        "CASPISAPA",
        "PILLUANA",
        "PUCACACA",
        "SAN CRISTOBAL (Puerto Rico)",
        "SAN HILARION (San Cristobal de Sisa)",
        "SHAMBOYACU",
        "TINGO DE PONASA",
        "TRES UNIDOS"
      ];
    } else if (selectpro == 'RIOJA') {
      return [
        "RIOJA",
        "AWAJUN (Bajo Naranjillo)",
        "ELIAS SOPLIN VARGAS (Sda. Jerusalén-Azunguillo)",
        "NUEVA CAJAMARCA",
        "PARDO MIGUEL (Naranjos)",
        "POSIC",
        "SAN FERNANDO",
        "YORONGOS",
        "YURACYACU"
      ];
    } else if (selectpro == 'SAN MARTIN') {
      return [
        "TARAPOTO",
        "ALBERTO LEVEAU (Utcurarca)",
        "CACATACHI",
        "CHAZUTA",
        "CHIPURANA (Navarro)",
        "EL PORVENIR (Pelejo)",
        "HUMBAYOC",
        "JUAN GUERRA",
        "LA BANDA DE SHILCAYO (La Banda)",
        "MORALES",
        "PAPAPLAYA",
        "SAN ANTONIO",
        "SAUCE",
        "SHAPAJA"
      ];
    } else if (selectpro == 'TOCACHE') {
      return [
        "TOCACHE",
        "NUEVO PROGRESO",
        "POLVORA 2/",
        "SHUNTE (Tambo de Paja)",
        "UCHIZA"
      ];
    } else if (selectpro == 'EL DORADO') {
      return [
        "SAN JOSE DE SISA",
        "AGUA BLANCA",
        "SAN MARTIN",
        "SANTA ROSA",
        "SHATOJA"
      ];
    } else if (selectpro == 'TACNA') {
      return [
        "TACNA",
        "ALTO DE LA ALIANZA (La Esperanza)",
        "CALANA",
        "INCLAN (Sama Grande)",
        "PACHIA",
        "PALCA",
        "POCOLLAY",
        "SAMA (Las Yaras)",
        "CIUDAD NUEVA"
      ];
    } else if (selectpro == 'CANDARAVE') {
      return [
        "CANDARAVE",
        "CAIRANI",
        "CAMILACA",
        "CURIBAYA",
        "HUANUARA",
        "QUILAHUANI"
      ];
    } else if (selectpro == 'JORGE BASADRE') {
      return ["LOCUMBA", "ILABAYA", "ITE"];
    } else if (selectpro == 'TARATA') {
      return [
        "TARATA",
        "CHUCATAMANI",
        "ESTIQUE",
        "ESTIQUE-PAMPA",
        "SITAJARA",
        "SUSAPAYA",
        "TARUCACHI",
        "TICACO"
      ];
    } else if (selectpro == 'ZARUMILLA') {
      return ["ZARUMILLA", "AGUAS VERDES", "MATAPALO", "PAPAYAL"];
    } else if (selectpro == 'TUMBES') {
      return [
        "TUMBES",
        "CORRALES(San Pedro de los Incas)",
        "LA CRUZ(Caleta Cruz)",
        "PAMPAS DE HOSPITAL",
        "SAN JACINTO",
        "SAN JUAN DE LA VIRGEN"
      ];
    } else if (selectpro == 'CONTRALMIRANTE VILLAR') {
      return ["ZORRITOS", "CASITAS(Cañaveral)"];
    } else if (selectpro == 'CORONEL PORTILLO') {
      return [
        "CALLARIA (Pucallpa)",
        "CAMPOVERDE",
        "IPARIA",
        "MASISEA",
        "YARINACOCHA (Puerto Callao)",
        "NUEVA REQUENA"
      ];
    } else if (selectpro == 'ATALAYA') {
      return ["RAYMONDI", "SEPAHUA", "TAHUANIA (Bolognesi)", "YURUA"];
    } else if (selectpro == 'PADRE ABAD') {
      return ["PADRE ABAD (Aguaytía)", "IRAZOLA (San Alejandro)", "CURIMANA"];
    } else if (selectpro == 'PURUS') {
      return ["PURUS(Esperanza)"];
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
    String licencia = '0';
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
