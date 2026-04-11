import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/%20sheard/componnents/search_bar.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_assets.dart';

class AppShimmer {
  // -------------------- CONFIG --------------------
  static const Duration duration = Duration(milliseconds: 1000);

  // -------------------- BASE --------------------
  static Widget wrapper({required Widget child}) {
    return Shimmer(
      period: duration,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.shimmerGradientColorStart,
          AppColors.shimmerGradientColorEnd,
        ],
      ),
      child: child,
    );
  }

  static Widget box({double? width, double? height, double radius = 10}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  static Widget placeholder({
    required double height,
    required double width,
    double radius = 8,
  }) {
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

  // -------------------- SEARCH --------------------
  static Widget search() {
    return wrapper(
      child: AppSearchBar(
        controller: TextEditingController(),
        icon: AppAssets.addIcon,
        onTapIconButton: () {},
      ),
    );
  }

  // -------------------- GRID --------------------
  static Widget grid({int count = 2, double childAspectRatio = 0.85}) {
    return wrapper(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        padding: EdgeInsets.zero,
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) => box(),
      ),
    );
  }

  // -------------------- SIMPLE GRID --------------------
  static Widget simpleGrid() {
    return wrapper(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, __) => box(),
        ),
      ),
    );
  }

  // -------------------- SLIDER --------------------
  static Widget slider() {
    return wrapper(
      child: CarouselSlider(
        options: CarouselOptions(height: 19.h, viewportFraction: 0.8),
        items: List.generate(
          4,
          (_) => Container(
            width: 80.w,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------- BRANDS SLIDER --------------------
  static Widget brandsSlider() {
    return wrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          placeholder(height: 2.h, width: 50.w),
          AppSizedBox.h07,
          placeholder(height: 2.h, width: 30.w),
          AppSizedBox.h2,
          CarouselSlider.builder(
            itemCount: 5,
            options: CarouselOptions(height: 15.h, viewportFraction: 0.3),
            itemBuilder: (_, __, ___) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Container(
                      height: 15.w,
                      width: 15.w,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSizedBox.h1,
                    placeholder(height: 1.5.h, width: 20.w),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------------------- HORIZONTAL LIST --------------------
  static Widget horizontalList({
    double? width,
    double? height,
    double? listHeight,
    String? title,
  }) {
    return wrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title),
          SizedBox(
            height: listHeight ?? 20.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) =>
                  box(width: width ?? double.infinity, height: height ?? 275),
              separatorBuilder: (_, __) => SizedBox(width: 5.w),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- VERTICAL LIST --------------------
  static Widget verticalList({double? width, double? height}) {
    return wrapper(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, __) =>
            box(width: width ?? double.infinity, height: height ?? 12.h),
        separatorBuilder: (_, __) => SizedBox(height: 2.h),
        itemCount: 5,
      ),
    );
  }

  // -------------------- DASHBOARD --------------------
  static Widget dashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          search(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      placeholder(height: 14, width: 60),
                      const SizedBox(height: 12),
                      placeholder(height: 20, width: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: placeholder(height: 15.h, width: double.infinity),
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
                placeholder(height: 16, width: 120),
                const SizedBox(height: 16),
                placeholder(height: 22.h, width: double.infinity, radius: 12),
              ],
            ),
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
                placeholder(height: 16, width: 100),
                const SizedBox(height: 16),
                placeholder(height: 20, width: double.infinity, radius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
