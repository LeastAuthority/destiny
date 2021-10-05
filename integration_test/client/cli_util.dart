import 'dart:io';
import 'package:path/path.dart' as path;

final wormholeWilliamPath = path.join('.', 'dart_wormhole_william', 'wormhole-william');

String recvTextGo(String code) {
  final res = Process.runSync('go', [
    'run', '.',
    'receive',
    code,
  ],
    workingDirectory: wormholeWilliamPath,
  );
  return res.stdout.toString().trimRight();
}

String sendTextGo(String text) {
  // TODO: read code from stdout (?)
  const code = "7-guitarist-revenge";
  final res = Process.run('go', [
    'run', '.',
    'send',
    '--code', code,
    '--text', text,
  ],
    workingDirectory: wormholeWilliamPath,
  );
  res.then((_res) {
    print(_res.stdout);
  });
  // TODO: something more robust!
  sleep(Duration(seconds: 3));
  return code;
}