
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/src/wc/web_component.dart';

var shadowDom = react.registerComponent(() => new ShadowDom());
class ShadowDom extends react.Component {
  @mustCallSuper
  @override
  Map getDefaultProps() => {
    'include': [],
    'elementFactory': react.span,
    'boundaryMode': 'open',
    'delegatesFocus': false,
  };

  @mustCallSuper
  @override
  Map getInitialState() => {
    'resolving': false,
  };

  Iterable get _children => props['children'];

  ShadowRoot get root => _root;
  ShadowRoot _root;

  get styles => react.style({'dangerouslySetInnerHTML': {'__html': props['customElementStyle']}});

  @override
  void componentWillMount() {
    super.componentWillMount();
    try {
      document.registerElement(props['customElementName'], WebComponent);
    } catch (err) {
      // already exists
    }
  }

  @mustCallSuper
  @override
  void componentDidMount() {
    super.componentDidMount();
    final node = react_dom.findDOMNode(this);
    _root = node.shadowRoot;

    react_dom.render(wrapContainer(), _root);
  }

  @mustCallSuper
  @override
  void componentDidUpdate(_, __) {
    super.componentDidUpdate(_, __);
    react_dom.render(wrapContainer(), _root);
  }

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    react_dom.unmountComponentAtNode(_root);
  }

  ReactElement wrapContainer() {
    // TODO: If we move this to over_react, we should stick the style within the single child.
    return props['elementFactory']({}, [styles, _children.single]);
  }

  @override
  render() {
    var foo = new ReactDomComponentFactoryProxy(props['customElementName']);
    // TODO: forward unconsumed props only
    return foo(props, []);
  }
}
