import 'dart:convert';

import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/model/init_search/init_search.dart';
import 'package:card_crm/model/org_client/org_client.dart';
import 'package:card_crm/model/org_clients_with_next_page/org_clients_with_next_page.dart';
import 'package:card_crm/model/organization/organization.dart';
import 'package:card_crm/providers/initial_provider.dart';
import 'package:card_crm/providers/next_search_page_exist_provider.dart';
import 'package:card_crm/providers/secure_storage_provider.dart';
import 'package:card_crm/providers/server_connection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final apiProvider = Provider((ref) => Api(ref));

class Api {
  final Ref ref;
  const Api(this.ref);

  Future<bool> checkServer(String address, String port) async {
    try {
      await http.get(Uri.http('$address:$port'));
    } catch (e) {
      'ERROR: $e'.log();
      return false;
    }
    await _writeAdressPortToSecure(address, port);
    ref.read(serverProvider.notifier).state = Server(address, port);
    return true;
  }

  Future<bool> login(String login, String password) async {
    final server = ref.read(serverProvider);
    '${server.address}:${server.port}'.log();

    final resp = await http.post(
      Uri.http('${server.address}:${server.port}', '/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(AccessData(login, password).toJson()),
    );

    resp.body.log();

    if (resp.body == 'login') {
      await _writeLoginPassword(login, password);
      return true;
    }

    if (resp.body == 'уже авторизован') {
      return true;
    }

    return false;
  }

  Future<bool> logout() async {
    final secureStorage = ref.read(secureStorageProvider);
    final login = await secureStorage.read(key: "login") ?? "";

    if (login.isEmpty) {
      login.log();
      throw 'No login';
    }

    final server = ref.read(serverProvider);
    final resp = await http.post(
      Uri.http('${server.address}:${server.port}', '/logout', {'login': login}),
    );
    if (resp.body == "logout") {
      await _writeLoginPassword("", "");
      return true;
    }

    return false;
  }

  Future<List<Organization>> getOrganization() async {
    final secureStorage = ref.read(secureStorageProvider);
    final login = await secureStorage.read(key: "login") ?? "";
    if (login.isEmpty) {
      throw 'No login';
    }

    final server = ref.read(serverProvider);
    final resp = await http.get(
      Uri.http('${server.address}:${server.port}', '/organizations',
          {'login': login}),
    );
    resp.body.log();

    List<dynamic> jsonList = json.decode(resp.body) as List;
    List<Organization> organization =
        jsonList.map((e) => Organization.fromJson(e)).toList();

    return organization;
  }

  Future<List<OrgClient>> initSearch(
    InitSearch search,
  ) async {
    final secureStorage = ref.read(secureStorageProvider);
    final login = await secureStorage.read(key: "login") ?? "";
    if (login.isEmpty) {
      throw 'No login';
    }

    if (search.search == '') {
      return [];
    }

    final server = ref.read(serverProvider);

    final resp = await http.post(
      Uri.http(
        '${server.address}:${server.port}',
        '/search',
        {'login': login},
      ),
      headers: {"Content-Type": "application/json"},
      body: json.encode(search),
    );

    final orgCientsWithNextpage =
        OrgClientWithNextPage.fromJson(json.decode(resp.body));

    orgCientsWithNextpage.log();

    ref.read(nextSearchPageExistProvider.notifier).state =
        orgCientsWithNextpage.nextPageExist;

    final orgClients = orgCientsWithNextpage.orgClients;
    return orgClients;
  }

  Future<List<OrgClient>> searchPage(
    int pageNumber,
  ) async {
    pageNumber.log();

    final secureStorage = ref.read(secureStorageProvider);
    final login = await secureStorage.read(key: "login") ?? "";
    if (login.isEmpty) {
      throw 'No login';
    }

    final server = ref.read(serverProvider);

    final resp = await http.post(
      Uri.http(
        '${server.address}:${server.port}',
        '/search_page',
        {'login': login, 'page_number': pageNumber.toString()},
      ),
    );

    final orgCientsWithNextpage =
        OrgClientWithNextPage.fromJson(json.decode(resp.body));

    ref.read(nextSearchPageExistProvider.notifier).state =
        orgCientsWithNextpage.nextPageExist;

    final orgClients = orgCientsWithNextpage.orgClients;

    return orgClients;
  }

  Future<void> _writeAdressPortToSecure(address, port) async {
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(key: "address", value: address);
    await secureStorage.write(key: "port", value: port);
  }

  Future<void> _writeLoginPassword(login, password) async {
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(key: "login", value: login);
    await secureStorage.write(key: "password", value: password);
  }
}
