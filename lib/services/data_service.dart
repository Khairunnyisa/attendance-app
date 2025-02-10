import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  // inisialisasi firebasefirestore
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');
  
  Future<QuerySnapshot> getData(){
    // getdata untuk masukin di history
    return dataCollection.get();
  } 

  Future<void> deleteData(String docID){
    return dataCollection.doc(docID).delete();
  }
}