import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



import '../../../core/app_assets.dart';
import '../empty_screen.dart';
import '../loading_widget.dart';

/// A reusable widget that handles all API call states (loading, success, empty, error)
/// in a clean, consistent way across the app.
///
/// Usage example:
/// ```dart
/// BlocBuilder<MyCubit, MyState>(
///   builder: (context, state) {
///     return CustomBlocBuilderView(
///       isLoading: state is GetDataLoading,
///       isError: state is GetDataError,
///       isEmpty: cubit.items.isEmpty,
///       contentBuilder: () => MyContentWidget(data: cubit.items),
///       onRetry: () => cubit.fetchData(),
///       emptyTitle: 'No items found',
///       errorMessage: state is GetDataError ? state.error : null,
///       showErrorView: false,
///       showEmptyView: false,
///       loadingWidget: const SizedBox.shrink(),
///       emptyWidget: const SizedBox.shrink(),
///       errorWidget: const SizedBox.shrink(),
///       emptyTitle: 'No items found',
///       emptyDescription: 'No items found',
///       emptyImage: 'No items found',
///     );
///   },
/// )
/// ```
class CustomApiBuilderView extends StatelessWidget {
  /// Whether the current state is loading.
  final bool isLoading;

  /// Whether the current state is an error.
  final bool isError;

  /// Whether the data is empty (checked after successful load).
  /// Defaults to `false` — set to `true` when your data list is empty.
  final bool isEmpty;

  /// Builder that returns the success/content widget.
  /// Called only when `isLoading`, `isError`, and `isEmpty` are all false.
  final Widget Function() contentBuilder;

  // ---------------------------------------------------------------------------
  // Optional custom widgets (fallback to defaults when null)
  // ---------------------------------------------------------------------------

  /// Custom loading widget. Defaults to [LoaderWidget].
  final Widget? loadingWidget;

  /// Custom empty widget. Defaults to [EmptyScreen] with [emptyTitle].
  final Widget? emptyWidget;

  /// Custom error widget. Defaults to [CustomErrorView] (with retry button
  /// if [onRetry] is provided).
  final Widget? errorWidget;

  // ---------------------------------------------------------------------------
  // Visibility flags
  // ---------------------------------------------------------------------------

  /// Whether to show the default error view. Defaults to `true`.
  /// Set to `false` to hide the error state entirely.
  final bool showErrorView;

  /// Whether to show the default empty view. Defaults to `true`.
  /// Set to `false` to hide the empty state entirely.
  final bool showEmptyView;

  // ---------------------------------------------------------------------------
  // Optional configuration for default widgets
  // ---------------------------------------------------------------------------

  /// Error message from the API state to display in the default error view.
  final String? errorMessage;

  /// Description shown in the default erorr view.
  final String? erorrDescription;

  /// Image asset path shown in the default erorr view.
  final String? erorrImage;

  /// Callback triggered when the user taps "retry" on the default error view.
  /// If `null`, the default error view will not show a retry button.
  final VoidCallback? onRetry;

  /// Title shown in the default empty view. Defaults to `'No data available'`.
  final String? emptyTitle;

  /// Description shown in the default empty view.
  final String? emptyDescription;

  /// Image asset path shown in the default empty view.
  final String? emptyImage;

  const CustomApiBuilderView({
    super.key,
    required this.isLoading,
    required this.contentBuilder,
    this.isError = false,
    this.isEmpty = false,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.showErrorView = true,
    this.showEmptyView = true,
    this.errorMessage,
    this.onRetry,
    this.emptyTitle,
    this.emptyDescription,
    this.emptyImage,
    this.erorrImage,
    this.erorrDescription,
  });

  @override
  Widget build(BuildContext context) {
    // 1 — Loading
    if (isLoading) {
      return loadingWidget ?? const Center(child: LoaderWidget());
    }

    // 2 — Error
    if (isError) {
      return errorWidget ?? _buildDefaultError();
    }

    // 3 — Empty
    if (isEmpty) {
      return emptyWidget ?? _buildDefaultEmpty();
    }

    // 4 — Success / content
    return contentBuilder();
  }

  // ---------------------------------------------------------------------------
  // Default widget builders
  // ---------------------------------------------------------------------------

  Widget _buildDefaultError() {
    if (!showErrorView) return const SizedBox.shrink();

    return EmptyScreen(
      title: errorMessage ?? 'Something went wrong, please try again'.tr(),
      description: erorrDescription,
      image: erorrImage ?? AppAssets.error,
      onTap: onRetry,
      buttonText: 'Retry'.tr(),
    );
  }

  Widget _buildDefaultEmpty() {
    if (!showEmptyView) return const SizedBox.shrink();

    return EmptyScreen(
      title: emptyTitle ?? 'No data available for now'.tr(),
      description: emptyDescription,
      image: emptyImage,
    );
  }
}
