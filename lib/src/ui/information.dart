import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:package_info/package_info.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const gitHubUserName = "iiinaiii";
  static const twitterUserName = "iiinaiii";

  static const avatarUrl = "https://github.com/$gitHubUserName.png";
  static const gitHubUrl = "https://github.com/$gitHubUserName";
  static const twitterUrl = "https://twitter.com/$twitterUserName";
  static const fPunksUrl = "https://github.com/$gitHubUserName/F-Punks";
  static const punksUrl = "https://github.com/$gitHubUserName/Punks";
  static const beersUrl = "http://amzn.asia/il6ksAM";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                child: Text(
                  'App info',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
            brightness: Brightness.dark,
            title: Text('Information'),
          ),
          body: TabBarView(children: [
            _buildAppInfo(),
            _buildProfile(),
          ])),
    );
  }

  _openLink(String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: CustomTabsAnimation.fade()),
      );
    } catch (e) {}
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/icon_app.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _getVersionName(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).primaryTextTheme.headline,
                  );
                } else {
                  return Text("");
                }
              },
            ),
          ),
          _buildLinkRow(
            "Punk API",
            "This app uses the Punk API",
            "https://punkapi.com/",
          ),
          InkWell(
            onTap: () => showLicensePage(
                  context: context,
                  applicationName: "F-Punks",
                ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Licenses",
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                  Text(
                    "Open source licenses",
                    style: Theme.of(context).primaryTextTheme.subhead,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> _getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Naoki Ishii",
              style: Theme.of(context).primaryTextTheme.headline,
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () => _openLink(gitHubUrl),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Container(
                      width: 32,
                      height: 32,
                      child: Image.asset('images/icon_github.png'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _openLink(twitterUrl),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Container(
                      width: 32,
                      height: 32,
                      child: Image.asset('images/icon_twitter.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildLinkRow(
            "F-Punks",
            "This app's repository. Made with Flutter.",
            fPunksUrl,
          ),
          _buildLinkRow(
            "Punks",
            "Same as F-punks, but made with Kotlin.",
            punksUrl,
          ),
          _buildLinkRow(
            "Give me beers",
            "Let's drink together.",
            beersUrl,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String title, String subtitle, String url) {
    return InkWell(
      onTap: () => _openLink(url),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            Text(
              subtitle,
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ],
        ),
      ),
    );
  }
}
