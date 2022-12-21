import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/views/shared/file_picker.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppSettings {
  static const MAILBOX_URL = "mailbox_url";
  static const TRANSIT_RELAY_URL = "transit_relay_url";
  static const APP_ID = "app_id";
  static const PASSPHRASE_COMPONENT_LENGTH = "passphrase_component_length";
  static const PATH = "path";

  final StreamingSharedPreferences preferences;

  final Preference<String> mailboxUrl;
  final Preference<String> transitRelayUrl;
  final Preference<String> appId;
  final Preference<int> passphraseComponentLength;
  final Preference<String> folder;

  Config config() {
    var config = Config(
        appId: appId.getValue(),
        rendezvousUrl: mailboxUrl.getValue(),
        transitRelayUrl: transitRelayUrl.getValue(),
        passPhraseComponentLength: passphraseComponentLength.getValue());
    return config;
  }

  AppSettings(this.preferences, Config defaults, PathConfig pathConfig)
      : this.mailboxUrl = preferences.getString(MAILBOX_URL,
            defaultValue: defaults.rendezvousUrl),
        this.transitRelayUrl = preferences.getString(TRANSIT_RELAY_URL,
            defaultValue: defaults.transitRelayUrl),
        this.appId =
            preferences.getString(APP_ID, defaultValue: defaults.appId),
        this.passphraseComponentLength = preferences.getInt(
            PASSPHRASE_COMPONENT_LENGTH,
            defaultValue: defaults.passPhraseComponentLength),
        this.folder =
            preferences.getString(PATH, defaultValue: pathConfig.downloadPath);
}
