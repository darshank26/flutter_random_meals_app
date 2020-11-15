import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Meal App',
      home: MyHomePage(title: 'Flutter Meal App'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _url = "https://www.themealdb.com/api/json/v1/1/random.php";
  StreamController _streamController;
  Stream _stream;
  Response response;

  getCocktailRecipes() async {
    _streamController.add("waiting");
    response = await get(_url);
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getCocktailRecipes();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body:  RefreshIndicator(
        onRefresh: () {
          return getCocktailRecipes();
        },
        child: Center(
          child: StreamBuilder(
            stream: _stream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == "waiting") {
                return Center(child: Text("Waiting of the Recipe....."));
              }
              return Center(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int i) {
                      return Center(
                        child: ListBody(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top:8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image:  snapshot.data['meals'][0]['strMealThumb'],
                                ),),
                            ),
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:4.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text( snapshot.data['meals'][0]['strMeal'],
                                          style: TextStyle(fontSize: 16.0),),
                                        Container(
                                          margin: EdgeInsets.only(top: 4,left: 8.0),
                                          child: Text("( "+snapshot.data['meals'][0]['strCategory']+" )",
                                            style: TextStyle(fontSize: 12.0),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text("Ingredients",
                                              style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.0),
                                              width: 90.0,
                                              height: 1.0,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ((snapshot.data['meals'][0]['strIngredient1']!= null && snapshot.data['meals'][0]['strIngredient1']!= "") && (snapshot.data['meals'][0]['strMeasure1']!= null && snapshot.data['meals'][0]['strMeasure1']!= ""))  ? Text("1. "+snapshot.data['meals'][0]['strIngredient1'] + "( " +snapshot.data['meals'][0]['strMeasure1']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient2']!= null && snapshot.data['meals'][0]['strIngredient2']!= "") && (snapshot.data['meals'][0]['strMeasure2']!= null && snapshot.data['meals'][0]['strMeasure2']!= ""))  ? Text("2. "+snapshot.data['meals'][0]['strIngredient2'] + "( " +snapshot.data['meals'][0]['strMeasure2']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient3']!= null && snapshot.data['meals'][0]['strIngredient3']!= "") && (snapshot.data['meals'][0]['strMeasure3']!= null && snapshot.data['meals'][0]['strMeasure3']!= ""))  ? Text("3. "+snapshot.data['meals'][0]['strIngredient3'] + "( " +snapshot.data['meals'][0]['strMeasure3']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient4']!= null && snapshot.data['meals'][0]['strIngredient4']!= "") && (snapshot.data['meals'][0]['strMeasure4']!= null && snapshot.data['meals'][0]['strMeasure4']!= ""))  ? Text("4. "+snapshot.data['meals'][0]['strIngredient4'] + "( " +snapshot.data['meals'][0]['strMeasure4']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient5']!= null && snapshot.data['meals'][0]['strIngredient5']!= "") && (snapshot.data['meals'][0]['strMeasure5']!= null && snapshot.data['meals'][0]['strMeasure5']!= ""))  ? Text("5. "+snapshot.data['meals'][0]['strIngredient5'] + "( " +snapshot.data['meals'][0]['strMeasure5']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient6']!= null && snapshot.data['meals'][0]['strIngredient6']!= "") && (snapshot.data['meals'][0]['strMeasure6']!= null && snapshot.data['meals'][0]['strMeasure6']!= ""))  ? Text("6. "+snapshot.data['meals'][0]['strIngredient6'] + "( " +snapshot.data['meals'][0]['strMeasure6']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient7']!= null && snapshot.data['meals'][0]['strIngredient7']!= "") && (snapshot.data['meals'][0]['strMeasure7']!= null && snapshot.data['meals'][0]['strMeasure7']!= ""))  ? Text("7. "+snapshot.data['meals'][0]['strIngredient7'] + "( " +snapshot.data['meals'][0]['strMeasure7']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient8']!= null && snapshot.data['meals'][0]['strIngredient8']!= "") && (snapshot.data['meals'][0]['strMeasure8']!= null && snapshot.data['meals'][0]['strMeasure8']!= ""))  ? Text("8. "+snapshot.data['meals'][0]['strIngredient8'] + "( " +snapshot.data['meals'][0]['strMeasure8']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient9']!= null && snapshot.data['meals'][0]['strIngredient9']!= "") && (snapshot.data['meals'][0]['strMeasure9']!= null && snapshot.data['meals'][0]['strMeasure9']!= ""))  ? Text("9. "+snapshot.data['meals'][0]['strIngredient9'] + "( " +snapshot.data['meals'][0]['strMeasure9']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient10']!= null && snapshot.data['meals'][0]['strIngredient10']!= "") && (snapshot.data['meals'][0]['strMeasure10']!= null && snapshot.data['meals'][0]['strMeasure10']!= ""))  ? Text("10. "+snapshot.data['meals'][0]['strIngredient10'] + "( " +snapshot.data['meals'][0]['strMeasure10']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient11']!= null && snapshot.data['meals'][0]['strIngredient11']!= "") && (snapshot.data['meals'][0]['strMeasure11']!= null && snapshot.data['meals'][0]['strMeasure11']!= ""))  ? Text("11. "+snapshot.data['meals'][0]['strIngredient11'] + "( " +snapshot.data['meals'][0]['strMeasure11']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient12']!= null && snapshot.data['meals'][0]['strIngredient12']!= "") && (snapshot.data['meals'][0]['strMeasure12']!= null && snapshot.data['meals'][0]['strMeasure12']!= ""))  ? Text("12. "+snapshot.data['meals'][0]['strIngredient12'] + "( " +snapshot.data['meals'][0]['strMeasure12']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient13']!= null && snapshot.data['meals'][0]['strIngredient13']!= "") && (snapshot.data['meals'][0]['strMeasure13']!= null && snapshot.data['meals'][0]['strMeasure13']!= ""))  ? Text("13. "+snapshot.data['meals'][0]['strIngredient13'] + "( " +snapshot.data['meals'][0]['strMeasure13']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient14']!= null && snapshot.data['meals'][0]['strIngredient14']!= "") && (snapshot.data['meals'][0]['strMeasure14']!= null && snapshot.data['meals'][0]['strMeasure14']!= ""))  ? Text("14. "+snapshot.data['meals'][0]['strIngredient14'] + "( " +snapshot.data['meals'][0]['strMeasure14']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient15']!= null && snapshot.data['meals'][0]['strIngredient15']!= "") && (snapshot.data['meals'][0]['strMeasure15']!= null && snapshot.data['meals'][0]['strMeasure15']!= ""))  ? Text("15. "+snapshot.data['meals'][0]['strIngredient15'] + "( " +snapshot.data['meals'][0]['strMeasure15']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient16']!= null && snapshot.data['meals'][0]['strIngredient16']!= "") && (snapshot.data['meals'][0]['strMeasure16']!= null && snapshot.data['meals'][0]['strMeasure16']!= ""))  ? Text("16. "+snapshot.data['meals'][0]['strIngredient16'] + "( " +snapshot.data['meals'][0]['strMeasure16']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient17']!= null && snapshot.data['meals'][0]['strIngredient17']!= "") && (snapshot.data['meals'][0]['strMeasure17']!= null && snapshot.data['meals'][0]['strMeasure17']!= ""))  ? Text("17. "+snapshot.data['meals'][0]['strIngredient17'] + "( " +snapshot.data['meals'][0]['strMeasure17']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient18']!= null && snapshot.data['meals'][0]['strIngredient18']!= "") && (snapshot.data['meals'][0]['strMeasure18']!= null && snapshot.data['meals'][0]['strMeasure18']!= ""))  ? Text("18. "+snapshot.data['meals'][0]['strIngredient18'] + "( " +snapshot.data['meals'][0]['strMeasure18']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient19']!= null && snapshot.data['meals'][0]['strIngredient19']!= "") && (snapshot.data['meals'][0]['strMeasure19']!= null && snapshot.data['meals'][0]['strMeasure19']!= ""))  ? Text("19. "+snapshot.data['meals'][0]['strIngredient19'] + "( " +snapshot.data['meals'][0]['strMeasure19']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ((snapshot.data['meals'][0]['strIngredient120']!= null && snapshot.data['meals'][0]['strIngredient20']!= "") && (snapshot.data['meals'][0]['strMeasure20']!= null && snapshot.data['meals'][0]['strMeasure20']!= ""))  ? Text("20. "+snapshot.data['meals'][0]['strIngredient20'] + "( " +snapshot.data['meals'][0]['strMeasure20']+" )",
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text("Instructions",
                                              style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.0),
                                              width: 90.0,
                                              height: 1.0,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10.0),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data['meals'][0]['strInstructions'],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 14.0),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }


}

