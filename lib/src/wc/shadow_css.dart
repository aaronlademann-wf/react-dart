import 'dart:html';

class ShadowDomSelector {
  final String selectorText;
  final String selectorArg;
  final String descendants;

  ShadowDomSelector._(this.selectorText, [this.selectorArg, this.descendants]);

  factory ShadowDomSelector.selector(String selector) => new ShadowDomSelector._(selector);
  factory ShadowDomSelector.host([String selectorArg, String descendants]) => new ShadowDomSelector._(':host', selectorArg, descendants);
  factory ShadowDomSelector.hostContext([String selectorArg]) => new ShadowDomSelector._(':host-context', selectorArg);
  factory ShadowDomSelector.slotted([String selectorArg]) => new ShadowDomSelector._('::slotted', selectorArg);
}

class ShadowDomCssStyleDeclarations {
  final Map<ShadowDomSelector, CssStyleDeclaration> styles;

  ShadowDomCssStyleDeclarations(this.styles);

  String get cssText {
    String text = '';
    styles.forEach((selector, style) {
      final selectorText = selector.selectorArg == null
        	? selector.selectorText
        	: '${selector.selectorText}(${selector.selectorArg})';

      text += '\n$selectorText {${style.cssText}}';
    });

    return text;
  }

  @override
  String toString() => cssText;
}
