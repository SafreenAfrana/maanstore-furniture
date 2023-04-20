import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maanstore/api_service/api_service.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:maanstore/const/hardcoded_text_arabic.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../models/retrieve_customer.dart';
import 'buttons.dart';

class GivingRatingBottomSheet extends StatefulWidget {
  const GivingRatingBottomSheet({Key? key, required this.productId})
      : super(key: key);

  final int productId;

  @override
  State<GivingRatingBottomSheet> createState() =>
      _GivingRatingBottomSheetState();
}

class _GivingRatingBottomSheetState extends State<GivingRatingBottomSheet> {
  APIService? apiService;
  String reviewText = '';
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  double initialRating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: FutureBuilder<RetrieveCustomer>(
          future: apiService!.getCustomerDetails(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyGoogleText(
                        text: isRtl
                            ? HardcodedTextArabic.writeAReview
                            : HardcodedTextEng.writeAReview,
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  MyGoogleText(
                    text: isRtl
                        ? HardcodedTextArabic.ratingText
                        : HardcodedTextEng.ratingText,
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RatingBarWidget(
                      rating: initialRating,
                      activeColor: ratingColor,
                      inActiveColor: ratingColor,
                      size: 60,
                      onRatingChanged: (aRating) {
                        setState(() {
                          initialRating = aRating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyGoogleText(
                    text: isRtl
                        ? HardcodedTextArabic.ratingText
                        : HardcodedTextEng.ratingText,
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: globalKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 10,
                      minLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return isRtl
                              ? HardcodedTextArabic
                                  .textFieldUserNameValidatorText1
                              : HardcodedTextEng
                                  .textFieldUserNameValidatorText1;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        reviewText = value!;
                      },
                      decoration: InputDecoration(
                        hintText: isRtl
                            ? HardcodedTextArabic.massage
                            : HardcodedTextEng.massage,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (value) {
                        reviewText = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Button1(
                    buttonText: isRtl
                        ? HardcodedTextArabic.apply
                        : HardcodedTextEng.apply,
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      if (validateAndSave()) {
                        EasyLoading.show(
                            status: isRtl
                                ? HardcodedTextArabic.easyLoadingUpdating
                                : HardcodedTextEng.easyLoadingUpdating);
                        apiService!
                            .createReview(
                                reviewText,
                                initialRating.toInt(),
                                widget.productId,
                                snapShot.data!.username ?? '',
                                snapShot.data!.email ?? '')
                            .then((value) {
                          if (value) {
                            EasyLoading.showSuccess(isRtl
                                ? HardcodedTextArabic.easyLoadingSuccess
                                : HardcodedTextEng.easyLoadingSuccess);
                            globalKey.currentState?.reset();
                            finish(context);
                          } else {
                            EasyLoading.showError(isRtl
                                ? HardcodedTextArabic.easyLoadingError
                                : HardcodedTextEng.easyLoadingError);
                            globalKey.currentState?.reset();
                          }
                        });
                      } else {
                        EasyLoading.showError(
                          isRtl
                              ? HardcodedTextArabic.ratingError
                              : HardcodedTextEng.ratingError,
                        );
                      }
                      globalKey.currentState?.reset();
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate() && initialRating != 0) {
      form.save();
      return true;
    }
    return false;
  }
}

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({Key? key}) : super(key: key);

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyGoogleText(
                  text: isRtl
                      ? HardcodedTextArabic.writeAReview
                      : HardcodedTextEng.writeAReview,
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Image(
              image: AssetImage('images/review_pic.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyGoogleTextWhitAli(
                      fontSize: 26,
                      fontColor: Colors.black,
                      text: isRtl
                          ? HardcodedTextArabic.haveNotPurched
                          : HardcodedTextEng.haveNotPurched,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MyGoogleTextWhitAli(
                    fontSize: 16,
                    fontColor: textColors,
                    text: isRtl
                        ? HardcodedTextArabic.haveNotPurched2
                        : HardcodedTextEng.haveNotPurched2,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Button1(
                  buttonText: isRtl
                      ? HardcodedTextArabic.continueShopping
                      : HardcodedTextEng.continueShopping,
                  buttonColor: primaryColor,
                  onPressFunction: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
