import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditListPopup extends StatefulWidget {
  @override
  _EditListPopupState createState() => _EditListPopupState();
}

class _EditListPopupState extends State<EditListPopup> {
  IconData _curIcon = null;
  bool _isEditIcon = false;
  bool _isChangeColorTheme = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text('Edit list'),
          ),
          //SizedBox(height: 5),
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: IconButton(
                    icon: (_curIcon == null) ? Icon(Icons.tag_faces) : Icon(_curIcon),
                    onPressed: _addIconList,
                  )
                ),
                Padding(
                  padding:EdgeInsets.all(10),
                  child: Text('Name here'),
                )
              ],
            )
          ),
          SizedBox(height: 18),
          if(_isEditIcon) Padding(
            padding: EdgeInsets.all(10),
            child: IconList(
              onPress: _choiceIcon,
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('Color'),
                onPressed: _openListColorTheme,
              ),
              SizedBox(width: 10),
              RaisedButton(
                child: Text('Image'),
                onPressed: _openListImageTheme,
              )
            ],
          ),
          _isChangeColorTheme ? Row(
            children: <Widget>[
              RaisedButton(
                child: Text('color1'),
              ),
              RaisedButton(
                child: Text('color2')
              )
            ],
          ) : Row(
            children: <Widget>[
              Icon(Icons.account_balance),
              Icon(Icons.airline_seat_individual_suite)
            ],
          )
        ],
      ),
    );
  }

  void _addIconList() {
    setState(() {
      _isEditIcon = !_isEditIcon;
    });
  }

  void _choiceIcon(IconData _icon) {
    setState(() {
      _curIcon = _icon;
    });
  }
  void _openListColorTheme() {
    setState(() {
      _isChangeColorTheme = true;
    });
  }

  void _openListImageTheme() {
    setState(() {
      _isChangeColorTheme = false;
    });
  }
}

class IconList extends StatelessWidget {
  final Function(IconData _icon) onPress;

  IconList({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(child: Icon(Icons.home),
              onTap: () => onPress(Icons.home)
              ),
              GestureDetector(child: Icon(Icons.audiotrack),
              onTap: () => onPress(Icons.audiotrack)
              ),
              GestureDetector(child: Icon(Icons.videogame_asset),
                  onTap: () => onPress(Icons.videogame_asset)
              ),
              GestureDetector(child: Icon(Icons.local_grocery_store),
                  onTap: () => onPress(Icons.local_grocery_store)
              ),
              GestureDetector(child: Icon(Icons.fastfood),
                  onTap: () => onPress(Icons.fastfood)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.directions_car),
              Icon(Icons.movie),
              Icon(Icons.flight),
              Icon(Icons.content_paste),
              Icon(Icons.local_drink)
            ],
          )
        ],
      )
    );
  }
}

