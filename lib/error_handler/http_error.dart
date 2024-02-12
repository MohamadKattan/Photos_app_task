import '../components /tost_msg.dart';
import '../utils/constants.dart';

class ErrorHttpHandler {
  ErrorHttpHandler({required this.code});
  int code;

  displayErrorHttp() {
    switch (code) {
      case 400:
        TostMsg().displayTostMsg(msg: ' $errorResponseMsg $code');
        break;
      case 401:
        TostMsg()
            .displayTostMsg(msg: ' $errorResponseMsg Unauthorized Error $code');
        break;
      case 403:
        TostMsg()
            .displayTostMsg(msg: ' $errorResponseMsg Forbidden Error $code');
        break;
      case 404:
        TostMsg()
            .displayTostMsg(msg: ' $errorResponseMsg Not Found Error $code');
        break;
      case 500:
        TostMsg().displayTostMsg(
            msg: ' $errorResponseMsg Internal Server Error $code');
        break;
      case 501:
        // do some thing  501 (Internal Server Error)
        TostMsg().displayTostMsg(
            msg: ' $errorResponseMsg Internal Server Error $code');
        break;
      default:
        TostMsg().displayTostMsg(
            msg: ' $errorResponseMsg Internal Server Error $code');
        break;
    }
  }
}
