library react.typedefs;

import 'dart:collection';

/// Typedef for `react.Component.ref`, which should return one of the following specified by the provided [ref]:
///
/// * `react.Component` if it is a Dart component.
/// * `Element` _(DOM node)_ if it is a React DOM component.
typedef dynamic Ref(String ref);

/// Typedef for a callback found within `react.Component.transactionalSetStateCallbacks`.
typedef dynamic TransactionalSetStateCallback(
    Map<String, String> nextState,
    UnmodifiableMapView<String, String> props,
);
