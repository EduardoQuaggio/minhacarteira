import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minhacarteira/Presenter/Home/states/home_state.dart';
import 'package:minhacarteira/Presenter/Home/home_store.dart';

const List<String> list = <String>["Janeiro", "Fevereiro"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final store = HomeStore();
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    store.addListener(_listners);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      store.searchModelData(1);
    });
  }

  void _listners() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container();
    final state = store.state;

    if (state is LoadingHomeState || state is InitialHomeState) {
      body = const Center(child: CircularProgressIndicator());
    }

    if (state is SuccessHomeState) {
      final data = state.data;
      body = Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planejado',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/receitas');
                        },
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(
                                  Icons.paid_outlined,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Receita',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(
                                      locale: 'pt_BR',
                                      decimalDigits: 2,
                                    ).format(data.receitaTotal),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Card(
                            elevation: 3.0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(
                                Icons.paid_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Despesas planejadas',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                    locale: 'pt_BR',
                                    decimalDigits: 2,
                                  ).format(data.despesasTotal),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Últimos gastos',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: state.data.despesas.length,
                      itemBuilder: (context, index) {
                        final model = state.data.despesas[index];
                        return Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.Nome,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(model.Tipo),
                                ],
                              ),
                            ),
                            Text(
                              NumberFormat.simpleCurrency(
                                locale: 'pt_BR',
                                decimalDigits: 2,
                              ).format(model.Valor),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        store.searchModelData(10);
                      },
                      child: Text('Ver mais'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (state is ErrorHomeState) {}

    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(
          borderRadius: BorderRadius.circular(10),
          elevation: 15,
          focusColor: Colors.white,
          dropdownColor: Colors.white,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
          value: dropdownValue,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) => {
            dropdownValue = value!,
            store.searchModelData(2),
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings_sharp),
            tooltip: 'Configurações',
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: body,
    );
  }
}
