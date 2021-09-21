Signals: Think Outside the Event.
=================================

**Signals** are light-weight, strongly-typed AS3 messaging tools.\
Wire your application with better APIs and less boilerplate than AS3
Events.

Concept
-------

 * A **Signal** is essentially a mini-dispatcher specific to one event, with its own array of listeners.
 * A Signal gives an event a concrete membership in a class.
 * Listeners subscribe to real objects, not to string-based channels.
 * Event string constants are no longer needed.
 * Signals are inspired by [C\# events](http://en.wikipedia.org/wiki/C_Sharp_syntax#Events) and [signals/slots](http://en.wikipedia.org/wiki/Signals_and_slots) in Qt.

Syntax
------

    // with EventDispatcher
    button.addEventListener(MouseEvent.CLICK, onClick);

    // Signal equivalent; past tense is recommended
    button.clicked.add(onClicked);

I am still looking for impressions, critiques and suggestions.\
My email is robert *at* robertpenner.com.\
I'm [\@robpenner on Twitter](http://twitter.com/robpenner).

Background on AS3 Events
------------------------

 * [My Critique of AS3 Events - Part 1](http://flashblog.robertpenner.com/2009/08/my-critique-of-as3-events-part-1.html)
 * [AS3 Events - 7 things I've learned from community](http://flashblog.robertpenner.com/2009/09/as3-events-7-things-ive-learned-from.html)
 * [My Critique of AS3 Events - Part 2](http://flashblog.robertpenner.com/2009/09/my-critique-of-as3-events-part-2.html)
