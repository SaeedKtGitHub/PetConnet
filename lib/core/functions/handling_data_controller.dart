import 'package:pet_connect/core/class/status_request.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response; //Failure
  } else {
    return StatusRequest.success;
  }
}
