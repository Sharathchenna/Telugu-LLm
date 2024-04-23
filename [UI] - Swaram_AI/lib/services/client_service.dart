import 'package:appwrite/appwrite.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class ClientService {
  Client? _client;
  Client? get getAppWriteClient => _client ??=
      Client().setEndpoint(clientEndpoint).setProject(appWriteProjectId);
}
