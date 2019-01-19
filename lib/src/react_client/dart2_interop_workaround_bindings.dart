@JS()
library react_client.src.dart2_interop_workaround_bindings;

import 'dart:html';

import 'package:js/js.dart';
import 'package:react/react_client/react_interop.dart';

@JS()
abstract class ReactDOM {
  external static Node findDOMNode(object);
  external static ReactComponent render(ReactElement component, Node element);
  external static bool unmountComponentAtNode(Node element);
}
