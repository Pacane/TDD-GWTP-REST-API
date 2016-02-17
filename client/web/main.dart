// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'dart:async';

Client client = new BrowserClient();

void main() {
  ButtonElement queryButton = querySelector('#queryButton');
  queryButton.onClick.listen((MouseEvent e) => fetchSomething());

  querySelector('#output').text = 'Your Dart app is running.';
}

Future fetchSomething() async {
//  var response = client
//      .get('http://localhost:8082')
//      .catchError((e) => print("errorr!!"))
//      .then((response) => print('status code ${response.statusCode}'));

  runZoned(() async {
    try {
      var response = await client.get('http://localhost:8082');
      print('status code ${response.statusCode}');
    } catch (e) {
      print("Hellooooo");
    }
  }, onError: (e, s) {
    print("Uncaught error");
  });
}
