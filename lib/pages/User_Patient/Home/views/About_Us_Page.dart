import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/constant/some_static_links_and_const.dart';
import 'package:medihive_1_/helper/Snack_Dialog.dart';
import 'package:medihive_1_/pages/Auth/widgets/AuthLogo.dart';
import 'package:medihive_1_/shared/loadingIndecator.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  bool _isloading = true;
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1, microseconds: 350), () {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
      ),
      body: !_isloading
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Authlogo(islogin: false)),
                  const Text(
                    clinicDes,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildRow(icon: Icons.email, content: clinicEmail),
                  _buildRow(icon: Icons.location_on, content: clinicAddress),
                  _buildRow(icon: Icons.phone, content: clinicPhone),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[800],
                          size: 35,
                        ),
                        onPressed: () {
                          // TODO: Add Facebook link
                          try {
                            launchUrl(Uri.parse(facebookLink));
                          } on Exception catch (ex) {
                            showErrorSnackBar(context, ex.toString());
                          }
                          // launchUrl(Uri.parse('https://www.facebook.com/YourPage'));
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.pink[400],
                          size: 35,
                        ),
                        onPressed: () {
                          try {
                            launchUrl(Uri.parse(instagramLink));
                          } on Exception catch (ex) {
                            showErrorSnackBar(context, ex.toString());
                          }
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                          size: 35,
                        ),
                        onPressed: () {
                          try {
                            launchUrl(Uri.parse(whatsUpLink));
                          } on Exception catch (ex) {
                            showErrorSnackBar(context, ex.toString());
                          }
                        },
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
            )
          : const Center(
              child: Loadingindecator(),
            ),
    );
  }

  Widget _buildRow({required IconData icon, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: hardmintGreen,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              content,
              maxLines: null,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: jomalhiriFont,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
