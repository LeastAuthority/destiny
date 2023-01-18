import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/constants/app_constants.dart';

import 'main.dart';

void main() {
  final Config stageLeastAuthority = Config(
    rendezvousUrl: "wss://mailbox.stage.mw.leastauthority.com/v1",
    transitRelayUrl: "tcp://relay.stage.mw.leastauthority.com:4001",
    appId: "lothar.com/wormhole/text-or-file-xfer",
  );
  startApp(stageLeastAuthority);
}
