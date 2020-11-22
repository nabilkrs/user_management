import 'package:crudapp/models/dbmanager.dart';
import 'package:crudapp/models/user.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String name = "", email = "", phone = "";
  DBManager dbmgr;
  @override
  void initState() {
    super.initState();
    dbmgr = new DBManager();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final toul = MediaQuery.of(context).size.height;
    final orth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Add User"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: toul - 150,
                width: orth,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                    color: Color(0xFF303030),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.purple,
                      )
                    ]),
              ),
              Positioned(
                  top: 50,
                  left: 30,
                  child: Container(
                      height: 390,
                      width: 260,
                      decoration: BoxDecoration(),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      phone = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 260,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border:
                                    Border.all(width: 1, color: Colors.purple),
                                borderRadius: BorderRadius.circular(70),
                                boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.purple)
                                  ]
                              ),
                              child: FlatButton(
                                child: Text("Add User",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                onPressed: () async {
                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      phone.isEmpty) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(new SnackBar(
                                      content: Row(children: [
                                        Icon(Icons.error),
                                        SizedBox(width: 20),
                                        Text("All Fields are required")
                                      ]),
                                      backgroundColor: Colors.redAccent[700],
                                      duration: Duration(seconds: 4),
                                    ));
                                  } else {
                                    User user = User({
                                      'name': name,
                                      'email': email,
                                      'phone': phone
                                    });
                                    int id = await dbmgr.adduser(user);

                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }
}
