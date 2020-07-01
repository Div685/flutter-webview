import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_app/contactUs/email.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tally Reports"),
          centerTitle: true,
          actions: <Widget>[NavigationControls(_controller.future)],
        ),
        drawer: Drawer(),
        // body: Builder(builder: (BuildContext context) {
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: "https://tallysolutions.com/",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.email),
            onPressed: () {
              Navigator.pushNamed(context, '/email'
                  // MaterialPageRoute(
                  //   builder: (context) => EmailUs(),
                  // ),
                  );
              // EmailUs();
            })
        // favoriteButton(), // FloatingActionButton(onPressed: () {
        // EmailUs(),
        // }) //favoriteButton(),
        );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              final String url = await controller.data.currentUrl();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Favorited $url')),
              );
              // EmailUs();
            },
            child: const Icon(Icons.email),
          );
        }
        return Container();
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
