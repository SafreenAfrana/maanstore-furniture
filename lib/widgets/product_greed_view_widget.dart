import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:maanstore/screens/product_details_screen/product_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../models/product_model.dart';
import '../models/single_product_variations_model.dart';

class ProductGreedShow extends StatefulWidget {
  const ProductGreedShow({
    Key? key,
    required this.discountPercentage,
    required this.isSingleView,
    required this.categoryId,
    required this.productModel,
    this.singleProductVariations,
  }) : super(key: key);
  final SingleProductVariations? singleProductVariations;
  final String discountPercentage;
  final bool isSingleView;
  final int categoryId;
  final ProductModel productModel;

  @override
  State<ProductGreedShow> createState() => _ProductGreedShowState();
}

class _ProductGreedShowState extends State<ProductGreedShow> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  // @override
  // initState() {
  //   for (var element in wishList) {
  //     if (element.id == widget.productModel.id) {
  //       isFavorite = true;
  //     }
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              widget.isSingleView
                  ? GestureDetector(
                      onTap: () {
                        ProductDetailScreen(
                          productModel: widget.productModel,
                          categoryId: widget.categoryId,
                        ).launch(context);
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: secondaryColor3,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.productModel.images![0].src.toString(),
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        ProductDetailScreen(
                          productModel: widget.productModel,
                          categoryId: widget.categoryId,
                        ).launch(context);
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey.shade100),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          color: secondaryColor3,
                          image: DecorationImage(
                            image: NetworkImage(widget.productModel.images![0].src.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              // Positioned(
              //   right: 8,
              //   top: 8,
              //   child: GestureDetector(
              //     onTap: () {
              //       setState(() {
              //         isFavorite = !isFavorite;
              //       });
              //     },
              //     // onTap: isFavorite
              //     //     ? () {
              //     //         ScaffoldMessenger.of(context)
              //     //             .showSnackBar(const SnackBar(
              //     //                 content: Text(
              //     //           'Already added to the wishlist',
              //     //           textAlign: TextAlign.center,
              //     //         )));
              //     //       }
              //     //     : () async {
              //     //         final Wishlist wishLists = Wishlist(
              //     //           id: widget.productModel.id,
              //     //           name: widget.productModel.name,
              //     //           price: widget.singleProductVariations != null
              //     //               ? widget.singleProductVariations!.salePrice
              //     //                   .toInt()
              //     //               : widget.productModel.salePrice.toInt(),
              //     //           img: widget.productModel.images![0].src,
              //     //           categoryId: widget.categoryId,
              //     //         );
              //     //         addToWishList(wishLists);
              //     //         setState(() {
              //     //           isFavorite = !isFavorite;
              //     //         });
              //     //         ScaffoldMessenger.of(context)
              //     //             .showSnackBar(const SnackBar(
              //     //                 content: Text(
              //     //           'Added to the wishlist',
              //     //           textAlign: TextAlign.center,
              //     //         )));
              //     //       },
              //     child: Container(
              //       height: 35,
              //       width: 35,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(
              //           width: 1,
              //           color: primaryColor.withOpacity(0.05),
              //         ),
              //         borderRadius: const BorderRadius.all(
              //           Radius.circular(30),
              //         ),
              //       ),
              //       child: isFavorite
              //           ? const Center(
              //               child: Icon(
              //                 Icons.favorite,
              //                 color: secondaryColor1,
              //               ),
              //             )
              //           : const Center(child: Icon(Icons.favorite_border)),
              //     ).visible(false),
              //   ),
              // ),
              widget.discountPercentage.toInt() != 202
                  ? Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                        // height: 23,
                        // width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6060),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                        child: Center(
                          child: MyGoogleText(
                            text: '${widget.discountPercentage.toDouble().round().abs()} %',
                            fontSize: 14,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: widget.isSingleView ? null: 190 ,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyGoogleText(
                    text: widget.productModel.name.toString(),
                    fontSize: 15,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.singleProductVariations != null
                          ? SizedBox(
                              child: MyGoogleText(
                                text: widget.singleProductVariations!.salePrice.toInt() <= 0
                                    ? '\$${widget.singleProductVariations!.regularPrice}'
                                    : '\$${widget.singleProductVariations!.salePrice}',
                                fontColor: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : MyGoogleText(
                        text: widget.productModel.salePrice.toInt() <= 0 ? '\$${widget.productModel.regularPrice}' : '\$${widget.productModel.salePrice}',
                              fontColor: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      const SizedBox(width: 8.0),
                      widget.singleProductVariations != null
                          ? Text(
                              '\$${widget.singleProductVariations!.regularPrice}',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            ).visible(widget.discountPercentage.toInt() != 202)
                          : Text(
                              '\$${widget.productModel.regularPrice}',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            ).visible(widget.discountPercentage.toInt() != 202),
                    ],
                  ),
                  // widget.singleProductVariations != null
                  //     ? MyGoogleText(
                  //         text: widget.singleProductVariations!.salePrice.toInt() <= 0
                  //             ? '\$${widget.singleProductVariations!.regularPrice}'
                  //             : '\$${widget.singleProductVariations!.salePrice}',
                  //         fontSize: 14,
                  //         fontColor: Colors.black,
                  //         fontWeight: FontWeight.normal,
                  //       )
                  //     : MyGoogleText(
                  //         text: widget.productModel.salePrice.toInt() <= 0 ? '\$${widget.productModel.regularPrice}' : '\$${widget.productModel.salePrice}',
                  //         fontSize: 14,
                  //         fontColor: Colors.black,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        RatingBarWidget(
                          rating: initialRating,
                          activeColor: ratingColor,
                          inActiveColor: ratingColor,
                          size: 18,
                          onRatingChanged: (aRating) {
                            setState(() {
                              initialRating = aRating;
                            });
                          },
                        ),
                        const SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            ProductDetailScreen(
                              productModel: widget.productModel,
                              categoryId: widget.categoryId,
                            ).launch(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.05),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Center(
                                child: Icon(
                              IconlyLight.bag,
                              color: primaryColor,
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
