import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}

class StateContainer extends StatefulWidget {
  final Widget child;
  // final User user;
  List allStreamVideos = [];

  StateContainer({
    required this.child,
    required this.allStreamVideos,
  });

  static StateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
    as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  List allStreamVideos = [];

  void updateUserInfo(allStreamVideos) {
    if (allStreamVideos == null) {
      allStreamVideos = [];
      setState(() {
        allStreamVideos = allStreamVideos;
      });
    } else {
      setState(() {
        allStreamVideos = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key ?key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}