import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../app/presenter/ui/configuration/configuration_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/presenter/ui/db/widgets/rate_us_alert_box.dart';
import '../../core/colors.dart';
import 'alert_box_bepremium.dart';

class CustomTopBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTopBar({
    Key? key,
    required this.title,
    this.simbol = const Text(""),
  }) : super(key: key);

  final String title;
  final Widget simbol;

  @override
  State<CustomTopBar> createState() => _CustomTopBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 56);
}

class _CustomTopBarState extends State<CustomTopBar> {
  void openUrl() async {
    const number = '5547988608094';
    try {
      await launch(
        'https://wa.me/$number?text=Testando123',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Deu erro $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: iconActiveColor),
      backgroundColor: backgroundColor,
      title: Text(widget.title),
      actions: [
        Row(
          children: [
            widget.simbol,
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.music_note),
                          title: const Text('Torne-se Premium'),
                          onTap: () {
                            BePremium alert = const BePremium();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.rate_review_outlined),
                          title: const Text('Avalie o app'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RateUsAlexBox(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.message),
                          title: const Text('Contate-nos'),
                          onTap: () {
                            openUrl();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.display_settings),
                          title: const Text('Configurações'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ConfigurationPage()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: iconDisableColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
