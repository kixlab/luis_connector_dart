import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Luis {
  String baseURL = "";

  Future<LuisResponse> query(String message) async{
    if (baseURL == null || baseURL.isEmpty) throw "baseURL is empty";

    var param = "&q=" + Uri.encodeComponent(message);
    var response = await http.get(baseURL + param);
    
    if (response.statusCode != 200) throw "Luis is not 200";

    return new LuisResponse.fromMap(JSON.decode(response.body));
  }
}

class LuisIntentScore {
  String intent;
  double score;
  LuisIntentScore(this.intent, this.score);
  LuisIntentScore.fromMap(map){
    intent = map["intent"];
    score = map["score"];
  }
}

class LuisEntity {
  String entity;
  String type;
  int startIndex;
  int endIndex;
  double score;
  String value;

  LuisEntity.fromMap(Map map){
    entity = map["entity"];
    type = map["type"];
    startIndex = map["startIndex"];
    endIndex = map["endIndex"];
    if (map["score"] == null){
      score = 1.0;
    }else{
      score = map["score"];
    }

    if (map["resolution"] != null && map["resolution"]["values"] != null){
      var a = map["resolution"]["values"] as List<String>;
      value = a.join(" ");
    }else{
      value = entity;
    }
  }
}

class LuisResponse {
  String query;
  LuisIntentScore topScoringIntent;
  List<LuisIntentScore> intents = [];
  List<LuisEntity> entities = [];

  LuisResponse.fromMap(Map<String, dynamic> map){
    query = map["query"];
    topScoringIntent = new LuisIntentScore.fromMap(map["topScoringIntent"]);
    if (map["intents"] is List){
      (map["intents"] as List<Map>).forEach((e){
        intents.add( new LuisIntentScore.fromMap(e) );
      });
    }
    if (map["entities"] is List){
      (map["entities"] as List<Map>).forEach((e){
        entities.add( new LuisEntity.fromMap(e) );
      });
    }
  }
}
