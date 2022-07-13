import 'package:flutter/material.dart';

class AutomaticKeepAliveProxy extends StatefulWidget {
  const AutomaticKeepAliveProxy({required this.child, Key? key}) : super(key: key);

  final Widget child;
  @override
  AutomaticKeepAliveProxyState createState() => AutomaticKeepAliveProxyState();

}
class AutomaticKeepAliveProxyState extends State<AutomaticKeepAliveProxy> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}