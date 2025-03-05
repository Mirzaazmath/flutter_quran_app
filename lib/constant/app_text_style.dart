
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyle {
  /// HeadLineText == 32 Size
  static Widget headlineText(context, text) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(color: AppColors.textColor),
        textAlign: TextAlign.center);
  }

  /// TitleLargeText == 22 Size
  static Widget titleLargeText(context, text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: AppColors.textColor, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  /// TitleMediumText == 16 Size
  static Widget titleMediumText(context, text, [color]) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: color ?? AppColors.textColor),
      textAlign: TextAlign.center,
    );
  }

  /// TitleSmallText == 14 Size
  static Widget titleSmallText(context, text, [color]) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: color ?? AppColors.textColor),
        textAlign: TextAlign.center);
  }

  /// LabelMediumText == 12 Size
  static Widget labelMediumText(context, text, [color]) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: color ?? AppColors.textColor),
        textAlign: TextAlign.center);
  }


}