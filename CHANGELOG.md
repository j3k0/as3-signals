AS3 Signals Changelog:
----------------------

### v0.9 - NeufGun

#### API Additions

-   ISlot: listener registration object with many features.
    -   A slot stores values of **once** and **priority**, replacing the
        untyped "listener box" objects.
    -   A slot can **remove()** its listener from the signal.
    -   Has **enabled** toggle to temporarily disconnect the listener
        without removing it.
    -   The slot's **listener** can be changed on the fly.
    -   Has optional array of **params** which are appended to the
        signal's dispatched values before reaching the listener. Similar
        to delegates that store extra args.
-   IOnceSignal: has **addOnce()** but not **add()**. Useful for
    completion signals that discard all listeners on dispatch. Idea by
    `alecmce.
    * MonoSignal: can have only one listener. Useful for callbacks and SignalCommandMap request signals. Originally implemented as SingleSignal by `stickupkid.
-   PrioritySignal: like DeluxeSignal without bubbling (thanks
    `neilmanuell).
    * Native Signal Sets: 
    ** `jonopus developed an easy way to snap on NativeSignals to
    Sprite, Timer, etc. See **org.osflash.signals.natives.sets**
    package.
    -   Created SignalSprite, SignalTimer, etc. as example base classes.
        See **org.osflash.signals.natives.base** package.

#### API Changes

-   Removed ISignalOwner, INativeSignalOwner and IDispatcher. They
    became annoying, e.g. casting ISignal to Signal just to dispatch.
    Moved their methods into ISignal.
-   **add()**, **addOnce()** and **remove()** now return ISlot.

#### Implementation Changes

-   add() no longer checks listener.length because ...varargs listeners
    cannot be detected.
-   Dispatching
    -   \@joa created a new, faster dispatching engine (SlotList) using
        an immutable recursive linked list (inspired by Scala). The list
        is like a snake which gets eaten by a snake, which gets eaten by
        a larger snake, and so on.
    -   NOTE: Listeners are now called in reverse order, for best
        performance. If precise order is needed, use an IPrioritySignal.
-   Enhanced MXML friendliness (ArrayElementType, better examples).
-   More inheritance between signals to reduce code duplication.

#### Fixes

-   DeluxeSignal: now handles subclass super() calls properly (thanks
    `stickupkid).
    * NativeRelaySignal: better checks for null (thanks `stickupkid).

#### Tests

-   Increased test coverage significantly. Many tests from \@stickupkid.
-   Refactored duplicated test code into base classes, e.g.
    ISignalTestBase. This greatly increased coverage across various
    implementations.

#### Build

-   Build now has a "package" target to zip SWC and source together.
-   Build now has a "clean" target to remove generated folders.
-   Flash Player executes on Linux (thanks \@joa).

### v0.8 - Maximilian - 2010-11-14

#### API Changes

-   Signals are now MXML-friendly! Example:\
    `<code>`{=html}\
    `<signals:Signal id="nameChanged">`{=html}{\[String,
    uint\]}`</signals:Signal>`{=html}\
    `</code>`{=html}
    -   Constructors are now nullable.
    -   valueClasses and eventClass are now writable.
    -   Exceptions: NativeMappedSignal and NativeRelaySignal are not yet
        MXML-friendly.
-   Renamed IDeluxeSignal to IPrioritySignal, a more functional name.
-   New interfaces to grant access to methods that affect all listeners:
    -   ISignalOwner: extends ISignal, IDispatcher, adds removeAll().
    -   INativeSignalOwner: extends IPrioritySignal, INativeDispatcher,
        adds removeAll().
    -   These 2 interfaces cannot be merged because
        dispatch(event:Event) conflicts with dispatch(...valueObjects).
    -   Thanks to [Brian Heylin](http://github.com/brianheylin) for
        getting the ball rolling.

#### Fixes

-   [\#24 - Changing NativeSignal.target wasn't removing listeners from
    target.](http://github.com/robertpenner/as3-signals/issues/closed#issue/24)
-   [\#32 - FIX: Setting NativeSignal.eventClass to null and dispatching
    causes null
    exception.](http://github.com/robertpenner/as3-signals/issues/closed#issue/32)

#### Build

-   Added continuous integration and unit test execution Ant targets:
    "ci" and "test".
-   Updated AsUnit 4 SWC: test failure call stack is more concise and
    readable.
-   Removed build-asunit.xml as its functionality has been merged into
    build.xml.

### v0.7 - Bubblap - 2010-05-27

#### API Changes

-   Added NativeMappedSignal class from [Brian
    Heylin](http://github.com/brianheylin), with great [test
    coverage](http://github.com/brianheylin/as3-signals/tree/master/tests/org/osflash/signals/natives/).
    -   Addresses [\#16 - Add ability to map native events to
        signals](http://github.com/robertpenner/as3-signals/issues/closed#issue/16)
-   DeluxeSignal has a simpler way to continue bubbling without
    re-dispatching the event.
    -   IBubbleEventHandler.onEventBubbled() now returns true/false to
        continue/cancel bubbling.
    -   Thanks to [secoif](http://github.com/secoif) for the original
        code and [dehash](http://www.dehash.com/?p=241h) for helping
        with the merge.
-   ISignal and IDeluxeSignal: add(), addOnce() and remove() now return
    the listener.
    -   Thanks to [sammyt](http://github.com/sammyt) for the
        contribution with unit tests.

#### Fixes

-   Improved error message for Signal.dispatch() with too few arguments.

#### Test Changes

-   The test suite is migrated to a newer version of AsUnit 4.
    -   Tests now receive an IAsync using \[Inject\]. No more
        Asyncleton!
    -   The migration pattern can be seen in [commit
        f6878.](http://github.com/robertpenner/as3-signals/commit/f6878dbbff95e0bd7832cc2d1cc2e7d55fb18098)
    -   AllTestsRunner uses a [new composition
        pattern](http://github.com/robertpenner/as3-signals/commit/866a99570152b7399aa34839fd5c30789db67f3c)
        instead of inheritance.
    -   Many thanks to [Luke Bayes](http://github.com/lukebayes) and the
        [Bay Area Computer Club](http://github.com/bayareacomputerclub).
-   Added more tests for argument dispatching and consolidated in
    SignalDispatchArgsTest.

### v0.6 - GreenDay - 2010-03-17

#### API Changes

-   [\#15 - IDeluxeSignal and NativeSignal now have valueClasses
    property](http://github.com/robertpenner/as3-signals/issues/closed#issue/15)

#### Fixes

-   [\#14 - NativeSignal.addOnce() can't be reused after native event
    dispatched](http://github.com/robertpenner/as3-signals/issues/closed#issue/14)

#### Implementation Changes

-   Optimized listeners array cloning to use slice(), which is faster
    than concat().
-   Optimized dispatch() by moving the cloning of listeners to add(),
    addOnce(), and remove().
-   Signal.removeAll() now uses remove() on every listener, instead of
    fast array clearing. This is intended to avoid possible issues with
    subclass overrides (as happened before with
    NativeRelaySignal.remove()).
-   Renamed createListenerRelationship() to registerListener().
-   Consolidated add() and addOnce() logic in registerListener().
-   Removed onceListeners Dictionary from DeluxeSignal and NativeSignal.
-   DeluxeSignal and NativeSignal are now more unified in their "once
    listeners" internal implementations.
-   Removed an extra semicolon which made FDT cry (thanks
    [vitch](http://github.com/vitch)).

#### Test Changes

-   Removed async \[Test\] metadata because AsUnit 4 no longer uses it.
-   Updated the AsUnit 4 SWC to newer version which avoids slowdown of
    Timers in Flash Player 10.1.
-   Added tests for ambiguous relationships in Signal.
-   Added tests for adding a listener during a dispatch().

### v0.5 - GlassHalfFull - 2010-02-08

-   Added versioning to the Ant build, starting at 0.5.
