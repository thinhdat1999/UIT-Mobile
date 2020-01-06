import 'package:dt_todo/blocs/category_blocs.dart';
import 'package:dt_todo/helper/DBHelper.dart';
import 'package:dt_todo/helper/IconHelper.dart';
import 'package:dt_todo/models/category_model.dart';
import 'package:dt_todo/models/user_model.dart';
import 'package:dt_todo/ui/CategoryScreen/notelist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class EditDialog extends StatefulWidget {
  CategoryModel category;
  EditDialog({this.category});

  @override
  __DialogState createState() => __DialogState();
}

class __DialogState extends State<EditDialog> {
  bool isClickIcon = false;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  Choice _curIcon;
  bool isEnable;
  FocusNode focusTextfield;
  TextEditingController textController;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    focusTextfield = FocusNode();
    textController = TextEditingController(text: widget.category == null ? null : widget.category.name);
    isEnable = textController.text.isEmpty ? false : true;
    _curIcon = widget.category == null ? null : Choice(title: widget.category.icon, icon: IconHelper().getIconByName(widget.category.icon), color: widget.category.color);
  }

  void changeColor(Color color) {
    setState(() => {
      pickerColor = color,
    }
    );
  }

  void iconPicker(){
    setState(() {
      isClickIcon = !isClickIcon;
    });
  }

  Widget build(BuildContext context) {

    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.category == null ?
                    'New list' : 'Rename List',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                new AnimatedContainer(
                  duration: Duration(seconds: 1),
                  // Provide an optional curve to make the animation feel smoother.
                  curve: Curves.fastOutSlowIn,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        color: Colors.grey,
                        icon: _curIcon == null ? Icon(Icons.add_a_photo) : Icon(_curIcon.icon, color: _curIcon.color),
                        onPressed: () async {
                          focusTextfield.unfocus();
                          Future.delayed(Duration(milliseconds: 200), () => iconPicker());
                          //iconPicker();
                        },
                      ),
                      new Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: TextFormField(
                            controller: textController,
                            onTap: () {
                              setState(() {
                                isClickIcon = false;
                              });
                            },
                            focusNode: focusTextfield,
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Enter list title',
                                border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1,
                                  )
                                )
                            ),
                            //initialValue: widget.category == null ? null : widget.category.name,
                            validator: (val) => val.isEmpty ? 'Enter list title' : null,
                            onChanged: (val) {
                              if(val.isNotEmpty) {
                                setState(() {
                                  isEnable = true;
                                });
                              }
                              else {
                                setState(() {
                                  isEnable = false;
                                });
                              }
                            },
                          )
                      )
                    ],
                  ),
                ),
                isClickIcon ? AnimatedContainer(
                    height: 200.0,
                    color: Colors.grey,
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: GridView.count(
                        crossAxisCount: 5,
                        children: List.generate(30, (index){
                          return InkResponse(
                            child: ChoiceCard(choice: choices[index],),
                            onTap: () {
                              setState(() {
                                _curIcon = choices[index];
                              });
                            },
                          );
                        })
                    )
                ):Container(),
                SizedBox(height: 5),
                /*Ink(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.color_lens),
                    color: pickerColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.white,
                              child: const Text('OK'),
                              onPressed: () {
                                setState(() => currentColor = pickerColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),*/
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        if(widget.category == null) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        else {
                          Navigator.pop(context);
                        }
                      } ,
                      child: Text('CANCEL'),
                    ),
                    FlatButton(
                      onPressed: !isEnable ? null : widget.category == null ? _addCategory : _renameCategory,
                      child: widget.category == null ? Text('CREATE LIST') : Text('SAVE'),

                    ),
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }

  void _renameCategory() async {
    widget.category.name = textController.text;
    widget.category.icon = _curIcon.title;
    widget.category.color = _curIcon.color;
    await CategoryBloc().updateCategory(widget.category);
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoteListScreen(category: widget.category)));
  }
  void _addCategory() async {
    if(widget.category == null) {
      int index = 0;
      await CategoryBloc().getLastIndex(UserModel().username).then((value) {
        index = value + 1 ;
      });
      CategoryBloc().insertCategory(new CategoryModel(icon: _curIcon == null ? 'new_list' : _curIcon.title, color: _curIcon == null ? Colors.black : _curIcon.color, name: textController.text, numOfNotes: 0, isSmartList: false, index: index));

      final doc = DBHelper('categories');
      final response = await doc.ref.where('username', isEqualTo: UserModel().username).where('index', isEqualTo: index).limit(1).getDocuments();
      if (response.documents.isEmpty) return null;
      final json = response.documents.elementAt(0);
      final newCategory = CategoryModel.fromMap(json.data, json.documentID);

      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new NoteListScreen(category: newCategory)));
    }
  }
}

class Choice {
  const Choice({this.title, this.icon, this.color});

  final String title;
  final IconData icon;
  final Color color;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car, color: Colors.deepPurple),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike, color: Colors.blueAccent),
  const Choice(title: 'Boat', icon: Icons.directions_boat,color: Colors.lightBlueAccent),
  const Choice(title: 'Bus', icon: Icons.directions_bus,color: Colors.grey),
  const Choice(title: 'Train', icon: Icons.directions_railway,color: Colors.brown),
  const Choice(title: 'Walk', icon: Icons.directions_walk,color: Colors.deepOrangeAccent),
  const Choice(title: 'Work', icon: Icons.work,color: Colors.green),
  const Choice(title: 'Grocery', icon: Icons.local_grocery_store,color: Colors.pinkAccent),
  const Choice(title: 'Photo', icon: Icons.add_photo_alternate,color: Colors.blue),
  const Choice(title: 'Book', icon: Icons.book,color: Colors.brown),
  const Choice(title: 'Plane', icon: Icons.airplanemode_active,color: Colors.indigo),
  const Choice(title: 'Baby', icon: Icons.child_care,color: Colors.pinkAccent),
  const Choice(title: 'Birthday', icon: Icons.cake,color: Colors.amberAccent),
  const Choice(title: 'Alarm', icon: Icons.alarm,color: Colors.red),
  const Choice(title: 'Bank', icon: Icons.account_balance,color: Colors.indigo),
  const Choice(title: 'Sun', icon: Icons.brightness_high,color: Colors.amber),
  const Choice(title: 'Happy', icon: Icons.mood,color: Colors.amberAccent),
  const Choice(title: 'Moon', icon: Icons.brightness_2,color: Colors.amber),
  const Choice(title: 'Weather', icon: Icons.cloud, color: Colors.lightBlueAccent),
  const Choice(title: 'Mail', icon: Icons.mail, color: Colors.orange),
  const Choice(title: 'Event', icon: Icons.event_available, color: Colors.green),
  const Choice(title: 'Heart', icon: Icons.favorite, color: Colors.red),
  const Choice(title: 'Snow', icon: Icons.ac_unit, color: Colors.lightBlueAccent),
  const Choice(title: 'Cancel', icon: Icons.cancel, color: Colors.red),
  const Choice(title: 'Check', icon: Icons.check, color: Colors.green),
  const Choice(title: 'Announcement', icon: Icons.announcement, color: Colors.yellow),
  const Choice(title: 'Money', icon: Icons.attach_money, color: Colors.yellowAccent),
  const Choice(title: 'Message', icon: Icons.chat, color: Colors.amber),
  const Choice(title: 'Travel', icon: Icons.edit_location, color: Colors.red),
  const Choice(title: 'FastFood', icon: Icons.fastfood, color: Colors.amber),
  const Choice(title: 'Coffee', icon: Icons.free_breakfast, color: Colors.brown),
  const Choice(title: 'Bus', icon: Icons.music_note, color: Colors.purpleAccent),
  const Choice(title: 'Dining', icon: Icons.local_dining, color: Colors.red),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.white,
        child: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:
                     Icon(
                      choice.icon,
                      color: choice.color,
                    )
                ),

            ]
        ),
        )
    );
  }
}
