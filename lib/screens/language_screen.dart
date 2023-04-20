import 'package:flutter/material.dart';
import 'package:maanstore/const/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../widgets/buttons.dart';
import 'home_screens/home.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Future<void> saveData(bool data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRtl', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: context.height() / 3,
          ),
          MyGoogleText(
              text: isRtl ? 'مانستور' : 'Maanstore',
              fontSize: 30,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isRtl = false;
                  });
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 1, color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: const Center(
                                child: Icon(
                                  Icons.g_translate,
                                  size: 60,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const MyGoogleText(
                                text: 'English',
                                fontSize: 20,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.check_circle, color: primaryColor)
                          .visible(!isRtl),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isRtl = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 1, color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: const Center(
                                child: Icon(
                                  Icons.translate_sharp,
                                  size: 60,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const MyGoogleText(
                                text: 'عربى',
                                fontSize: 20,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.check_circle, color: primaryColor)
                          .visible(isRtl),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button1(
                buttonColor: primaryColor,
                buttonText: isRtl ? 'يحفظ' : 'Save',
                onPressFunction: () {
                  saveData(isRtl);
                  const Home().launch(context,isNewTask: true);
                },
              ))
        ]),
      ),
    );
  }
}
