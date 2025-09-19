import 'package:cestas_app/main.dart';
import 'package:cestas_app/pages/basket/type_basket.dart';
import 'package:flutter/material.dart';
import 'package:cestas_app/widgets/app_drawer.dart';
import 'package:core/widgets/statCard.dart';
import '../basket/list_family.dart';
import '../basket/generate_basket.dart';



class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage>{
//Definição dos estados para os checkbox das familias

  bool isSelectedMaria = false;
  bool isSelectedAna = false;
  bool isSelectedJoao = false;



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Cestas'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TypeBasket(),
            const SizedBox(height: 24),
            FamilyList(
              isSelectedMaria: isSelectedMaria,
              isSelectedAna: isSelectedAna,
              isSelectedJoao: isSelectedJoao,
              onChangedMaria: (value){
                setState(() {
                  isSelectedMaria = value ?? false;
                });
              },
              onChangedAna: (value){
                  setState(() {
                    isSelectedAna = value ?? false;
                  });
              },
              onChangeJoao: (value){
                setState(() {
                  isSelectedJoao = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24),
            GenerateBasket(),
          ],
        ),
      ),
    );
  }
}