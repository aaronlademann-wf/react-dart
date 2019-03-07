import 'package:react/src/react_client/synthetic_event2_factories.dart';

/// A mapping from event prop keys to their respective event factories.
///
/// Used in `_convertEventHandlers2` for efficient event handler conversion
/// in `Component2` instances.
///
/// > See: <https://reactjs.org/docs/events.html#supported-events>
final Map<String, Function> eventPropKeyToEventFactory2 = (() {
  var _eventPropKeyToEventFactory = <String, Function>{
    // SyntheticAnimationEvent
    'onAnimationStart': syntheticAnimationEvent2Factory,
    'onAnimationEnd': syntheticAnimationEvent2Factory,
    'onAnimationIteration': syntheticAnimationEvent2Factory,

    // SyntheticClipboardEvent
    'onCopy': syntheticClipboardEvent2Factory,
    'onCut': syntheticClipboardEvent2Factory,
    'onPaste': syntheticClipboardEvent2Factory,

    // SyntheticCompositionEvent
    'onCompositionEnd': syntheticCompositionEvent2Factory,
    'onCompositionStart': syntheticCompositionEvent2Factory,
    'onCompositionUpdate': syntheticCompositionEvent2Factory,

    // SyntheticKeyboardEvent
    'onKeyDown': syntheticKeyboardEvent2Factory,
    'onKeyPress': syntheticKeyboardEvent2Factory,
    'onKeyUp': syntheticKeyboardEvent2Factory,

    // SyntheticFocusEvent
    'onFocus': syntheticFocusEvent2Factory,
    'onBlur': syntheticFocusEvent2Factory,

    // SyntheticFormEvent
    'onChange': syntheticFormEvent2Factory,
    'onInput': syntheticFormEvent2Factory,
    'onInvalid': syntheticFormEvent2Factory,
    'onSubmit': syntheticFormEvent2Factory,
    'onReset': syntheticFormEvent2Factory,

    // SyntheticMouseEvent
    'onClick': syntheticMouseEvent2Factory,
    'onContextMenu': syntheticMouseEvent2Factory,
    'onDoubleClick': syntheticMouseEvent2Factory,
    'onDrag': syntheticMouseEvent2Factory,
    'onDragEnd': syntheticMouseEvent2Factory,
    'onDragEnter': syntheticMouseEvent2Factory,
    'onDragExit': syntheticMouseEvent2Factory,
    'onDragLeave': syntheticMouseEvent2Factory,
    'onDragOver': syntheticMouseEvent2Factory,
    'onDragStart': syntheticMouseEvent2Factory,
    'onDrop': syntheticMouseEvent2Factory,
    'onMouseDown': syntheticMouseEvent2Factory,
    'onMouseEnter': syntheticMouseEvent2Factory,
    'onMouseLeave': syntheticMouseEvent2Factory,
    'onMouseMove': syntheticMouseEvent2Factory,
    'onMouseOut': syntheticMouseEvent2Factory,
    'onMouseOver': syntheticMouseEvent2Factory,
    'onMouseUp': syntheticMouseEvent2Factory,

    // SyntheticPointerEvent
    'onGotPointerCapture': syntheticPointerEvent2Factory,
    'onLostPointerCapture': syntheticPointerEvent2Factory,
    'onPointerCancel': syntheticPointerEvent2Factory,
    'onPointerDown': syntheticPointerEvent2Factory,
    'onPointerEnter': syntheticPointerEvent2Factory,
    'onPointerLeave': syntheticPointerEvent2Factory,
    'onPointerMove': syntheticPointerEvent2Factory,
    'onPointerOver': syntheticPointerEvent2Factory,
    'onPointerOut': syntheticPointerEvent2Factory,
    'onPointerUp': syntheticPointerEvent2Factory,

    // SyntheticTouchEvent
    'onTouchCancel': syntheticTouchEvent2Factory,
    'onTouchEnd': syntheticTouchEvent2Factory,
    'onTouchMove': syntheticTouchEvent2Factory,
    'onTouchStart': syntheticTouchEvent2Factory,

    // SyntheticTransitionEvent
    'onTransitionEnd': syntheticTransitionEvent2Factory,

    // SyntheticUIEvent
    'onScroll': syntheticUIEventFactory,

    // SyntheticWheelEvent
    'onWheel': syntheticWheelEventFactory,
  };

  // Add support for capturing variants; e.g., onClick/onClickCapture
  for (var key in _eventPropKeyToEventFactory.keys.toList()) {
    _eventPropKeyToEventFactory[key + 'Capture'] =
        _eventPropKeyToEventFactory[key];
  }

  return _eventPropKeyToEventFactory;
})();
