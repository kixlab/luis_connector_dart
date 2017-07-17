// Copyright (c) 2017, S.-C. Lee. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:luis/luis.dart';

main() {
  var awesome = {
    "hello": "world",
    "list": ["apple", "banana"]
  };

  if (awesome["hello"] is List){
    print("hello is list");
  }

  if (awesome["list"] is List){
    print("list is list");
    var a = awesome["list"] as List<Map>;
    a.forEach( (e) => print(e) );
  }
}
