// Copyright (c) 2017, S.-C. Lee. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:luis/luis.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  var luis_response_1 = '''
  {
  "query": "불 좀 꺼줘",
  "topScoringIntent": {
    "intent": "light_service",
    "score": 0.9847185
  },
  "intents": [
    {
      "intent": "light_service",
      "score": 0.9847185
    },
    {
      "intent": "light_brightness",
      "score": 0.009695322
    },
    {
      "intent": "light_sat",
      "score": 0.008383735
    },
    {
      "intent": "set_field",
      "score": 0.004836126
    },
    {
      "intent": "coffee_service",
      "score": 0.00209826068
    },
    {
      "intent": "None",
      "score": 0.00149375654
    },
    {
      "intent": "light_color_list",
      "score": 0.0011157433
    },
    {
      "intent": "light_color",
      "score": 0.000746171
    },
    {
      "intent": "agent_query",
      "score": 0.0006033348
    },
    {
      "intent": "Greet_Service",
      "score": 0.000331575866
    },
    {
      "intent": "query_field",
      "score": 0.000114103525
    },
    {
      "intent": "query_tempature",
      "score": 2.77056131E-07
    },
    {
      "intent": "change_tempature",
      "score": 1.04856113E-07
    }
  ],
  "entities": [
    {
      "entity": "꺼",
      "type": "Binary::False",
      "startIndex": 4,
      "endIndex": 4,
      "score": 0.973015123
    }
  ]
}
''';


  group('A group of tests', () {
    Luis luis;

    setUp(() {
      luis = new Luis();
      luis.baseURL = "https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/b17f3e2d-8222-45c1-a51e-300d12dead2d?subscription-key=99632d6d302c405f8ff27c28ffc7d8d7&staging=true&verbose=true&timezoneOffset=0";
    });

    test('Luis Response Parser test', (){
      var response = new LuisResponse.fromMap( JSON.decode(luis_response_1) );
      expect(response.query, "불 좀 꺼줘");
      expect(response.topScoringIntent.intent, "light_service");
      expect(response.topScoringIntent.score, 0.9847185);
      expect(response.intents.length, 13);
      expect(response.intents.first.intent, "light_service");
      expect(response.intents.first.score, 0.9847185);
      expect(response.entities.length, 1);
      expect(response.entities.first.entity, "꺼");
      expect(response.entities.first.type, "Binary::False");
      expect(response.entities.first.startIndex, 4);
      expect(response.entities.first.endIndex, 4);
      expect(response.entities.first.score, 0.973015123);
    });

    test("Luis.query", () async{
      var response = await luis.query("불 좀 꺼줘");
      expect(response.topScoringIntent.intent, isNotEmpty);
      expect(response.topScoringIntent.score, isNotNull);
    });
  });
}
