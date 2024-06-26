import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

void main() {
  runApp(const MaterialApp(
    home:
    // Directionality(
      // textDirection: TextDirection.rtl,
       MyApp(),
    // ),
  ));
}
class MyApp extends StatefulWidget{
  const MyApp({Key?key}):super(key:key);

  @override
  _MyAppState createState()=>_MyAppState();
}
class _MyAppState extends State<MyApp> {
 String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Portfolio',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.0,
            fontFamily: 'Roboto'
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children:[ Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.pink, width: 3),
                // ),
                child: Column(
                  children: [
                    Center(
                      child: ClipOval(
                        child: Image.network(
                          'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png',
                          fit: BoxFit.cover,
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                    ),
                    Text('SIDOP',style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.2
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1, // Reduce width for better aesthetics
                          ),
                        ),
                        hintText: 'What is Your Last Name',
                      ),
                      textAlign: TextAlign.left,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1, // Reduce width for better aesthetics
                          ),
                        ),
                        hintText: 'About me',
                      ),
                      textAlign: TextAlign.left,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                  ),
                ],
              ),

              Container(
                height: 40,
              ),
              Container(
                child: DropdownButton<String>(
                  value: _selectedGender,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey[700],fontSize: 15),
                 padding: EdgeInsets.all(10.0),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,

                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
              ),
              Container(
                height: 40,
              ),
              Container(
                child: const IntlPhoneField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 5))),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
              ),
              Container(
                height: 30,
              ),
             ElevatedButton(
                 onPressed: (){},
                 style: ElevatedButton.styleFrom(
                 foregroundColor: Colors.white,
                   backgroundColor: Colors.blue, // Text color
                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                 shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8),
                 ),
             ),
                 child: const Text('Submit'), // Button tex
               ),
            ],
          ),
        ),]
      ),
    );
  }
}
