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
  var allusers = [];
  var items = List();

  @override
  void initState() {
    super.initState();
    dbmgr = new DBManager();
    
    dbmgr.allusers().then((users) {
      setState(() {
        allusers = users;
        items = allusers;
      });
    });
  }

  void filter(String chaine) async {
    var list1 = allusers;
    if (chaine.isNotEmpty) {
      var list2 = List();
      list1.forEach((item) {
        var course = User.fromMap(item);
        if (course.name.toLowerCase().contains(chaine.toLowerCase())) {
          list2.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(list2);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allusers;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl = TextEditingController();
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text("Users List"), actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Add()))
                        .then((value) => setState(() {
                          dbmgr.allusers().then((users) {
         setState(() {
            allusers=users;
            items = allusers;
            
          });
    
   
        });
     //  FocusManager.instance.primaryFocus.unfocus();
    
                        }));
                  })
            ]),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    //controller: ctrl,
                onChanged: (value) {
                  setState(() {
                    filter(value);
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search...',
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, position) {
                    User x = User.fromMap(items[position]);
                    return ListTile(
                      title: Text(items[position]['name']),
                      subtitle: Text(items[position]['email']),
                      isThreeLine: true,
                      leading: Icon(
                        Icons.person,
                        size: 40,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => Details.other(x)))
                            .then((value) => setState(() {
                                  dbmgr.allusers().then((users) {
                                    setState(() {
                                      allusers = users;
                                      items = allusers;
                                    });
                                  });
                                }));
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            dbmgr.deleteuser(items[position]['id']);
                            dbmgr.allusers().then((users) {
                              setState(() {
                                allusers = users;
                                items = allusers;
                              });
                            });
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            // Text(allusers.length.toString())
          ],
        ));
  }
}
