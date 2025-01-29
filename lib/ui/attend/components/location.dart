import 'package:flutter/material.dart';

Padding buildLocationSection(bool isLoading, String address) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "data",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 5 * 24,
                  child: TextField(),
                ),
              )
      ],
    ),
  );
}
