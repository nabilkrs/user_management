

import 'package:crudapp/models/dbmanager.dart';
import 'package:crudapp/models/user.dart';
import 'package:crudapp/pages/details.dart';
import 'package:flutter/material.dart';

import 'Add.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBManager dbmgr;
  @override
  void initState() {
    super.initState();
    dbmgr = new DBManager();
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Users List"), actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Add()))
                  .then((value) => setState(() {}));
            })
      ]),
      body: FutureBuilder(
        future: dbmgr.allusers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, position) {
                User x = User.fromMap(snapshot.data[position]);
                return ListTile(
                  title: Text(snapshot.data[position]['name']),
                  subtitle: Text(snapshot.data[position]['email']),
                  isThreeLine: true,
                  leading: Icon(
                    Icons.person,
                    size: 40,
                  ),
                  /*  onTap: (){
                    _scaffoldKey.currentState.showSnackBar(SnackBar(  
                     content: Row(children: [
                       Icon(Icons.phone),
                       SizedBox(width:20),
                       Text("Phone Number : "+snapshot.data[position]['phone'])

                     ]),
                     duration: Duration(seconds: 4),));
                  },*/
                  onTap: () {
                    
                  //  Navigator.push(context,MaterialPageRoute(builder:(context)=>Details.other(x)));
                 // Navigator.pushNamed(context, '/details',arguments: x);
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details.other(x))).then((value) => setState(() {}));
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        dbmgr.deleteuser(snapshot.data[position]['id']);
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
