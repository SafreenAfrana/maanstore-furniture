import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maanstore/api_service/api_service.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Providers/all_repo_providers.dart';
import '../../config/config.dart';
import '../../const/constants.dart';
import '../../const/hardcoded_text_arabic.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/order_create_model.dart' as lee;
import '../../models/retrieve_customer.dart';
import '../../widgets/buttons.dart';
import '../../widgets/checkout_shimmer_widget.dart';
import '../../widgets/confirmation_popup.dart';
import '../home_screens/home.dart';
import 'add_new_address_2.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key, this.couponPrice}) : super(key: key);

  final double? couponPrice;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<lee.LineItems> lineItems = <lee.LineItems>[];
  RetrieveCustomer? retrieveCustomer;
  double totalAmount = 0;
  APIService? apiService;
  int initialValue = 1;

  String whichPaymentIsChecked = 'Cash on Delivery';

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: MyGoogleText(
            text: isRtl ? HardcodedTextArabic.checkOutScreenName : HardcodedTextEng.checkOutScreenName,
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        body: FutureBuilder<RetrieveCustomer>(
            future: apiService!.getCustomerDetails(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                if (snapShot.data!.shipping!.address1!.isEmpty ||
                    snapShot.data!.shipping!.firstName!.isEmpty ||
                    snapShot.data!.shipping!.city!.isEmpty ||
                    snapShot.data!.billing!.phone!.isEmpty) {
                  Center(
                    child: Button1(
                        buttonText: isRtl ? HardcodedTextArabic.addShippingAddressButton : HardcodedTextEng.addShippingAddressButton,
                        buttonColor: primaryColor,
                        onPressFunction: () => AddNewAddressTwo(initShipping: snapShot.data!.shipping, initBilling: snapShot.data!.billing).launch(context)),
                  );
                }
                retrieveCustomer = snapShot.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: context.width(),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer(builder: (context, ref, child) {
                                final cart = ref.watch(cartNotifier);
                                lineItems = cart.cartItems;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyGoogleText(
                                      text: '${isRtl ? HardcodedTextArabic.totalItems : HardcodedTextEng.totalItems} ${cart.cartOtherInfoList.length}',
                                      fontSize: 18,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    SizedBox(
                                      height: 130,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 8,
                                              bottom: 8,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: secondaryColor3,
                                                  )),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1,
                                                          color: secondaryColor3,
                                                        ),
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        color: secondaryColor3,
                                                        image: DecorationImage(image: NetworkImage(cart.cartOtherInfoList[index].productImage.toString())),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: MyGoogleText(
                                                          text: cart.cartOtherInfoList[index].productName.toString(),
                                                          fontSize: 16,
                                                          fontColor: Colors.black,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: context.width() / 2.3,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              MyGoogleText(
                                                                text: '${cart.cartOtherInfoList[index].productPrice}\$',
                                                                fontSize: 16,
                                                                fontColor: Colors.black,
                                                                fontWeight: FontWeight.normal,
                                                              ),

                                                              ///_____________________quantity_____________________
                                                              Row(
                                                                children: [
                                                                  MyGoogleText(
                                                                    text: isRtl ? HardcodedTextArabic.quantity : HardcodedTextEng.quantity,
                                                                    fontSize: 13,
                                                                    fontColor: textColors,
                                                                    fontWeight: FontWeight.normal,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  MyGoogleText(
                                                                    text: cart.cartOtherInfoList[index].quantity.toString(),
                                                                    fontSize: 13,
                                                                    fontColor: textColors,
                                                                    fontWeight: FontWeight.normal,
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: cart.cartOtherInfoList.length,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              const SizedBox(height: 10),
                              MyGoogleText(
                                text: isRtl ? HardcodedTextArabic.shippingAddress : HardcodedTextEng.shippingAddress,
                                fontSize: 20,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: secondaryColor3),
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyGoogleText(
                                          text: '${snapShot.data!.shipping!.firstName} ${snapShot.data!.shipping!.lastName}',
                                          fontSize: 16,
                                          fontColor: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            AddNewAddressTwo(
                                              initShipping: snapShot.data!.shipping,
                                              initBilling: snapShot.data!.billing,
                                            ).launch(context);
                                          },
                                          child: MyGoogleText(
                                            text: isRtl ? HardcodedTextArabic.changeButton : HardcodedTextEng.changeButton,
                                            fontSize: 16,
                                            fontColor: secondaryColor1,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${snapShot.data!.shipping!.address1}, ${snapShot.data!.shipping!.address2}, ${snapShot.data!.shipping!.city}, ${snapShot.data!.shipping!.state}, ${snapShot.data!.shipping!.postcode}, ${snapShot.data!.shipping!.country}, ${snapShot.data!.billing!.phone}',
                                        maxLines: 3,
                                        style: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const CheckOutShimmerWidget();
              }
            }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///_____Cost_Section_____________
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyGoogleText(
                    text: isRtl ? HardcodedTextArabic.yourOrder : HardcodedTextEng.yourOrder,
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.00),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyGoogleText(
                              text: isRtl ? HardcodedTextArabic.subtotal : HardcodedTextEng.subtotal,
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                            Consumer(builder: (_, ref, __) {
                              final price = ref.watch(cartNotifier);
                              return MyGoogleText(
                                text: widget.couponPrice == null
                                    ? '\$${price.cartTotalPriceF(initialValue)}'
                                    : '\$${price.cartTotalPriceF(initialValue) - price.promoPrice}',
                                fontSize: 20,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              );
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyGoogleText(
                              text: isRtl ? HardcodedTextArabic.discount : HardcodedTextEng.discount,
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                            MyGoogleText(
                              text: '\$${widget.couponPrice}',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            )
                          ],
                        ).visible(widget.couponPrice != null),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1,
                      color: textColors,
                    ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyGoogleText(
                          text: isRtl ? HardcodedTextArabic.totalAmount : HardcodedTextEng.totalAmount,
                          fontSize: 18,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        Consumer(builder: (_, ref, __) {
                          final price = ref.watch(cartNotifier);

                          return MyGoogleText(
                            text: widget.couponPrice == null
                                ? '\$${price.cartTotalPriceF(initialValue)}'
                                : '\$${price.cartTotalPriceF(initialValue) - price.promoPrice}',
                            fontSize: 20,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer(builder: (context, ref, child) {
                final cart = ref.read(cartNotifier);

                return Button1(
                    buttonText: isRtl ? HardcodedTextArabic.payWithWebCheckoutButton : HardcodedTextEng.payWithWebCheckoutButton,
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      EasyLoading.show(
                        status: isRtl ? HardcodedTextArabic.easyLoadingCreatingOrder : HardcodedTextEng.easyLoadingCreatingOrder,
                      );
                      apiService?.createOrder(retrieveCustomer!, lineItems, 'Cash on Delivery', false, cart.coupon).then((value) async {
                        if (value) {
                          var snap = await apiService!.getListOfOrder();
                          if (snap.isNotEmpty) {
                            // ignore: use_build_context_synchronously
                            MyWebView(
                              url: snap[0].paymentUrl,
                              id: snap[0].id.toString(),
                            ).launch(context);
                          }

                          EasyLoading.dismiss(animation: true);
                          cart.cartOtherInfoList.clear();
                          cart.cartItems.clear();
                          cart.coupon.clear();
                          ref.refresh(getOrders);
                        } else {
                          EasyLoading.showError(isRtl ? HardcodedTextArabic.easyLoadingError : HardcodedTextEng.easyLoadingError);
                        }
                      });
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key, required this.url, required this.id}) : super(key: key);
  final String url;
  final String id;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isPaf = false;
  WebViewController? _controller;
  Future<bool> _willPopCallback() async {
    bool canNavigate = await _controller!.canGoBack();
    if (canNavigate) {
      _controller!.goBack();
      return false;
    } else {
      Future.delayed(const Duration(milliseconds: 1)).then((value) => const Home().launch(context));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(currentUrl?.indexOf('?'));
    // print(currentUrl?.substring(0, currentUrl?.indexOf('?')));
    // print(Config.orderConfirmUrl + widget.id.toString());
    return Scaffold(
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: Stack(
          children: [
            WebView(
              onPageFinished: (url) {
                int position = url.indexOf('?') - 1;
                if (url.substring(0, position) == (Config.orderConfirmUrl + widget.id)) {
                  setState(() {
                    isPaf = true;
                  });
                }
              },
              initialUrl: widget.url,
              gestureNavigationEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
              },
            ),
            RedeemConfirmationScreen(
              image: 'images/confirm_order_pupup.png',
              mainText: isRtl ? HardcodedTextArabic.orderSuccess : HardcodedTextEng.orderSuccess,
              subText: isRtl ? HardcodedTextArabic.orderSuccessSubText : HardcodedTextEng.orderSuccessSubText,
              buttonText: isRtl ? HardcodedTextArabic.backToHomeButton : HardcodedTextEng.backToHomeButton,
            ).visible(isPaf),
          ],
        ),
      ),
    );
  }
}
