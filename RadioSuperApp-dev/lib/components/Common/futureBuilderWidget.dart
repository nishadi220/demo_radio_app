import 'package:flutter/material.dart';

class FutureBuilderWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget Function(Object error)? onError;

  const FutureBuilderWidget({
    super.key,
    required this.future,
    required this.onSuccess,
    this.loadingWidget,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while waiting
          return loadingWidget ?? const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error widget if there's an error
          return onError != null
              ? onError!(snapshot.error!)
              : Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Build success UI when data is available
          return onSuccess(snapshot.data as T);
        } else {
          // Handle empty state
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}