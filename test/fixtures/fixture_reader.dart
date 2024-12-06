import 'dart:io';

String fixture(String fileName) =>
    File("/Users/user/Desktop/Project/tdd_app/test/fixtures/$fileName")
        .readAsStringSync();
