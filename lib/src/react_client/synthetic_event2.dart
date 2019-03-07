/// Public `SyntheticEvent` API for use with [Component2]
library react_client.synthetic_event_2;

import 'dart:html';

import 'package:meta/meta.dart';

// TODO: Determine if we should be exporting synthetic_event2_factories.dart as well.
export 'package:react/src/react_client/synthetic_event.dart';

/// Properties shared between `SyntheticEvent` classes like [SyntheticKeyboardEvent2] and [SyntheticMouseEvent2].
mixin _SyntheticEventKeyModifierProperties {
  /// Whether the "Alt" (<kbd>option</kbd> or <kbd>⌥</kbd> on OS X) key was active when an `Event` occurs.
  bool get altKey;

  /// Whether the "Control" (<kbd>^</kbd> on OS X) key was active when an `Event` occurs.
  bool get ctrlKey;

  /// Whether the "Meta" (<kbd>⌘ Command</kbd> on OS X, <kbd>⊞ Windows</kbd> on Windows) key was active
  /// when an `Event` occurs.
  bool get metaKey;

  /// Whether the <kbd>shift</kbd> key was active when an `Event` occurs.
  bool get shiftKey;

  /// Returns the current state of the specified [modifierKey] -
  /// `true` if the modifier is active _(that is the modifier key is pressed or locked)_,
  /// otherwise, `false`.
  ///
  /// The `modifierKey` must be a [valid modifier key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values#Modifier_keys).
  bool getModifierState(String modifierKey) => _getModifierState(modifierKey);
  bool Function(String modifierKey) _getModifierState;
}

/// Properties shared between `SyntheticEvent` classes that implement `relatedTarget`.
mixin _SyntheticEventRelatedTargetProperties {
  /// Represents a secondary `target` for the event, which will depend on the event itself.
  ///
  /// In some cases _(like when tabbing in or out of a page)_, this property may be set to `null` for security reasons.
  EventTarget get relatedTarget;
}

/// A cross-browser wrapper around the [nativeEvent].
///
/// It has the same interface as the browser's native event, including [stopPropagation] and [preventDefault],
/// except the events work identically across all browsers.
///
/// __Designed for use only with [Component2], not [Component].__
///
/// > See: <https://reactjs.org/docs/events.html>
class SyntheticEvent2<E extends Event> {
  /// Indicates whether the [Event] bubbles up through the DOM or not.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles>
  final bool bubbles;

  /// Indicates whether the [Event] is cancelable or not.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable>
  final bool cancelable;

  /// Identifies the current target for the event, as the `Event` traverses the DOM.
  ///
  /// It always refers to the `EventTarget` the `Event` handler has been attached to
  /// as opposed to [target] which identifies the `EventTarget` on which the `Event` occurred.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget>
  final EventTarget currentTarget;

  /// Indicates whether [preventDefault] was called on the `Event`.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented>
  bool get defaultPrevented => _defaultPrevented;
  bool _defaultPrevented;

  /// Indicates whether [preventDefault] was called on the `Event`.
  ///
  /// > See: <https://reactjs.org/docs/events.html>
  bool isDefaultPrevented() => _defaultPrevented;

  /// Cancels the `Event` if it is [cancelable], without stopping further propagation of the event.
  ///
  /// > Related [stopPropagation]
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault>
  void preventDefault() {
    _defaultPrevented = true;
    _preventDefault();
  }
  final void Function() _preventDefault;

  /// Indicates whether [stopPropagation] was called on the `Event`.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented>
  bool get propagationStopped => _propagationStopped;
  bool _propagationStopped;

  /// Indicates whether [stopPropagation] was called on the `Event`.
  ///
  /// > See: <https://reactjs.org/docs/events.html>
  bool isPropagationStopped() => _propagationStopped;

  /// Prevents further propagation of the current `Event` in the capturing and bubbling [eventPhase]s.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation>
  void stopPropagation() {
    _propagationStopped = true;
    _stopPropagation();
  }
  final void Function() _stopPropagation;

  /// Indicates which phase of the [Event] flow is currently being evaluated.
  ///
  /// Possible values:
  ///
  /// 1. [Event.CAPTURING_PHASE]
  ///
  ///   * The [Event] is being propagated through the [target]'s ancestor objects.
  ///   * This process starts with the [window], then [HtmlDocument], then the [HtmlHtmlElement],
  ///     and so on through the [Element]s until the [target]'s parent is reached.
  ///   * [EventListener]s registered for capture mode when [EventTarget.addEventListener] was called
  ///     are triggered during this phase.
  ///
  /// 2. [Event.AT_TARGET]
  ///
  ///   * The [Event] has arrived at the [target].
  ///   * [EventListener]s registered for this phase are called at this time.
  ///   * If [bubbles] is `false`, processing of the [Event] is finished after this phase completes.
  ///
  /// 3. [Event.BUBBLING_PHASE]
  ///
  ///   * The [Event] is propagating back up through the [target]'s ancestors in reverse order,
  ///     starting with the parent, and eventually reaching the containing [window].
  ///     This is known as bubbling, and occurs only if [bubbles] is `true`.
  ///   * [EventListener]s registered for this phase are triggered during this process.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase>
  final num eventPhase;

  /// Is `true` when the [Event] was generated by a user action, and `false` when the [Event] was created or modified
  /// by a script or dispatched via [Event.dispatchEvent].
  ///
  /// __Read Only__
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted>
  final bool isTrusted;

  /// Native browser event that `SyntheticEvent2` wraps around.
  E get nativeEvent => _nativeEvent;
  covariant E _nativeEvent;

  /// A reference to the object that dispatched the event. It is different from [currentTarget] when the [Event]
  /// handler is called when [eventPhase] is [Event.BUBBLING_PHASE] or [Event.CAPTURING_PHASE].
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/target>
  final EventTarget target;

  /// Returns the [Time] (in milliseconds) at which the [Event] was created.
  ///
  /// _Starting with Chrome 49, returns a high-resolution monotonic time instead of epoch time._
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp>
  final num timeStamp;

  /// Returns a string containing the type of event. It is set when the [Event] is constructed and is the name commonly
  /// used to refer to the specific event.
  ///
  /// See: <https://developer.mozilla.org/en-US/docs/Web/API/Event/type>
  final String type;

  /// Call to allow access on this instance's properties in an asynchronous way
  /// by removing the event from the "pool" and allowing references to be retained by user code.
  ///
  /// By default, a `SyntheticEvent` is pooled for performance reasons.
  ///
  /// This means that the JS `SyntheticEvent` object will be reused and all properties will be nullified
  /// after the event callback has been invoked. As such, you cannot access the event in an asynchronous way
  /// unless you call this method first.
  ///
  /// > See: <https://reactjs.org/docs/events.html#event-pooling>
  void persist() => _persist();
  final void Function() _persist;

  SyntheticEvent2(
    this.bubbles,
    this.cancelable,
    this.currentTarget,
    this._defaultPrevented,
    this._preventDefault,
    this._stopPropagation,
    this.eventPhase,
    this.isTrusted,
    this._nativeEvent,
    this.target,
    this.timeStamp,
    this.type,
    this._persist,
  );
}

/// A cross-browser wrapper around the `AnimationEvent` [nativeEvent] interface that represents
/// events that provide information related to CSS animations.
///
/// > See: <https://reactjs.org/docs/events.html#animation-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent>
class SyntheticAnimationEvent2 extends SyntheticEvent2<AnimationEvent> {
  /// The value of the `animation-name` CSS property associated with the animation.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent/animationName>
  final String animationName;

  /// A string (starting with `::`), containing the name of the pseudo-element the animation runs on.
  ///
  /// If the animation doesn't run on a pseudo-element but on the element, an empty string will be returned.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent/pseudoElement>
  final String pseudoElement;

  /// The amount of time the animation has been running, in seconds, when this event fired, excluding any time
  /// the animation was paused.
  ///
  /// For an `animationstart` event, elapsedTime is `0.0` unless there was a negative value for `animation-delay`,
  /// in which case the event will be fired with `elapsedTime` containing `(-1 * delay)`.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent/elapsedTime>
  final num elapsedTime;

  SyntheticAnimationEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    AnimationEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.animationName,
    this.pseudoElement,
    this.elapsedTime,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `ClipboardEvent` [nativeEvent] interface that represents
/// events providing information related to modification of the clipboard, that is cut, copy, and paste events.
///
/// > See: <https://reactjs.org/docs/events.html#clipboard-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/ClipboardEvent>
class SyntheticClipboardEvent2 extends SyntheticEvent2<ClipboardEvent> {
  /// A `DataTransfer` containing the data concerned by the clipboard event.
  final DataTransfer clipboardData;

  SyntheticClipboardEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    ClipboardEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.clipboardData,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `CompositionEvent` [nativeEvent] interface that represents
/// events that occur due to the user indirectly entering text.
///
/// > See: <https://reactjs.org/docs/events.html#composition-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent>
class SyntheticCompositionEvent2 extends SyntheticEvent2<CompositionEvent> {
  /// The characters generated by the input method that raised the event.
  ///
  /// Varies depending on the type of event that generated the [CompositionEvent].
  final String data;

  SyntheticCompositionEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    CompositionEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.data,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `KeyboardEvent` [nativeEvent] interface
/// that describe a user interaction with the keyboard.
///
/// Each event describes a single interaction between the user and a [key]
/// _(or combination of a key with modifier keys like [altKey], [metaKey], [ctrlKey] and/or [shiftKey])_
/// on the keyboard.
///
/// The event [type] (keydown, keypress, or keyup) identifies what kind of keyboard activity occurred.
///
/// > See: <https://reactjs.org/docs/events.html#keyboard-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent>
class SyntheticKeyboardEvent2 extends SyntheticEvent2<KeyboardEvent> with _SyntheticEventKeyModifierProperties {
  @override final bool altKey;
  @override final bool ctrlKey;
  @override final bool metaKey;
  @override final bool shiftKey;
  @override final bool Function(String modifierKey) _getModifierState;

  /// Returns a string representing a locale string indicating the locale the keyboard is configured for.
  ///
  /// This may be the empty string if the browser or device doesn't know the keyboard's locale.
  ///
  /// > __NOTE:__ This does not describe the locale of the data being entered.
  ///   A user may be using one keyboard layout while typing text in a different language.
  final String locale;

  /// Returns a number representing the location of the [key] on the keyboard or other input device.
  ///
  /// Possible values:
  ///
  /// * [KeyboardEvent.DOM_KEY_LOCATION_LEFT]
  /// * [KeyboardEvent.DOM_KEY_LOCATION_NUMPAD]
  /// * [KeyboardEvent.DOM_KEY_LOCATION_RIGHT]
  /// * [KeyboardEvent.DOM_KEY_LOCATION_STANDARD]
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location>
  final num location;

  /// Whether the given key is being held down such that it is automatically repeating.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat>
  final bool repeat;

  /// Returns the value of the key pressed by the user while taking into considerations
  /// the state of modifier keys such as the [shiftKey] as well as the keyboard [locale]/layout.
  ///
  /// Its value is determined as follows:
  ///
  /// * If the pressed key has a printed representation, the returned value is a non-empty Unicode character
  ///   string containing the printable representation of the key.
  ///
  /// * If the pressed key is a control or special character, the returned value is one of the pre-defined key values.
  ///
  /// * If the [KeyboardEvent] represents the press of a dead key, the key value must be "Dead".
  ///
  /// * Some specialty keyboard keys (such as the extended keys for controlling media on multimedia keyboards)
  ///   don't generate key codes on Windows; instead, they trigger `WM_APPCOMMAND` events.
  ///   These events get mapped to DOM keyboard events, and are listed among the "Virtual key codes" for Windows,
  ///   even though they aren't actually key codes.
  ///
  /// * If the key cannot be identified, the returned value is "Unidentified".
  ///
  /// [KeyCode]
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key>
  final String key;

  /// A system and implementation dependent numerical code identifying the unmodified value of the pressed key.
  ///
  /// > See: Possible [KeyCode] values
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode>
  final num keyCode;

  /// The character value of the [key].
  ///
  /// * If the [key] corresponds to a printable character,
  ///   this value is a non-empty Unicode string containing that character.
  ///
  /// * If the [key] doesn't have a printable representation, this is an empty string.
  ///
  /// __DEPRECATED.__ This should no longer be used.
  @deprecated
  @experimental
  final String char;

  /// __DEPRECATED.__ Use [keyCode] instead.
  @deprecated
  @experimental
  final num charCode;

  SyntheticKeyboardEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    KeyboardEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.altKey,
    this.char,
    this.charCode,
    this.ctrlKey,
    this.locale,
    this.location,
    this.key,
    this.keyCode,
    this.metaKey,
    this.repeat,
    this.shiftKey,
    this._getModifierState,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `FocusEvent` [nativeEvent] interface
/// that represents focus-related event [type]s like `focus`, `blur`, `focusin`, or `focusout`.
///
/// > See: <https://reactjs.org/docs/events.html#focus-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent>
class SyntheticFocusEvent2 extends SyntheticEvent2<FocusEvent> with _SyntheticEventRelatedTargetProperties {
  @override final EventTarget relatedTarget;

  SyntheticFocusEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    FocusEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.relatedTarget,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around an `Event` [nativeEvent] interface
/// that represents form-related event [type]s like `change`, `input`, `invalid`, or `submit`.
///
/// > See: <https://reactjs.org/docs/events.html#form-events>
class SyntheticFormEvent2 extends SyntheticEvent2<Event> {
  SyntheticFormEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    Event nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// See: <https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer>
class SyntheticDataTransfer2 {
  final String dropEffect;
  final String effectAllowed;
  final List<File> files;
  final DataTransferItemList items;
  final List<String> types;

  SyntheticDataTransfer2(
    this.dropEffect,
    this.effectAllowed,
    this.files,
    this.items,
    this.types,
  );
}

/// A cross-browser wrapper around the `MouseEvent` [nativeEvent] interface
/// that occur due to the user interacting with a pointing device _(such as a mouse)_.
///
/// Common events using this interface include `click`, `dblclick`, `mouseup` and `mousedown`.
///
/// > Several more specific events are based on `MouseEvent`, including `WheelEvent` and `DragEvent`.
///
/// > See: <https://reactjs.org/docs/events.html#mouse-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent>
class SyntheticMouseEvent2 extends SyntheticEvent2<MouseEvent>
    with _SyntheticEventKeyModifierProperties, _SyntheticEventRelatedTargetProperties {
  @override final EventTarget relatedTarget;
  @override final bool altKey;
  @override final bool ctrlKey;
  @override final bool metaKey;
  @override final bool shiftKey;
  @override final bool Function(String modifierKey) _getModifierState;

  /// Indicates which button was pressed on the mouse to trigger the event.
  ///
  /// This property only guarantees to indicate which buttons are pressed during events caused by
  /// pressing or releasing one or multiple buttons. As such, it is not reliable for event [type]s such
  /// as `mouseenter`, `mouseleave`, `mouseover`, `mouseout` or `mousemove`.
  ///
  /// > __NOTE:__ Do not confuse this with [buttons], which indicates which buttons are pressed
  ///   for _all_ mouse events types.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button>
  final int button;

  /// Indicates which buttons are pressed on the mouse _(or other input device)_ when a mouse event is triggered.
  ///
  /// Each button that can be pressed is represented by a given number. If more than one button is pressed,
  /// the button values are added together to produce a new number.
  ///
  /// > __NOTE:__ Do not confuse this with [button], which only guarantees the correct value for
  ///   mouse events caused by pressing or releasing one or multiple buttons.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons>
  final int buttons;

  /// Provides the horizontal coordinate within the application's client area at which the event occurred
  /// _(as opposed to the coordinate within the page)_.
  ///
  /// For example, clicking on the left edge of the client area will always result in a mouse event with a
  /// `clientX` value of 0, regardless of whether the page is scrolled horizontally _(unlike [pageX])_.
  final num clientX;

  /// Provides the vertical coordinate within the application's client area at which the event occurred
  /// _(as opposed to the coordinate within the page)_.
  ///
  /// For example, clicking on the top edge of the client area will always result in a mouse event with a
  /// `clientY` value of 0, regardless of whether the page is scrolled vertically _(unlike [pageY])_.
  final num clientY;

  /// Provides the horizontal coordinate at which the mouse event occurred,
  /// relative to the left edge of the entire document.
  ///
  /// Unlike [clientX], this includes any portion of the document
  /// not currently visible when the page is scrolled horizontally.
  final num pageX;

  /// Provides the vertical coordinate at which the mouse event occurred,
  /// relative to the left edge of the entire document.
  ///
  /// Unlike [clientY], this includes any portion of the document
  /// not currently visible when the page is scrolled vertically.
  final num pageY;

  /// Provides the global (screen) horizontal coordinate at which the mouse event occurred.
  final num screenX;

  /// Provides the global (screen) vertical coordinate at which the mouse event occurred.
  final num screenY;

  // TODO: Why is this here? I don't see `dataTransfer` in the React synthetic event spec or in the MDN spec for the native event.
  final SyntheticDataTransfer2 dataTransfer;

  SyntheticMouseEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    MouseEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.altKey,
    this.button,
    this.buttons,
    this.clientX,
    this.clientY,
    this.ctrlKey,
    this.dataTransfer,
    this.metaKey,
    this.pageX,
    this.pageY,
    this.relatedTarget,
    this.screenX,
    this.screenY,
    this.shiftKey,
    this._getModifierState,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `PointerEvent` [nativeEvent] interface
/// that represents the state of a DOM event produced by a pointer such as the
/// geometry of the contact point, the device type that generated the event,
/// the amount of pressure that was applied on the contact surface, etc.
///
/// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent> and
///   <https://reactjs.org/docs/events.html#pointer-events>
class SyntheticPointerEvent2 extends SyntheticEvent2<PointerEvent> {
  /// A unique identifier for the pointer causing the event.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId>
  final num pointerId;

  /// The width (magnitude on the X axis), in CSS pixels, of the contact geometry of the pointer.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width>
  final num width;

  /// The height (magnitude on the Y axis), in CSS pixels, of the contact geometry of the pointer.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height>
  final num height;

  /// The normalized pressure of the pointer input in the range 0 to 1,
  /// where 0 and 1 represent the minimum and maximum pressure the hardware is capable of detecting, respectively.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure>
  final num pressure;

  /// The normalized tangential pressure of the pointer input (also known as barrel pressure or cylinder stress)
  /// in the range -1 to 1, where 0 is the neutral position of the control.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure>
  final num tangentialPressure;

  /// The plane angle (in degrees, in the range of -90 to 90) between the Y-Z plane and the plane
  /// containing both the transducer (e.g. pen stylus) axis and the Y axis.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX>
  final num tiltX;

  /// The plane angle (in degrees, in the range of -90 to 90) between the X-Z plane and the plane
  /// containing both the transducer (e.g. pen stylus) axis and the X axis.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY>
  final num tiltY;

  /// The clockwise rotation of the transducer (e.g. pen stylus) around its major axis in degrees,
  /// with a value in the range 0 to 359.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist>
  final num twist;

  /// Indicates the device type that caused the event (mouse, pen, touch, etc.)
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType>
  final String pointerType;

  /// Indicates if the pointer represents the primary pointer of this pointer type.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary>
  final bool isPrimary;

  SyntheticPointerEvent2(
    bool bubbles,
    bool cancelable,
    dynamic currentTarget,
    bool defaultPrevented,
    dynamic preventDefault,
    dynamic stopPropagation,
    num eventPhase,
    bool isTrusted,
    dynamic nativeEvent,
    dynamic target,
    num timeStamp,
    String type,
    void Function() persist,
    this.pointerId,
    this.width,
    this.height,
    this.pressure,
    this.tangentialPressure,
    this.tiltX,
    this.tiltY,
    this.twist,
    this.pointerType,
    this.isPrimary,
  ) : super(
            bubbles,
            cancelable,
            currentTarget,
            defaultPrevented,
            preventDefault,
            stopPropagation,
            eventPhase,
            isTrusted,
            nativeEvent,
            target,
            timeStamp,
            type,
    persist,
  ) {}
}

/// A cross-browser wrapper around the `TouchEvent` [nativeEvent] interface
/// that represents an event sent when the state of contacts with a touch-sensitive surface changes.
///
/// This surface can be a touch screen or trackpad, for example.
///
/// The event can describe one or more points of contact with the screen and includes support for detecting movement,
/// addition and removal of contact points, and so forth.
///
/// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent> and
///   <https://reactjs.org/docs/events.html#touch-events>
class SyntheticTouchEvent2 extends SyntheticEvent2<TouchEvent> with _SyntheticEventKeyModifierProperties {
  @override final bool altKey;
  @override final bool ctrlKey;
  @override final bool metaKey;
  @override final bool shiftKey;
  @override final bool Function(String modifierKey) _getModifierState;

  /// All the [Touch] objects representing individual points of contact
  /// whose states changed between the previous touch event and this one.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent/changedTouches>
  final TouchList changedTouches;

  /// All the [Touch] objects that are both currently in contact with the touch
  /// surface __and__ were also started on the same element that is the [target] of the event.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent/targetTouches>
  final TouchList targetTouches;

  /// All the [Touch] objects representing all current points of contact
  /// with the surface, regardless of [target] or changed status.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent/touches>
  final TouchList touches;

  SyntheticTouchEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    Event nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.altKey,
    this.changedTouches,
    this.ctrlKey,
    this.metaKey,
    this.shiftKey,
    this.targetTouches,
    this.touches,
    this._getModifierState,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `TransitionEvent` [nativeEvent] interface that represents
/// events that provide information related to CSS animations.
///
/// > See: <https://reactjs.org/docs/events.html#animation-events> and
///   <https://developer.mozilla.org/en-US/docs/Web/API/TransitionEvent>
class SyntheticTransitionEvent2 extends SyntheticEvent2<TransitionEvent> {
  /// The value of the `animation-name` CSS property associated with the transition.
  final String propertyName;

  /// A string (starting with `::`), containing the name of the pseudo-element the transition runs on.
  ///
  /// If the transition doesn't run on a pseudo-element but on the element, an empty string will be returned.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TransitionEvent/pseudoElement>
  final String pseudoElement;

  /// The amount of time the CSS `transition` has been running, in seconds, when this event fired.
  ///
  /// This value is not affected by the `transition-delay` CSS property value.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/TransitionEvent/elapsedTime>
  final num elapsedTime;

  SyntheticTransitionEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    TransitionEvent nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.propertyName,
    this.pseudoElement,
    this.elapsedTime,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `UIEvent` [nativeEvent] interface
/// that represents simple user interface events like `scroll`.
///
/// > See: <https://developer.mozilla.org/en-US/docs/Web/API/UIEvent> and
///   <https://reactjs.org/docs/events.html#ui-events>
class SyntheticUIEvent2 extends SyntheticEvent2<UIEvent> {
  /// Provides the current (or next, depending on the event) click count.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail>
  final num detail;

  /// Returns the `Window` from which the event was generated.
  final Window view;

  SyntheticUIEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    Event nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.detail,
    this.view,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}

/// A cross-browser wrapper around the `WheelEvent` [nativeEvent] interface
/// that represents events that occur due to the user moving a mouse wheel
/// or similar input device.
///
/// > See: <https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent> and
///   <https://reactjs.org/docs/events.html#wheel-events>
class SyntheticWheelEvent2 extends SyntheticEvent2<WheelEvent> {
  /// The unit of the `delta*` values' scroll amount.
  ///
  /// Possible values:
  ///
  /// * [WheelEvent.DOM_DELTA_PIXEL]
  /// * [WheelEvent.DOM_DELTA_LINE]
  /// * [WheelEvent.DOM_DELTA_PAGE]
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode>
  final num deltaMode;

  /// The horizontal scroll amount.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX>
  final num deltaX;

  /// The vertical scroll amount.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY>
  final num deltaY;

  /// The z-axis scroll amount.
  ///
  /// > See: <https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ>
  final num deltaZ;

  SyntheticWheelEvent2(
    bool bubbles,
    bool cancelable,
    EventTarget currentTarget,
    bool defaultPrevented,
    void Function() preventDefault,
    void Function() stopPropagation,
    num eventPhase,
    bool isTrusted,
    Event nativeEvent,
    EventTarget target,
    num timeStamp,
    String type,
    void Function() persist,
    this.deltaX,
    this.deltaMode,
    this.deltaY,
    this.deltaZ,
  )
      : super(
          bubbles,
          cancelable,
          currentTarget,
          defaultPrevented,
          preventDefault,
          stopPropagation,
          eventPhase,
          isTrusted,
          nativeEvent,
          target,
          timeStamp,
          type,
          persist,
        );
}
