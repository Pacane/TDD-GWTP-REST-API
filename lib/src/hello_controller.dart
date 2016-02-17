part of rest_api;

class User {
  int id;
  String name;

  Map toJson() {
    var json = {};
    json['id'] = id;
    json['name'] = name;

    return json;
  }
}

List<User> users = [
  new User()
    ..id = 1
    ..name = 'joel',
  new User()
    ..id = 2
    ..name = 'olivier'
];

@app.Route("/api/users", responseType: 'application/json')
List<Map> getUsers() {
  return users.map((User u) => u.toJson()).toList();
}

@app.Route("/api/users/:id", responseType: 'application/json')
Map getUser(int id) {
  return users.singleWhere((User u) => u.id == id).toJson();
}

@app.Route("/api/users/:id",
    methods: const [app.DELETE], responseType: 'application/json')
List<Map> deleteUser(int id) {
  users.removeWhere((User u) => u.id == id);
  return users.map((User u) => u.toJson()).toList();
}

@app.Route("/api/users/:id",
    methods: const [app.PUT], responseType: 'application/json')
Map updateUser(int id, @app.Body(app.JSON) Map json) {
  users.removeWhere((User u) => u.id == id);

  var user = new User()
    ..id = id
    ..name = json['name'];

  users.add(user);

  return user.toJson();
}

@app.Interceptor(r'/.*')
handleCORS() async {
  if (app.request.method != "OPTIONS") {
    await app.chain.next();
  }

  return app.response.change(headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "X-GWT-Module-Base,Content-Type",
    "Access-Control-Allow-Methods": "POST,PUT,GET,DELETE,OPTIONS"
  });
}
