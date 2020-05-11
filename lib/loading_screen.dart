import 'package:flutter/material.dart';
import 'package:my_flutter_yelp_app/services/business.dart';
import 'package:my_flutter_yelp_app/details_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<List<Business>> _futureData;

  @override
  void initState() {
    super.initState();
    //Hit API and assign value ONCE
    _futureData = fetchBusinessList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Business>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(id: snapshot.data[index].id),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new NetworkImage(
                                "${snapshot.data[index].image_url}"),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Card(
                        child: Text(snapshot.data[index].name),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
