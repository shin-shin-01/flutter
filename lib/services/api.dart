import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/model/todo.dart';
import 'package:my_app/model/category.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/model/wish.dart';
import 'package:my_app/model/friend.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/data.dart';

/// API Service
class APIService {
  final _auth = servicesLocator<AuthService>();
  final _config = servicesLocator<ConfigurationService>();
  final _data = servicesLocator<DataService>();

  String _apiUrl;
  int _apiVersion;
  String _apiRootUrl;
  String _authorizationHeaderName;

  // initialize
  APIService() {
    _apiRootUrl = _config.apiRootUrl;
    _apiVersion = _config.apiVersion;
    _apiUrl = '$_apiRootUrl/api/v$_apiVersion';
    _authorizationHeaderName = _config.authorizationHeaderName;
  }

  /// url to request API
  String requestUrl(String endpoint) => '$_apiUrl$endpoint';

  /// HTTP Request Headers required to connect with API Server
  Future<Map<String, String>> authorizedHeader() async {
    final idToken = await _data.accessToken;
    return {_authorizationHeaderName: idToken};
  }

  /// HTTP Request Headers to send data to the API server
  Future<Map<String, String>> authorizedHeaderWithJson() async {
    var headers = await authorizedHeader();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    return headers;
  }

  /// データ整形
  User parseUsers(String responseBody) {
    final data = json.decode(responseBody)['user'];
    final user = User.fromJson(data);

    return user;
  }

  /// createUsers
  Future<void> createUser() async {
    final endpoint = '/users';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeaderWithJson();

    final user = await _data.getMe;

    final payload = jsonEncode({
      'user': {
        'name': user.name,
        'uid': user.uid,
        'picture_url': user.picture_url
      }
    });

    final response = await http.post(url, headers: headers, body: payload);

    /// TODO: error Handling
    await _data.saveUser(parseUsers(response.body));
  }

  /// createWishes
  Future<void> createWish(String name, int star, int category_id) async {
    final user = await _data.getMe;
    final uid = user.uid;

    final endpoint = '/users/$uid/wishes';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeaderWithJson();

    final payload = jsonEncode({
      'wish': {'name': name, 'star': star, 'category_id': category_id}
    });

    final response = await http.post(url, headers: headers, body: payload);
  }

  /// updateWish
  Future<void> updateWish(int id, bool deleted) async {
    final user = await _data.getMe;
    final uid = user.uid;

    final endpoint = '/users/$uid/wishes/$id';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeaderWithJson();

    final payload = jsonEncode({
      'wish': {'deleted': deleted}
    });

    final response = await http.put(url, headers: headers, body: payload);
  }

  /// データ整形
  /// parseCategories
  List<Category> parseCategories(String responseBody) {
    final data = json.decode(responseBody)['data'];
    final categories = data
        .map<Category>(
            (json) => Category.fromJson(json as Map<String, dynamic>))
        .toList() as List<Category>;
    return categories;
  }

  /// getCategories
  Future<List<Category>> getCategories() async {
    // if (!isReady) return null;
    final endpoint = '/categories';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeader();

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) return null;

    return parseCategories(response.body);
  }

  /// データ整形
  Map<String, List<Wish>> parseWishes(String responseBody) {
    final data = json.decode(responseBody)['data'];

    /// TODO: リファクタリング
    final Map<String, List<Wish>> wishes = new Map();
    data.forEach((key, value) {
      wishes[key] = value
          .map<Wish>((json) => Wish.fromJson(json as Map<String, dynamic>))
          .toList() as List<Wish>;
    });
    return wishes;
  }

  /// getWishes
  Future<Map<String, List<Wish>>> getWishes() async {
    final user = await _data.getMe;
    final uid = user.uid;

    final endpoint = '/users/$uid/wishes';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeader();

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) return null;

    return parseWishes(response.body);
  }

  /// データ整形
  Friend parseFriend(String responseBody) {
    final data = json.decode(responseBody)['data'];
    final friend = Friend.fromJson(data);
    return friend;
  }

  /// showUser
  Future<Friend> showUser(String accountId) async {
    final endpoint = '/users/$accountId';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeader();

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) return null;

    return parseFriend(response.body);
  }

  /// createFriend
  Future<Friend> createFriend(Friend friend) async {
    final user = await _data.getMe;
    final uid = user.uid;

    final endpoint = '/users/$uid/friends';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeaderWithJson();

    final payload = jsonEncode({
      'friend': {'friend_user_id': friend.id}
    });

    final response = await http.post(url, headers: headers, body: payload);

    /// 友人取得再実行
    await getFriends();
  }

  /// データ整形
  List<Friend> parseFriends(String responseBody) {
    final data = json.decode(responseBody)['data'];
    final friends = data
        .map<Friend>((json) => Friend.fromJson(json as Map<String, dynamic>))
        .toList() as List<Friend>;
    return friends;
  }

  /// getFriends
  Future<void> getFriends() async {
    final user = await _data.getMe;
    final uid = user.uid;

    final endpoint = '/users/$uid/friends';
    final url = requestUrl(endpoint);
    final headers = await authorizedHeader();

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) return null;

    List<Friend> friends = parseFriends(response.body);

    await _data.saveFriends(friends);
  }

  /// getTodos Fakefunction
  Future<List<Todo>> getTodos() async {
    final fakeTodo = Todo(id: 1, title: "firstTodo", detail: "firstTodoDetail");
    final fakeTodoSec =
        Todo(id: 2, title: "secondTodo", detail: "secondTodoDetail");

    final todos = [fakeTodo, fakeTodoSec];
    return todos;
  }
}
