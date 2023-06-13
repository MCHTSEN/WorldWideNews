import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/models/news_model.dart';
import 'package:news_app/product/utilities/exceptions/firebase_custom_exception.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {

    // Collection'a erişim
    final CollectionReference news =
        FirebaseFirestore.instance.collection(FirebaseColletions.news.name);
    //Collectiondan alınan verilerin modele(news) göre ayrıştırılması
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        final jsonBody = snapshot.data();
        if (jsonBody != null) {
          return const News().fromJson(jsonBody);
        }
        return null;
      },
        // Collection'a gönderilen verilerin modele göre pkaetlenmesi
      toFirestore: (value, options) {
        if (value != null) {
          return value.toJson();
        }
        throw FirebaseCustomException(message: '$value cannot null');
      },
    ).get();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: response,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<News?>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const LinearProgressIndicator();
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  final value =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {  
                      return Card(
                        child: Column(
                          children: [
                            Image.network(
                              value[index]?.backgroundImage ?? '',
                              height: context.dynamicHeight(.2),
                            ),
                            Text(value[index]?.title ?? '')
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              }
          }
        },
      ),
    );
  }
}
