import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DynamicLinksService {
  static const String _dynamicLinksShortLinkUrl =
      'https://firebasedynamiclinks.googleapis.com/v1/shortLinks';

  static const String _yourDynamicLinksApiKey = 'AIzaS___________________st';

  static const String _yourDynamicLinksDomain = 'https://st.page.link';

//apn	The package name of the Android app to use to open the link. The app must be connected to your project from the Overview page of the Firebase console. Required for the Dynamic Link to open an Android app.
  static const String _apn = 'app.datacode.st';

  //Your app's App Store ID, used to send users to the App Store when the app isn't installed
  static const String _isi = "sttttttt";

  //The bundle ID of the iOS app to use to open the link. The app must be connected to your project from the Overview page of the Firebase console. Required for the Dynamic Link to open an iOS app.
  static const String _ibi = "app.datacode.st";

  //The version number of the minimum version of your app that can open the link. This flag is passed to your app when it is opened, and your app must decide what to do with it.
  static const String _imv = "1.0.1";

  //the main web domain address of your app
  static const String _yourFallBackDomain = "www.datacode.app";

  //amv	The versionCode of the minimum version of your app that can open the link. If the installed app is an older version, the user is taken to the Play Store to upgrade the app.
  static const String _amv = "1";

// si	The URL to an image related to this link. The image should be at least 300x200 px, and less than 300 KB.
  static const String _si = "https://some_image_url";

  //to build some url like this , myWebsite://postCategory/postAuthor-postID
  //and to show postTitle as title and postDescription as description and imageUrl as preview for social media
  Future buildDynamicLinks(
      {required postID,
      required postTitle,
      required postDescription,
      required postAuthor,
      required postCategory}) async {
    String? urlToReturn;
    const String postUrl =
        '$_dynamicLinksShortLinkUrl?key=$_yourDynamicLinksApiKey';
    //st	The title to use when the Dynamic Link is shared in a social post.
    String _st = "$postTitle";
    // sd	The description to use when the Dynamic Link is shared in a social post.
    String _sd = "$postAuthor  -  $postDescription";

    String theUrl =
        "$_yourDynamicLinksDomain/?isi=$_isi&ibi=$_ibi&imv=$_imv&link=https%3A%2F%2F$_yourFallBackDomain%2F${postCategory ?? 'links'}%2F$postID&si=$_si&sd=$_sd&amv=$_amv&st=$_st&apn=$_apn";

    await http.post(Uri.tryParse(postUrl)!, body: {
      'longDynamicLink': theUrl,
    }).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || response == null) {
          throw Exception("Error while fetching data");
        }
        var decoded = json.decode(response.body);
        urlToReturn = decoded['shortLink'];
        return decoded['shortLink'];
      },
    ).catchError((e) => debugPrint('error $e'));
    return urlToReturn;
  }
}
