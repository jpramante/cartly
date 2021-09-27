import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenericFutureBuilder<T> extends StatelessWidget {
  const GenericFutureBuilder(
      {Key? key,
      required this.future,
      this.initialData,
      this.onError,
      this.onLoading,
      required this.onDone,
      this.onEmpty})
      : super(key: key);

  final Future<T> future;
  final T? initialData;
  final Function(BuildContext context, Object? error)? onError;
  final Function(BuildContext context)? onLoading;
  final Function(BuildContext context, T? data) onDone;
  final Function(BuildContext context)? onEmpty;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (context, snapshot) {
        final status = snapshot.connectionState;

        if (snapshot.hasError) {
          if (onError != null) {
            return onError!(context, snapshot.error);
          }
        }

        if (status == ConnectionState.waiting) {
          if (onLoading != null) {
            return onLoading!(context);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        if (status == ConnectionState.done) {
          if (snapshot.hasData) {
            return onDone(context, snapshot.data);
          } else {
            return onEmpty!(context);
          }
        }

        return Container();
      },
    );
  }
}
