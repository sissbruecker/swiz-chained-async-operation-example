/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 13:04
 * To change this template use File | Settings | File Templates.
 */
package models {
import mx.collections.ArrayCollection;
import mx.collections.IList;

public class UserModel {

    [Bindable]
    public var users:IList;

    [Bindable]
    public var editedUser:User;

    [Bindable]
    public var assignedUsers:IList;

    public function UserModel() {
        users = new ArrayCollection();
        users.addItem(new User("John", "Doe"));
        users.addItem(new User("Jane", "Doe"));

        assignedUsers = new ArrayCollection();
    }

    public function update(user:User):void {

        for each(var existingUser:User in users) {

            if (existingUser.id == user.id) {
                existingUser.firstName = user.firstName;
                existingUser.lastName = user.lastName;
                return;
            }
        }

        users.addItem(user);
    }

    public function assign(user:User):void {

        for each(var assignedUser:User in assignedUsers) {

            if (assignedUser.id == user.id)
                return;
        }

        assignedUsers.addItem(user);
    }

    public function unassign(user:User):void {

        for each(var assignedUser:User in assignedUsers) {

            if (assignedUser.id == user.id)  {

                assignedUsers.removeItemAt(assignedUsers.getItemIndex(assignedUser));
                return;
            }
        }
    }
}
}
