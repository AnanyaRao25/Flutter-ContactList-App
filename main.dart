import 'package:flutter/material.dart';
//import 'package:contact_page/addContact/addContact.dart';
import 'package:contacts_service/contacts_service.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Contacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Contact> contacts=[];
  @override
  void initState() {
    super.initState();
    getContacts();
getPermissions();

  }
getPermissions() async {
 if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }
  getContacts() async{
   List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState((){
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
 bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
          backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context,index){
              Contact contact =contacts[index];
            return ListTile(
             title: Text(contact.displayName!),
            ),

            Expanded(
              child: ListView.builder(
 child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor
   shrinkWrap: true,
                itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];


                    )
                ),
              ),
            }
          )
          ],
        ),
      ),
    );
  }
}
