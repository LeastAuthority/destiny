import 'package:dart_wormhole_william/client/native_client.dart';

import 'main.dart';

Future<void> main() async {
  final Config leastAuthority = Config(
    rendezvousUrl: "wss://mailbox.mw.leastauthority.com/v1",
    transitRelayUrl: "tcp://relay.mw.leastauthority.com:4001",
    appId: "lothar.com/wormhole/text-or-file-xfer",
  );
  startApp(leastAuthority);
}
