import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenMap {
  viewLocation(double latitude, double longitude) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      OurToast().showErrorToast("Cann't open location");
    }
  }
}
