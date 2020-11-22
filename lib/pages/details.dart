import 'package:crudapp/models/dbmanager.dart';
import 'package:crudapp/models/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  User user;
  Details.other(this.user);
  Details();

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DBManager dbmgr;
  int id;
  @override
  void initState() {
    super.initState();
    dbmgr = new DBManager();
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    phoneController.text = widget.user.phone;
    nameController.addListener(_printLatestValue);
    emailController.addListener(_printLatestValue);
    phoneController.addListener(_printLatestValue);
    id = widget.user.id;
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  _printLatestValue() {
    print("Second text field: ${nameController.text}");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final toul = MediaQuery.of(context).size.height;
    final orth = MediaQuery.of(context).size.width;
    User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("User Details"),
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
                        color: Colors.green[700],
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
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      user.name = value;
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
                                  controller: emailController,
                                  // initialValue: user.email,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      user.email = value;
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
                                  controller: phoneController,
                                  //  initialValue: user.phone,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      user.phone = value;
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
                                  color: Colors.green[700],
                                  border: Border.all(
                                      width: 1, color: Colors.green[700]),
                                  borderRadius: BorderRadius.circular(70),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.green[700])
                                  ]),
                              child: FlatButton(
                                child: Text("Edit User",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                onPressed: () async {
                                  if (nameController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      phoneController.text.isEmpty) {
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
                                    User x = User({
                                      'name': nameController.text,
                                      'email': emailController.text,
                                      'phone': phoneController.text,
                                      'id': id
                                    });
                                    dbmgr.updateuser(x);

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
