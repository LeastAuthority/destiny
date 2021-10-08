import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

final wormholeWilliamPath = path.join('.', 'dart_wormhole_william', 'wormhole-william');
final testFileSrcDir = path.join('.', 'integration_test', 'client', 'test_files');
final testFileDestDir = path.join(testFileSrcDir, 'test_dest');
final goCliPath = path.join(testFileDestDir, 'ww_cli.exe');

String sendTextGo(String text) {
  // TODO: read code from stdout (?)
  const code = "7-guitarist-revenge";
  final res = Process.run(goCliPath, [
    'send',
    '--code', code,
    '--text', text,
  ],
  );
  res.then((_res) {
    print(_res.stdout);
  });
  return code;
}

String recvTextGo(String code) {
  final res = Process.runSync(goCliPath, [
    'receive',
    code,
  ],
  );
  return res.stdout.toString().trimRight();
}

// Future<Uint8List> recvFileGo(String code) {
//   // testFileDestPath = path.join()
//
//   final res = Process.runSync(goCliPath, [
//     'run', '.',
//     'receive',
//     code,
//   ],
//     workingDirectory: wormholeWilliamPath,
//   );
//   // return res.stdout.toString().trimRight();
//
//   // File(testFileDestPath)
// }

Future<ProcessResult> buildGoCli() {
  final buildOutPath = path.relative(goCliPath, from: wormholeWilliamPath);
  final resFuture = Process.run('go', [
    'build',
    '-o', buildOutPath,
    '.',
  ],
    workingDirectory: wormholeWilliamPath,
  );

  resFuture.then((res) {
    if (res.stderr != '') {
      print("ERROR running `go build -o $buildOutPath .`:");
      print(res.stderr);
    }
  });

  return resFuture;
}