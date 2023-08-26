import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/model.dart';

class ApiIntegration extends StatefulWidget {
  const ApiIntegration({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ApiIntegrationState createState() => _ApiIntegrationState();
}

class _ApiIntegrationState extends State<ApiIntegration> {
  List<Post>? posts;
  var isLoading = false;

  Future<List<Post>?> getPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://jsonplaceholder.typicode.com/users");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await getPost();
    if (posts != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 59, 209),
        centerTitle: true,
        title: const Text(
          'Fetch JSON data from API',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (contest, index) {
            return Card(
              color: Color.fromARGB(255, 183, 114, 240),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    myRow(
                      "Name",
                      (posts![index].name),
                    ),
                    myRow(
                      "Username",
                      (posts![index].username),
                    ),
                    myRow(
                      "email",
                      (posts![index].email),
                    ),
                    myRow("City", (posts![index].address.city))
                  ],
                ),
              ),
            );
          }),
    );
  }

  Row myRow(String name, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
