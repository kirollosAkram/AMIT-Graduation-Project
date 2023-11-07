import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import 'ContactProvider.dart';
import 'Contacts.dart';
import 'MainPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) {
      return ProviderC();
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fireStore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  sendData() {
    FirebaseFirestore.instance.collection("Contact").add({
      "name": controllerText.text,
      "number": controllerNumber.text
    });
    /*
    fireStore.collection("Contact").add({
      "name": controllerText.text,
      "number": controllerNumber.text
    }).then((value) => print("send $value"));
     */
  }


  int _currentIndex = 0;
  final appList = [
    const MyContactPage(),
    const MyMainPage(),
  ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controllerNumber = TextEditingController();
  final TextEditingController controllerText = TextEditingController();
  //String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined),
              label: "Contacts",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: "Favourite",
              backgroundColor: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          iconSize: 20,
          elevation: 5),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: 500,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: controllerText,
                            decoration: const InputDecoration(
                                hintText: "Contact Name",
                                icon: Icon(Icons.text_fields_rounded),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal())),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {},
                            onInputValidated: (bool value) {},
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: controllerNumber,
                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {},
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProviderC>().providerC(
                                  controllerText.text, controllerNumber.text);
                              sendData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyContactPage()),
                              );
                              //Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey;
                                  }
                                  return Colors
                                      .blueAccent; // Use the component's default.
                                },
                              ),
                            ),
                            child: const Text(
                              "add",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.blueAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: appList[_currentIndex],
    );
  }
}
