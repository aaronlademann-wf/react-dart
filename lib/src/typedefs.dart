library react.typedefs;

import 'package:react/react.dart' show Component;
import 'package:react/react_client.dart' show ReactElement;
import 'package:react/react_client/react_interop.dart' show ReactComponent;

/// Typedef for the [Component.ref] prop.
///
/// * When [ref] is a [Function] __(Recommended)__, it is called with the component instance as soon as it is mounted.
/// * When [ref] is a [String] __(Discouraged)__, it is used to get the component instance as soon as it is mounted.
///
/// The component instance will be of the type:
///   * [Component] for Dart components
///   * [ReactComponent] for JS composite components
///   * `Element` _(DOM node)_ if it is a React DOM component.
///
/// This instance can be used to retrieve a component's DOM node or to call a component's public API methods.
///
/// __Example:__
///
///     DivElement _fooRef;
///
///     @override
///     render() {
///       return div(
///         {
///           'ref': (ref) { _fooRef = ref; }
///         },
///         'children'
///       );
///     }
///
///     barTheFoo() => _fooRef.bar();
///
///     getFooNode() => findDomNode(_fooRef);
///
/// > See: <http://facebook.github.io/react/docs/more-about-refs.html#the-ref-callback-attribute>.
typedef Ref(/* String|Function */ref);

/// Returns a function that chains [element]'s callback ref (if one exists) with [newCallbackRef].
///
/// > Throws [ArgumentError] if [element].ref is a `String` ref, or otherwise not a [Function].
Ref chainRef(ReactElement element, Ref newCallbackRef) {
  final existingRef = element.ref;

  // If there's no existing ref, just return the new one.
  if (existingRef == null) return newCallbackRef;

  if (existingRef is String) {
    throw new ArgumentError.value(existingRef, 'element.ref',
        'The existing ref is a String ref, and cannot be chained');
  }

  if (existingRef is! Function) {
    throw new ArgumentError.value(existingRef, 'element.ref',
        'The existing ref is not a function, and cannot be chained');
  }

  // Use a local function as opposed to a function expression so that its name shows up in any stack traces.
  void chainedRef(ref) {
    // For Dart components, the existing ref is a function passed to the JS that wraps the Dart
    // callback ref and converts the JS instance to the Dart component.
    //
    // So, we need to undo the wrapping around this chained ref and pass in the JS instance.
    existingRef(ref is Component ? ref.jsThis : ref);

    if (newCallbackRef != null) newCallbackRef(ref);
  }

  return chainedRef;
}
