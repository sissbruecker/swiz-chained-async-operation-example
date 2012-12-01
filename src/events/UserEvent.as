/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */
package events {
import models.User;

import org.swizframework.utils.async.AsynchronousEvent;

public class UserEvent extends AsynchronousEvent{

    public static const ADD:String = "userAdd";
    public static const ADD_AND_ASSIGN:String = "userAddAndAssign";
    public static const EDIT:String = "userEdit";
    public static const SAVE:String = "userSave";
    public static const CANCEL:String = "userCancel";
    public static const ASSIGN:String = "userAssign";
    public static const UNASSIGN:String = "userUnassign";

    public var user:User;

    public function UserEvent(type:String, user:User = null) {
        super(type, true);
        this.user = user;
    }
}
}
