import 'package:appwrite/appwrite.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class ClientService {
  late Client _client;
  late Storage _storage;
  late Functions _function;
  late Databases _databases;
  ClientService() {
    _client = Client()
        .setEndpoint(clientEndpoint)
        .setProject(appWriteProjectId)
        .addHeader('X-Appwrite-Key',
            '92f0000036a563e3de9271945e278f88bc7f13833d49a2f655e95ee15d0d991479039e5a0437d5ffae72c6f03a366926b1bad25deccaba22066683a26fd9b5beb932d294f1cab98565ade491eb0334c768bc89a6b77671b97e4af7cce36cd1e56936440f519d115808bf1b582adcca5e086d2c831e9ecfb6bbbd2a91318a727d'); // Your;
    _storage = Storage(getAppWriteClient);
    _function = Functions(_client);
    _databases = Databases(_client);
  }
  Client get getAppWriteClient => _client;

  Storage get getAppWriteStorage => _storage;

  Functions get getFunction => _function;

  Databases get getDatabase => _databases;
}
