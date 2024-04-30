import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  final String name;
  final String imageUrl; // Added for image URL
  final String description; // Added for description
  bool isFavorite;

  Contact(this.name, this.imageUrl, this.description,
      {this.isFavorite = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos e Favoritos',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Contact> contacts = [
    Contact(
      'Subaru WRX 2015',
      'https://imgur.com/a/eZiceWQ',
      'Esportivo - Motor Boxer',
    ),
    Contact(
      'Subaru WRX 2011',
      'https://imgur.com/a/eZiceWQ',
      'Esportivo - Motor Boxer',
    ),
    Contact(
      'Subaru Forester 2024',
      'https://imgur.com/a/eZiceWQ',
      'SUV - Motor Boxer',
    ),
    Contact(
      'Subaru WRX Sti 2020',
      'https://imgur.com/a/eZiceWQ',
      'Super esportivo - Motor Boxer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Contacts & Favorites
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contatos e Favoritos'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Contatos'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contacts List Screen
            ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.imageUrl),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.description),
                  trailing: IconButton(
                    icon: Icon(
                      contact.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: contact.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        contact.isFavorite = !contact.isFavorite;
                      });
                    },
                  ),
                );
              },
            ),
            // Favorites List Screen
            ListView.builder(
              itemCount: contacts.where((contact) => contact.isFavorite).length,
              itemBuilder: (context, index) {
                final favoriteContact = contacts
                    .where((contact) => contact.isFavorite)
                    .toList()[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(favoriteContact.imageUrl),
                  ),
                  title: Text(favoriteContact.name),
                  subtitle: Text(favoriteContact.description),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
