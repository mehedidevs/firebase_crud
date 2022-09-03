import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name, email, bGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Data Form "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Please Input Your Data...",
                style: TextStyle(fontSize: 21.0, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Write Your Name ",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                  ),
                ),
                onChanged: (name) {
                  print(name);
                  getName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Write Your email ",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                  ),
                ),
                onChanged: (email) {
                  getEmail(email);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Write Your Blood Group ",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                  ),
                ),
                onChanged: (blood) {
                  getBloodGroup(blood);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      onPressed: () {
                        writeToDataBase();
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.green),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      onPressed: () {
                        readData();
                      },
                      child: Text("Read", style: TextStyle(color: Colors.black))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      onPressed: () {
                        dataUpdateToDatabase();
                      },
                      child:
                          Text("Update", style: TextStyle(color: Colors.blue))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      onPressed: () {
                        deleteData();
                      },
                      child: Text("Delete", style: TextStyle(color: Colors.red))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getName(String name) {
    this.name = name;
    print(name);
  }

  void getEmail(String email) {
    print(email);
    this.email = email;
  }

  void getBloodGroup(String blood) {
    print(blood);
    this.bGroup = blood;
  }

  void writeToDataBase() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Student").doc(name);

    Map<String, dynamic> infoMap = {
      "name": name,
      "email": email,
      "bGroup": bGroup
    };

    documentReference
        .set(infoMap)
        .then((value) => print("inserted"))
        .onError((error, stackTrace) => print("error : " + error.toString()));
  }

  void readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Student").doc(name);

    documentReference.get().then((value) {
      print("My Name is : " + value.get("name"));
      print("My Email is : " + value.get("email"));
      print("My Blood Group is : " + value.get("bGroup"));
    });
  }

  void dataUpdateToDatabase() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Student").doc(name);

    Map<String, dynamic> infoMap = {
      "name": name,
      "email": email,
      "bGroup": bGroup
    };

    documentReference
        .update(infoMap)
        .then((value) => print("inserted"))
        .onError((error, stackTrace) => print("error : " + error.toString()));
  }

  void deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Student").doc(name);

    documentReference
        .delete()
        .then((value) => print("deleted"))
        .onError((error, stackTrace) => print("Error : " + error));
  }
}
