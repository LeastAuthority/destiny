import 'package:dart_wormhole_william/client/native_client.dart';

import 'constants/app_constants.dart';
import 'main.dart';

void main() {
  final Config local = Config(
      rendezvousUrl: "ws://localhost:4000/v1",
      transitRelayUrl: "tcp://localhost:4001");

  startApp(local);
}
