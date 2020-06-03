import 'dart:convert';
import 'package:crypto/crypto.dart';

const String baseUrl = "https://gateway.marvel.com:443";
const String publicKey = "e5c99aa813bc1b9b494fda37fa9b1045";
const String privateKey = "b4d5b0acfd2fa615241adad5968f9a1d4925881b";
const String timeStamp = "1";

String _hash() {
  final String input = '$timeStamp$privateKey$publicKey';
  return md5.convert(utf8.encode(input)).toString();
}

class Http {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  static String url(String url) =>
      '$baseUrl$url?ts=$timeStamp&apikey=$publicKey&hash=${_hash()}';
}
