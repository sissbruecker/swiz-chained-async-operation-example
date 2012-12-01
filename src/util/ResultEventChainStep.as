/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package util {
import flash.events.Event;
import flash.events.IEventDispatcher;

import org.swizframework.utils.chain.EventChainStep;

public class ResultEventChainStep extends EventChainStep{

    private var _callBack:Function;
    private var _lastResult:*;

    public function ResultEventChainStep(event:Event, callBack:Function, dispatcher:IEventDispatcher = null) {
        super(event, dispatcher);

        this._callBack = callBack;
    }

    override protected function resultHandler(data:Object):void {

        _lastResult = data;

        super.resultHandler(data);
    }

    override public function complete():void {

        // Pass last result to callback
        if(_callBack != null) {
            _callBack(_lastResult);
        }

        super.complete();
    }
}
}
