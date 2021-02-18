import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/model/todo.dart';
import 'package:my_app/model/category.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

/// API Service
class APIService {
  final _config = servicesLocator<ConfigurationService>();

  String _apiUrl;
  int _apiVersion;
  String _apiRootUrl;
  // initialize
  APIService() {
    _apiRootUrl = _config.apiRootUrl;
    _apiVersion = _config.apiVersion;
    _apiUrl = '$_apiRootUrl/api/v$_apiVersion';
  }

  /// url to request API
  String requestUrl(String endpoint) => '$_apiUrl$endpoint';

  /// データ整形
  /// parseCategories
  List<Category> parseCategories(String responseBody) {
    final data = json.decode(responseBody)['categories'];
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

    // final response = await http.get(url, headers: headers);
    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    return parseCategories(response.body);
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
