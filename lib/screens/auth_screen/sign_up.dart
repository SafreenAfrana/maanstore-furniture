import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maanstore/api_service/api_service.dart';
import 'package:maanstore/const/constants.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:maanstore/models/customer.dart';
import 'package:maanstore/widgets/add_new_address.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/hardcoded_text_arabic.dart';
import '../../widgets/buttons.dart';
import '../../widgets/social_media_button.dart';
import 'log_in_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  late APIService apiService;
  CustomerModel model = CustomerModel(email: '', userName: '', password: '');
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                    width: 1,
                    color: textColors,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(HardcodedImages.appLogo)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: isRtl
                                    ? HardcodedTextArabic
                                        .textFieldUserNameLabelText
                                    : HardcodedTextEng
                                        .textFieldUserNameLabelText,
                                hintText: isRtl
                                    ? HardcodedTextArabic
                                        .textFieldUserNameHintText
                                    : HardcodedTextEng
                                        .textFieldUserNameHintText,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                          .textFieldUserNameValidatorText1
                                      : HardcodedTextEng
                                          .textFieldUserNameValidatorText1;
                                } else if (value.length < 4) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                          .textFieldUserNameValidatorText2
                                      : HardcodedTextEng
                                          .textFieldUserNameValidatorText2;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                model.userName = value!;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText:isRtl
                                    ? HardcodedTextArabic
                                    .textFieldEmailLabelText
                                    : HardcodedTextEng
                                    .textFieldEmailLabelText,
                                hintText:isRtl
                                    ? HardcodedTextArabic
                                    .textFieldEmailHintText
                                    : HardcodedTextEng
                                    .textFieldEmailHintText,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                      .textFieldEmailHintText
                                      : HardcodedTextEng
                                      .textFieldEmailValidatorText1;
                                } else if (!value.contains('@')) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                      .textFieldEmailHintText
                                      : HardcodedTextEng
                                      .textFieldEmailValidatorText2;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                model.email = value!;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText:
                                isRtl
                                    ? HardcodedTextArabic
                                    .textFieldPassLabelText
                                    : HardcodedTextEng
                                    .textFieldPassLabelText,
                                hintText:
                                isRtl
                                    ? HardcodedTextArabic
                                    .textFieldPassHintText
                                    : HardcodedTextEng
                                    .textFieldPassHintText,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                      .textFieldPassValidatorText1
                                      : HardcodedTextEng
                                      .textFieldPassValidatorText1;
                                } else if (value.length < 4) {
                                  return isRtl
                                      ? HardcodedTextArabic
                                      .textFieldPassValidatorText2
                                      : HardcodedTextEng
                                      .textFieldPassValidatorText2;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                model.password = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Button1(
                          buttonText: isRtl
                              ? HardcodedTextArabic.registerButtonText
                              : HardcodedTextEng.registerButtonText,
                          buttonColor: primaryColor,
                          onPressFunction: () async {
                            if (validateAndSave()) {
                              EasyLoading.show(
                                  status:isRtl ? HardcodedTextArabic.easyLoadingRegister : HardcodedTextEng.easyLoadingRegister);

                              apiService.createCustomer(model).then((ret) {
                                globalKey.currentState?.reset();

                                if (ret) {
                                  EasyLoading.showSuccess(
                                      isRtl ? HardcodedTextArabic.easyLoadingSuccess : HardcodedTextEng.easyLoadingSuccess);

                                  const AddNewAddress().launch(context);
                                } else {
                                  EasyLoading.showError(isRtl ? HardcodedTextArabic.easyLoadingError : HardcodedTextEng.easyLoadingError);
                                }
                              });
                            }
                          }),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyGoogleText(
                            fontSize: 16,
                            fontColor: textColors,
                            text: isRtl
                                ? HardcodedTextArabic
                                .alreadyAccount
                                : HardcodedTextEng
                                .alreadyAccount,
                            fontWeight: FontWeight.w500,
                          ),
                          TextButton(
                            onPressed: () {
                              const LogInScreen().launch(
                                context,
                                //pageRouteAnimation: PageRouteAnimation.Fade,
                              );
                            },
                            child: MyGoogleText(
                              text: isRtl
                                  ? HardcodedTextArabic.signInButtonText
                                  : HardcodedTextEng.signInButtonText,
                              fontSize: 16,
                              fontColor: secondaryColor1,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SocialMediaButtons().visible(false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
