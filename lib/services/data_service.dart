import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  // inisialisasi firebasefirestore
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');
  
  Future<QuerySnapshot> getData(){
    // getdata untuk masukin di history
    // untuk mendapatkan/membaca data dari database
    return dataCollection.get();
  } 

  Future<void> deleteData(String docID){
    // delete: method dari firebase
    // untuk menghapus data dari database
    return dataCollection.doc(docID).delete();
  }
}