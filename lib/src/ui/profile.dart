import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

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
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
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
      ),
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
