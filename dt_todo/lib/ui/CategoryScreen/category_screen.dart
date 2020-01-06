import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/provider/category_provider.dart';
import 'package:dt_todo/ui/CategoryScreen/category_list.dart';
import 'package:dt_todo/ui/custom/CategoryBox.dart';
import 'package:dt_todo/ui/custom/EditCategory.dart';
import 'package:dt_todo/ui/loginScreen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:async/async.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'notelist_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

/*  static List categorySmartList;
  static List categoryList;

  Future future;
  int _newIndex;
  Function reloadCategoryList;

  Future getCategories() async {
    return await CategoryBloc().getSmartCategoriesByUsername(UserModel().username);
  }

  Future loadCategories() async {
    print('future');
    categorySmartList =
    await CategoryBloc().getSmartCategoriesByUsername(UserModel().username);
    categoryList =
    await CategoryBloc().getCategoriesByUsername(UserModel().username);
  }


  Future loadNoteInCategory() async {
    //TODO: load notes
  }

  void _reloadCategories() =>
      setState(() {
        future = loadCategories();
      });


  //TODO: Load list category theo user đăng nhập
  @override void initState() {
    // TODO: implement initState
    super.initState();
    final doc = DBHelper('categories');
*/ /*    doc.ref.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        print('document changes ${change.document.data}');
      });
    });*/ /*
    //future = loadCategories();
    //future = getCategories();
    reloadCategoryList = _reloadCategories;
    print('init state category screen');
  }*/
  static List listCategories;

  @override
  Widget build(BuildContext context) {
/*    CategoryBloc().getLastIndex(UserModel().username).then((value) {
      _newIndex = value + 1;
    });*/
    return Scaffold(
      appBar: AppBar(
        //shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
             )
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            child: Container(
                color: Colors.blue[50], height: 4.0
            ),
            preferredSize: Size.fromHeight(4.0)
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                //backgroundImage: AssetImage('assets/person.png'),
                //backgroundColor: Colors.white,
                maxRadius: 16,
              ),
              SizedBox(width: 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15),
                  Text(UserModel().username, style: TextStyle(
                      fontSize: 18),),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: _signOut,
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
          child: StreamBuilder(
              stream: CategoryBloc().fetchCategoriesAsStream(
                  UserModel().username),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(child: Text("Không có kết nối mạng"));
                  case ConnectionState.waiting:
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError)
                      return Center(child: Text("Lỗi kết nối"));
                    else {
                      listCategories = snapshot.data.documents.
                      map((doc) => CategoryModel.fromMap(doc.data, doc.documentID)).toList();

                      return Container(
                          color: Colors.grey[50],
                          child: ListCategories(listCategories: listCategories));
                    }
                }
              }
          )
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(
                //settings: RouteSettings(name: 'notelist_screen'),
                builder: (context) => new NoteListScreen(category: null)));
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return EditDialog(category: null);
                }
            );
            /*    CategoryBloc().insertCategory(CategoryModel(
                icon: 'new_list',
                color: Colors.white,
                name: 'Untitled list $_newIndex',
                numOfNotes: 0,
                isSmartList: false,
                index: _newIndex));*/
          },
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.blue[100],
                border: Border.all(
                width: 010.0,
                  color: Colors.white,
            )
            ),
            padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.add, color: Colors.blueAccent),
                SizedBox(width: 20),
                Text('New list', style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                )),
              ],
            ),
          )
      ),
    );
  }

  /*  return FutureBuilder(
      future: getCategories(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: Text("Không có kết nối mạng"));
          case ConnectionState.waiting:
            return Center(
              child: new CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text("Lỗi kết nối"));
            }
            else
              return Scaffold(
                appBar: AppBar(
                  //shadow
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                      child: Container(
                          color: Colors.grey[200], height: 4.0
                      ),
                      preferredSize: Size.fromHeight(4.0)
                  ),
                  title: Container(
                    padding: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(UserModel().avatar),
                          //backgroundColor: Colors.white,
                          maxRadius: 18,
                        ),
                        SizedBox(width: 3),
                        Column(
                          children: <Widget>[
                            SizedBox(height: 15),
                            Text(UserModel().username, style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: _printHello,
                        )
                      ],
                    ),
                  ),
                ),
                body: ListCategories(listCategories: snapshot.data),
                */ /*SingleChildScrollView(
                  child: Container(
                    //padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                    color: Colors.grey[200],
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: categorySmartList.map((category) => CategoryBox(category: category)).toList(),
                        ),
                        Divider(indent: 15, height: 15, endIndent: 5, thickness: 1.5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: categoryList.map((category) => CategoryBox(category: category)).toList(),
                        )
                      ],
                    ),
                  ),
                ),*/ /*
                bottomNavigationBar: GestureDetector(
                  onTap: () async {
                    CategoryBloc().insertCategory(CategoryModel(icon: 'new_list', color: Colors.white, name: 'Untitled list $_newIndex', numOfNotes: 0, isSmartList: false, index: _newIndex));
                    final doc = DBHelper('categories');
                    final response = await doc.ref.where('username', isEqualTo: UserModel().username).where('index', isEqualTo: _newIndex).limit(1).getDocuments();
                    if (response.documents.isEmpty) return null;
                    final json = response.documents.elementAt(0);
                    final category = CategoryModel.fromMap(json.data, json.documentID);
                    setState(() {
                      //categoryList.add(category);
                    });
                  },
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.blueAccent),
                        SizedBox(width: 20),
                        Text('New list', style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        )),
                      ],
                    ),
                  ),
                ),
              );
        }
      }
    );
  */

  void _signOut() async {
    final _auth = FirebaseAuth.instance;
    try{
      await _auth.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }catch(e) {
      print(e);
      return null;
    }
  }
}