import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    data = data.isNotEmpty? data:ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDaytime'] ? 'sun.png' : 'moon.png';
    Color statusbar_color = data['isDaytime']
        ? Color(int.parse('0xFFED8C45'))
        : Color(int.parse('0xff09272F'));
    Color fcolor = data['isDaytime']
        ? Color(int.parse('0xff000000'))
        : Color(int.parse('0xFFFFFFFF'));

    return Scaffold(
      backgroundColor: statusbar_color,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/${bgImage}'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, size.height * 0.2, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: ()async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data={
                        'location':result['location'],
                        'time':result['time'],
                        'flag':result['flag'],
                        'isDaytime':result['isDaytime']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: fcolor,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: fcolor),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: fcolor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 20.0,
                    color: fcolor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
