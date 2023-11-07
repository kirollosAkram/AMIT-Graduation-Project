import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactProvider.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final myFavouriteData = Provider.of<ProviderC>(context);
    final dataList = [myFavouriteData.nameText, myFavouriteData.phoneNumber];
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Text("Favourite"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final data = dataList[index];
              return Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  data,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            }));
  }
}
/*Center(
        child: Consumer<ProviderC>(
          builder: (BuildContext context, value1, child) {
            print("contact name \n contact number");

            return Text(
              "${value1.nameText}\n${value1.phoneNumber}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),

       */
