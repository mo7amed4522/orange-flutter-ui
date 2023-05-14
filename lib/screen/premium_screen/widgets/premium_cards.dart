import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';

import '../../../model/get_package.dart';

class PremiumCards extends StatelessWidget {
  final int selectedOffer;
  final List<GetPackageData>? packageData;
  final Function(int index) onOfferSelect;

  const PremiumCards({
    Key? key,
    required this.packageData,
    required this.selectedOffer,
    required this.onOfferSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.1,
      child: ListView.builder(
        itemCount: packageData?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool select = selectedOffer == index;
          return InkWell(
            onTap: () {
              onOfferSelect(index);
            },
            child: AspectRatio(
              aspectRatio: 0.7,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: select
                      ? ColorRes.white
                      : ColorRes.white.withOpacity(0.20),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        packageData?[index].title ?? '',
                        style: TextStyle(
                          color: select ? ColorRes.black : ColorRes.white,
                          fontSize: 13,
                          fontFamily: FontRes.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${packageData?[index].months}',
                        style: TextStyle(
                          color:
                              select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                          fontSize: 42,
                        ),
                      ),
                      Text(
                        'Months',
                        style: TextStyle(
                          color:
                              select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        packageData?[index].description != null
                            ? '${packageData?[index].description}'
                            : '',
                        style: TextStyle(
                          color: select ? ColorRes.grey8 : ColorRes.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        '\$ ${packageData?[index].price}',
                        style: TextStyle(
                          color: select ? ColorRes.darkGrey5 : ColorRes.white,
                          fontSize: 20,
                          fontFamily: FontRes.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

/*Widget offerCard(
    int index,
    String title,
    int time,
    String monthText,
    String subTitle,
    String amount,
  ) {
    bool select = selectedOffer == index;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onOfferSelect(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: select ? ColorRes.white : ColorRes.white.withOpacity(0.20),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: select ? ColorRes.black : ColorRes.white,
                  fontSize: 13,
                  fontFamily: 'gilroy_bold',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                time.toString(),
                style: TextStyle(
                  color: select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                  fontSize: 42,
                ),
              ),
              Text(
                monthText,
                style: TextStyle(
                  color: select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subTitle,
                style: TextStyle(
                  color: select ? ColorRes.grey8 : ColorRes.white,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                amount,
                style: TextStyle(
                  color: select ? ColorRes.darkGrey5 : ColorRes.white,
                  fontSize: 20,
                  fontFamily: 'gilroy_bold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
