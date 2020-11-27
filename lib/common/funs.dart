import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../index.dart';

Widget gmAvatar(
  String url, {
  double width = 30,
  double height,
  BoxFit fit,
  BorderRadius borderRadius,
}) {
  Image placeholder = Image.asset(
    "imgs/avatar-default.png",
    width: width,
    height: height,
  );
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(2.0),
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
    ),
  );
}

void showToast(
  String msg, {
  Toast toastLength: Toast.LENGTH_SHORT,
  ToastGravity gravity: ToastGravity.CENTER,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIos: 1,
    backgroundColor: Colors.grey[600],
    fontSize: 16.0,
  );
}

void showLoading(BuildContext context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false, //防止点空白关闭对话框
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ]),
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16.0),
            constraints: BoxConstraints(minWidth: 180, minHeight: 120),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
