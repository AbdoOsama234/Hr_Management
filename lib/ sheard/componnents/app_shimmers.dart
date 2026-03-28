import 'package:hr_manegement/%20sheard/componnents/search_bar.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../core/app_assets.dart';

Widget shimmerSearch() {
  return Shimmer(
    period: shimmerDuration,
    gradient: shimmerGradient,
    child: AppSearchBar(
      controller: TextEditingController(),
      icon: AppAssets.addIcon,
      onTapIconButton: () {},
    ),
  );
}

Widget shimmerGrideView() {
  return Shimmer(
    period: shimmerDuration,
    gradient: shimmerGradient,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.4, // square containers
        ),
        itemBuilder: (context, index) {
          return Container(
            // margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    ),
  );
}

Widget shimmerSlider() {
  return Shimmer(
    period: shimmerDuration,
    gradient: shimmerGradient,
    child: CarouselSlider(
      options: CarouselOptions(
        height: 19.h,
        disableCenter: true,
        viewportFraction: 0.8,

        onPageChanged: (index, reason) {},
        // autoPlay: true
      ),
      items: List.generate(4, (e) {
        return InkWell(
          child: Stack(
            children: [
              Container(
                width: 80.w,
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

Widget shimmerHorizontalList({
  double? width,
  double? height,
  double? listHeight,
  String? title,
}) {
  return Shimmer(
    period: shimmerDuration,
    gradient: shimmerGradient,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title),
        SizedBox(
          height: listHeight ?? 20.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            itemBuilder: (context, index) {
              return shimmerWidget(
                width: width ?? double.infinity,
                height: height ?? 275,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 5.w);
            },
            itemCount: 5,
          ),
        ),
      ],
    ),
  );
}

Widget shimmerVirtcalList({double? width, double? height}) {
  return Shimmer(
    period: shimmerDuration,
    gradient: shimmerGradient,
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemBuilder: (context, index) {
        return shimmerWidget(
          width: width ?? double.infinity,
          height: height ?? 12.h,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 2.h);
      },
      itemCount: 5,
    ),
  );
}

Widget shimmerWidget({double? width, double? height}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

const Gradient shimmerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: shimmerColors,
);

const List<Color> shimmerColors = [
  AppColors.primaryDark,
  Colors.white,
  Colors.grey,
  AppColors.primary,
];
const Duration shimmerDuration = Duration(milliseconds: 1000);

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerSearch(),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceholder(height: 14, width: 60), // العنوان
                      SizedBox(height: 12),
                      ShimmerPlaceholder(height: 20, width: 80), // القيمة
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- صافي / دخل / مصروف (3 أعمدة) ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: ShimmerPlaceholder(height: 15.h, width: double.infinity),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerPlaceholder(height: 16, width: 120), // العنوان
                const SizedBox(height: 16),
                ShimmerPlaceholder(
                  height: 22.h,
                  width: double.infinity,
                  radius: 12,
                ), // مساحة الرسم
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- نسبة الإشغال (Occupancy Section) ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerPlaceholder(height: 16, width: 100), // العنوان
                SizedBox(height: 16),
                ShimmerPlaceholder(
                  height: 20,
                  width: double.infinity,
                  radius: 8,
                ), // progress
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerPlaceholder({
    super.key,
    required this.height,
    required this.width,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
