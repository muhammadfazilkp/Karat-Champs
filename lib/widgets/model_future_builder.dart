import 'package:flutter/material.dart';

class ModelFutureBuilder<T> extends StatelessWidget {
  const ModelFutureBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.error,
    this.loading,
  }) : super(key: key);

  final bool busy;
  final T? data;
  final Widget? error;
  final Widget? loading;
  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ??
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
    } else {
      if (data == null) {
        return error ??
            const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
      } else {
        return builder(context, data!, null);
      }
    }
  }
}
