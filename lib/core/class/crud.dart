import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right({'status': "success", 'data': responseBody});
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithFile(
      String url, Map data, File file) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest("POST", Uri.parse(url));
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile("file", stream, length,
            filename: basename(file.path));
        //request.headers.addAll(myHeaders);
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right({'status': "success", 'data': responseBody});
          ;
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

//Return list of maps
  Future<Either<StatusRequest, List>> postDataList(
      String linkUrl, Map data) async {
    // try {
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(linkUrl), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responseBody = jsonDecode(response.body);
        return Right([
          {'status': "success", 'data': responseBody}
        ]);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
    // } catch (_) {
    //   return const Left(StatusRequest.serverException);
    // }
  }
}
