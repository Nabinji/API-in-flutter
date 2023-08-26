import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/dropdown_model.dart';

class DropdownItemFromAPI extends StatefulWidget {
  const DropdownItemFromAPI({super.key});

  @override
  State<DropdownItemFromAPI> createState() => _DropdownItemFromAPIState();
}

class _DropdownItemFromAPIState extends State<DropdownItemFromAPI> {
  Future<List<DropdownItemsModel>> getPost() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              userId: map["userId"], id: map['id'], title: map["title"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dropdown Item From API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<DropdownItemsModel>>(
                future: getPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                        value: selectedValue,
                        dropdownColor: Colors.blue[100],
                        isExpanded: true,
                        hint: const Text("Select an item"),
                        items: snapshot.data!.map((e) {
                          return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.title
                                // Display the title in DropdownMenuItem
                                ),
                          );
                        }).toList(), // Change this to toList()
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        });
                  } else if (snapshot.hasError) {
                    // Add this block for error handling
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
