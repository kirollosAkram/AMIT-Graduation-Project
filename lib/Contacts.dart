import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ContactProvider.dart';
import 'MainPage.dart';
import 'main.dart';

class MyContactPage extends StatefulWidget {
  const MyContactPage({super.key});

  @override
  State<MyContactPage> createState() => _MyContactPageState();
}

class _MyContactPageState extends State<MyContactPage> {
  final fireStore = FirebaseFirestore.instance;

  getData() {
    //stream
    fireStore.collection("Contact").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Text("Contacts"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: fireStore.collection("Contact").snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data!.docs.length != 0
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color:  Colors.indigo,

                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapshot.data!.docs[index]["name"] +
                                      "\n" +
                                      snapshot.data!.docs[index]["number"],style: TextStyle(color: Colors.white),),
                                  const SizedBox(
                                    width: 150.0,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context.read<ProviderC>().providerC(
                                            snapshot.data!.docs[index]["name"],
                                            snapshot.data!.docs[index]
                                                ["number"]);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyMainPage()));
                                      },
                                      icon: const Icon(
                                          Icons.favorite_border_outlined),color: Colors.white,)
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("no data"),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}
/*ListView(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Consumer<ProviderC>(
                      builder: (BuildContext context, value1, child) {
                        print("contact name ");

                        return Text(
                          value1.nameText,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  Consumer<ProviderC>(
                                  builder: (BuildContext context, value1, child) {
                                    print("contact name ");

                                    return Text(
                                      "${value1.nameText}\n${value1.phoneNumber}",
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white),
                                    );
                                  },
                                ),
                  ],
                ),
                const SizedBox(width: 200,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.heart_broken))
              ],
            ),
          )
        ],
      ),
 */
