package org.osflash.signals.natives.sets {
	import flash.net.URLStream;
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * @author Jon Adams
	 */
	public class URLStreamSignalSet extends EventDispatcherSignalSet {

		public var complete:NativeSignal;
		public var httpStatus:NativeSignal;
		public var ioError:NativeSignal;
		public var open:NativeSignal;
		public var progress:NativeSignal;
		public var securityError:NativeSignal;

		public function URLStreamSignalSet(target:URLStream) {
			super(target);
			_signals.push(complete = new NativeSignal(target, Event.COMPLETE, Event));
		}
	}
}