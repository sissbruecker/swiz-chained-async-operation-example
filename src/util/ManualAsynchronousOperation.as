/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 13:29
 * To change this template use File | Settings | File Templates.
 */
package util {
import mx.rpc.IResponder;

import org.swizframework.utils.async.IAsynchronousOperation;

public class ManualAsynchronousOperation implements IAsynchronousOperation{

    private var _responders:Array = [];

    public function addResponder(responder:IResponder):void {
        _responders.push(responder);
    }

    public function complete(data:Object):void {

        for each(var responder:IResponder in _responders) {

            responder.result(data);
        }
    }

    public function fail(info:Object):void {

        for each(var responder:IResponder in _responders) {

            responder.fault(info);
        }
    }
}
}
