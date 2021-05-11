
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './model/book.dart';


void main(){
  runApp(BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: Text('this is home'),

    );
  }
}

class BookFirebaseDemo extends StatefulWidget {
   BookFirebaseDemo() : super();

   final String appTitle = "Book DB";

  @override
  _BookFirebaseDemoState createState() => _BookFirebaseDemoState();
}

class _BookFirebaseDemoState extends State<BookFirebaseDemo> {

  TextEditingController bookNameController = TextEditingController();
  TextEditingController  bookAuthorController = TextEditingController();

  bool isEditiong = false;
  bool textFieldVisibility = false;


  String firestoreCollectionName = "books";

  Book currentBook;

  getAllBooks(){
    return Firestore.instance.collection(firestoreCollectionName).snapshots();
  }

  addBook() async {
    Book book = Book(bookName: bookNameController.text, authorName: bookAuthorController.text);
    try{
      Firestore.instance.runTransaction((Transaction transaction) async {
        await Firestore.instance
            .collection(firestoreCollectionName)
            .document()
            .setData(book.toJson());
      });
    }catch(e){
        print(e.toString());
    }
  }

  updateBook(Book book, String bookName, String authorName){

    try{

      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(book.documentReference, {'bookName':bookName, 'authorName': authorName});
      });

    }catch(e){
        print(e.toString());
    }
  }

  updateIfEditing(){
    if(isEditiong){
      updateBook(currentBook, bookNameController.text, bookAuthorController.text);
      setState(() {
        isEditiong = false;
      });
    }
  }

  deleteBook(Book book){
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(book.documentReference);
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}





















