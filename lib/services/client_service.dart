import 'package:appwrite/appwrite.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class ClientService {
  late Client _client;
  late Storage _storage;
  ClientService() {
    _client =
        Client().setEndpoint(clientEndpoint).setProject(appWriteProjectId);
    _storage = Storage(getAppWriteClient);
  }
  Client get getAppWriteClient => _client;

  Storage get getAppWriteStorage => _storage;
}
