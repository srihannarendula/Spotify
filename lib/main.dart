import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(
        padding: EdgeInsetsGeometry.all(15),
        children: [
          const Text(
            "Good Morning"
            , style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          // GridView.count(
          //   crossAxisCount: 2,
          //   childAspectRatio: 3.5,
          //   shrinkWrap: true,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   physics: NeverScrollableScrollPhysics(),
          //   children: List.generate(
          //       8,
          //           (index) =>
          //           Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.grey[850],
          //                 borderRadius: BorderRadius.circular(10)
          //             ),
          //             child: Row(
          //               children: [
          //                 Container(
          //                   width: 50,
          //                   decoration: BoxDecoration(
          //                       color: Colors.grey[800],
          //                       borderRadius: BorderRadius.horizontal(left: Radius.circular(10))
          //                   ),
          //                 ),
          //                 SizedBox(width: 10,)
          //                 ,
          //                 Text("Playlist Title")
          //               ],
          //             ),
          //           )
          //
          //   ),
          //
          // ),
          SizedBox(
            height: 250,
            child: FutureBuilder(
                future: fetchSongs(),

                builder:(context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final songs = snapshot.data as List<dynamic>;

                  return  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,

                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final song = songs[index];
                      return Flexible(
                        child: Container(
                          width: 10,
                          decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10))

                                  ),
                                  child: Image.network(
                                    song["artworkUrl100"],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )
                              ),
                              SizedBox(width: 5,)
                              ,
                              Text(song["collectionName"].substring(0,15),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                                overflow: TextOverflow.fade,)
                            ],
                          ),
                        ),
                      );
                    },
                  );

                }
            ),

          ),

          SizedBox(height: 10,),
          Text("Jump back in", style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
          SizedBox(
            height: 250,
            child: FutureBuilder(
                future: fetchSongs(),

                builder:(context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final songs = snapshot.data as List<dynamic>;

                  return ListView.builder(
                      shrinkWrap: false,
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      color: Colors.grey[800],
                                      height: 150,
                                      child: Image.network(
                                        song["artworkUrl100"],
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                  Text(
                                    song["trackName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(song["collectionName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(song["artistName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),

                            )
                        );
                      }

                  );
                }
            ),

          ),
          SizedBox(height: 10,),
          Text("Popular Albums and singles", style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
          SizedBox(
            height: 250,
            child: FutureBuilder(
                future: fetchSongs(),

                builder:(context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final songs = snapshot.data as List<dynamic>;

                  return ListView.builder(
                      shrinkWrap: false,
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      color: Colors.grey[800],
                                      height: 150,
                                      child: Image.network(
                                        song["artworkUrl100"],
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                  Text(
                                    song["trackName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(song["collectionName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(song["artistName"], style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),

                            )
                        );
                      }

                  );
                }
            ),

          )
          // child: ListView(
          //     shrinkWrap: false,
          //     scrollDirection: Axis.horizontal,
          //
          //     children: List.generate(10, (index) =>

          //         ),)
          // ),

        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedLabelStyle: TextStyle(color: Colors.white),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.book) ,  label: "Playlist"),
            BottomNavigationBarItem(icon: Icon(Icons.person) ,  label: "Settings")

          ]
      ),
    );
  }
}

Future<List<dynamic>> fetchSongs() async {
  final response = await http.get(
    Uri.parse('https://itunes.apple.com/search?term=arjit&entity=song&limit=20'),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data["results"];
  } else {
    throw Exception("Failed to load songs");
  }
}