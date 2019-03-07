import 'dart:html';

import 'package:react/src/react_client/synthetic_event2.dart';
import 'package:react/src/react_client/synthetic_event_wrappers.dart' as events;

typedef E SyntheticEventFactory<E extends SyntheticEvent2, JsE extends events.SyntheticEvent>(JsE e);

/// Wrapper for [SyntheticEvent2].
SyntheticEvent2 syntheticEvent2Factory(events.SyntheticEvent e) {
  return new SyntheticEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
  );
}

/// Wrapper for [SyntheticAnimationEvent2].
SyntheticEvent2 syntheticAnimationEvent2Factory(events.SyntheticAnimationEvent e) {
  return new SyntheticAnimationEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
      e.animationName,
      e.pseudoElement,
      e.elapsedTime,
  );
}

/// Wrapper for [SyntheticClipboardEvent2].
SyntheticClipboardEvent2 syntheticClipboardEvent2Factory(
    events.SyntheticClipboardEvent e) {
  return new SyntheticClipboardEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
    () => e.persist(),
      e.clipboardData,
  );
}

/// Wrapper for [SyntheticCompositionEvent2].
SyntheticEvent2 syntheticCompositionEvent2Factory(events.SyntheticCompositionEvent e) {
  return new SyntheticCompositionEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
      e.data,
  );
}

/// Wrapper for [SyntheticKeyboardEvent2].
SyntheticKeyboardEvent2 syntheticKeyboardEvent2Factory(
    events.SyntheticKeyboardEvent e) {
  return new SyntheticKeyboardEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
    () => e.persist(),
      e.altKey,
      e.char,
      e.charCode,
      e.ctrlKey,
      e.locale,
      e.location,
      e.key,
      e.keyCode,
      e.metaKey,
      e.repeat,
      e.shiftKey,
    (String modifierKey) => e.getModifierState(modifierKey),
  );
}

/// Wrapper for [SyntheticFocusEvent2].
SyntheticFocusEvent2 syntheticFocusEvent2Factory(events.SyntheticFocusEvent e) {
  return new SyntheticFocusEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
    () => e.persist(),
      e.relatedTarget,
  );
}

/// Wrapper for [SyntheticFormEvent2].
SyntheticFormEvent2 syntheticFormEvent2Factory(events.SyntheticFormEvent e) {
  return new SyntheticFormEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
    () => e.persist(),
  );
}

/// Wrapper for [SyntheticDataTransfer2].
SyntheticDataTransfer2 syntheticDataTransfer2Factory(
    events.SyntheticDataTransfer dt) {
  if (dt == null) return null;
  List<File> files = [];
  if (dt.files != null) {
    for (int i = 0; i < dt.files.length; i++) {
      files.add(dt.files[i]);
    }
  }
  List<String> types = [];
  if (dt.types != null) {
    for (int i = 0; i < dt.types.length; i++) {
      types.add(dt.types[i]);
    }
  }
  var effectAllowed;
  var dropEffect;

  try {
    // Works around a bug in IE where dragging from outside the browser fails.
    // Trying to access this property throws the error "Unexpected call to method or property access.".
    effectAllowed = dt.effectAllowed;
  } catch (exception) {
    effectAllowed = 'uninitialized';
  }

  try {
    // For certain types of drag events in IE (anything but ondragenter, ondragover, and ondrop), this fails.
    // Trying to access this property throws the error "Unexpected call to method or property access.".
    dropEffect = dt.dropEffect;
  } catch (exception) {
    dropEffect = 'none';
  }

  return new SyntheticDataTransfer2(dropEffect, effectAllowed, files, dt.items, types);
}

/// Wrapper for [SyntheticPointerEvent2].
SyntheticPointerEvent2 syntheticPointerEvent2Factory(
    events.SyntheticPointerEvent e) {
  return new SyntheticPointerEvent2(
    e.bubbles,
    e.cancelable,
    e.currentTarget,
    e.defaultPrevented,
    () => e.preventDefault(),
    () => e.stopPropagation(),
    e.eventPhase,
    e.isTrusted,
    e.nativeEvent,
    e.target,
    e.timeStamp,
    e.type,
    () => e.persist(),
    e.pointerId,
    e.width,
    e.height,
    e.pressure,
    e.tangentialPressure,
    e.tiltX,
    e.tiltY,
    e.twist,
    e.pointerType,
    e.isPrimary,
  );
}

/// Wrapper for [SyntheticMouseEvent2].
SyntheticMouseEvent2 syntheticMouseEvent2Factory(events.SyntheticMouseEvent e) {
  SyntheticDataTransfer2 dt = syntheticDataTransfer2Factory(e.dataTransfer);
  return new SyntheticMouseEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
      e.altKey,
      e.button,
      e.buttons,
      e.clientX,
      e.clientY,
      e.ctrlKey,
      dt,
      e.metaKey,
      e.pageX,
      e.pageY,
      e.relatedTarget,
      e.screenX,
      e.screenY,
      e.shiftKey,
    (String modifierKey) => e.getModifierState(modifierKey),
  );
}

/// Wrapper for [SyntheticTouchEvent2].
SyntheticTouchEvent2 syntheticTouchEvent2Factory(events.SyntheticTouchEvent e) {
  return new SyntheticTouchEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
      e.altKey,
      e.changedTouches,
      e.ctrlKey,
      e.metaKey,
      e.shiftKey,
      e.targetTouches,
      e.touches,
      (String modifierKey) => e.getModifierState(modifierKey),
  );
}



/// Wrapper for [SyntheticTransitionEvent2].
SyntheticEvent2 syntheticTransitionEvent2Factory(events.SyntheticTransitionEvent e) {
  return new SyntheticTransitionEvent2(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      () => e.persist(),
      e.propertyName,
      e.pseudoElement,
      e.elapsedTime,
  );
}

/// Wrapper for [SyntheticUIEvent].
SyntheticUIEvent syntheticUIEventFactory(events.SyntheticUIEvent e) {
  return new SyntheticUIEvent(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      e.detail,
      e.view);
}

/// Wrapper for [SyntheticWheelEvent].
SyntheticWheelEvent syntheticWheelEventFactory(events.SyntheticWheelEvent e) {
  return new SyntheticWheelEvent(
      e.bubbles,
      e.cancelable,
      e.currentTarget,
      e.defaultPrevented,
      () => e.preventDefault(),
      () => e.stopPropagation(),
      e.eventPhase,
      e.isTrusted,
      e.nativeEvent,
      e.target,
      e.timeStamp,
      e.type,
      e.deltaX,
      e.deltaMode,
      e.deltaY,
      e.deltaZ);
}
