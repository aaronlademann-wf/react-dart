import 'package:react/react.dart' as react;
import 'package:react/react_client/shadow_dom.dart';

var styledButton = react.registerComponent(() => new _StyledButton());
class _StyledButton extends react.Component {
  String styles = '''
    :host {
      color: #595959;
    }
    
    :host(.danger) {
      color: var(--red);
    }
    
    :host(.warning) {
      color: var(--orange);
    }
  ''';

  @override
  render() {
    return shadowDom({
      'class': props['className'],
      'customElementName': 'ws-button',
      'customElementStyle': styles,
    }, [
      react.div({}, props['children'])
    ]);
  }
}
