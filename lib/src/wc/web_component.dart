import 'dart:developer';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/src/wc/shadow_css.dart';

typedef OnCreatedCallback(WebComponent instance);

class WebComponent extends HtmlElement {
  static Iterable<dynamic> componentContent;
  static ShadowDomCssStyleDeclarations componentStyles;
  static Iterable<String> componentStylesUrls;
  static String componentShadowMode;
  static String _tagName;
  OnCreatedCallback onCreated;

//  factory WebComponent(String tagName, Iterable<dynamic> content, {
//    ShadowDomCssStyleDeclarations styles,
//    Iterable<String> stylesUrls,
//    String shadowMode: 'open',
//  }) {
//    _tagName = tagName;
//    componentContent = content;
//    componentStyles = styles;
//    componentStylesUrls = stylesUrls;
//    componentShadowMode = shadowMode;
//
////    try {
//      document.registerElement(tagName, WebComponent);
//    	return new Element.tag(tagName);
////    } catch (err) {
////     	throw new UnsupportedError('Only one custom `<$tagName>` element can be created.\n\n$err');
////    }
//  }

  WebComponent.created() : super.created() {
//    react.registerCustomElement(_tagName);
//    customWebElements.add(this);
    print('created $_tagName');
    this.attachShadow({'mode': 'open'});
//    _styleElement = new StyleElement()..text = componentStyles.cssText;
//    shadowRoot.append(_styleElement);
//    componentContent.forEach((content) {
//      if (content is Element) {
//        shadowRoot.append(content);
//      } else {
//        shadowRoot.appendText(content.toString());
//      }
//    });
//
//    onCreated?.call(this);
  }

  StyleElement _styleElement;

  void updateStyle(ShadowDomCssStyleDeclarations componentStyles) {
    _styleElement.text = componentStyles.cssText;
  }
}
