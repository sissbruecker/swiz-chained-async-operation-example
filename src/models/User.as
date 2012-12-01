/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 13:04
 * To change this template use File | Settings | File Templates.
 */
package models {
import mx.utils.UIDUtil;

public class User {

    [Bindable]
    public var id:String;
    [Bindable]
    public var firstName:String;
    [Bindable]
    public var lastName:String;

    public function get label():String {
        return firstName + " " + lastName;
    }

    public function User(firstName:String, LastName:String, id:String = null) {
        this.id = id != null ? id : UIDUtil.createUID();
        this.firstName = firstName;
        this.lastName = LastName;
    }
}
}
