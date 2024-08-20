import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/UI_helper/SearchCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  bool searchByCity = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the default back button
        title: Image.asset(
          'assets/appbarlawadv.png',
          height: 50,
          width: 150,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: searchByCity ? 'Search by City' : 'Search for a Lawyer',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                suffixIcon: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (String value) {
                    setState(() {
                      if (value == 'City') {
                        searchByCity = true;
                      } else {
                        searchByCity = false;
                      }
                      isShowUsers = true;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'City',
                        child: Text('Search by City'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Lawyer',
                        child: Text('Search by Lawyer'),
                      ),
                    ];
                  },
                ),
              ),
              onSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
            ),
          ),
          Expanded(
            child: isShowUsers
                ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Lawyers')
                  .where(
                searchByCity ? 'city' : 'username',
                isGreaterThanOrEqualTo: searchController.text,
              )
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => SearchCard(snap: snapshot.data!.docs[index].data()));
              },
            )
                : const Center(child: Text("Search for a lawyer")),
          ),
        ],
      ),
    );
  }
}
