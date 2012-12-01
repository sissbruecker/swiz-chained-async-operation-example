/**
 * Created with IntelliJ IDEA.
 * User: Sascha
 * Date: 01.12.12
 * Time: 13:07
 * To change this template use File | Settings | File Templates.
 */
package controllers {
import events.UserEvent;

import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

import models.User;
import models.UserModel;

import mx.core.FlexGlobals;
import mx.managers.PopUpManager;

import org.swizframework.core.ISwiz;
import org.swizframework.core.ISwizAware;
import org.swizframework.utils.async.IAsynchronousOperation;
import org.swizframework.utils.chain.EventChain;
import org.swizframework.utils.chain.EventChainStep;

import util.ResultEventChainStep;
import util.ManualAsynchronousOperation;

import views.UserDetailView;

public class UserController implements ISwizAware {

    private var _swiz:ISwiz;

    public function set swiz(value:ISwiz):void {
        _swiz = value;
    }

    [Dispatcher]
    public var dispatcher:IEventDispatcher;

    [Inject]
    public var model:UserModel;

    // region Event handling

    [EventHandler(event="UserEvent.ADD")]
    public function create():IAsynchronousOperation {

        var user:User = new User("New", "New");

        return edit(user);
    }

    [EventHandler(event="UserEvent.EDIT", properties="user")]
    public function edit(user:User):IAsynchronousOperation {

        finishEditOperation(false);

        model.editedUser = new User(user.firstName, user.lastName, user.id);

        var editView:UserDetailView = new UserDetailView();

        _swiz.registerWindow(editView);

        PopUpManager.addPopUp(editView, DisplayObject(FlexGlobals.topLevelApplication), false);
        PopUpManager.centerPopUp(editView);

        return startEditOperation();
    }

    [EventHandler(event="UserEvent.SAVE")]
    public function save():void {

        model.update(model.editedUser);

        finishEditOperation(true);

        model.editedUser = null;
    }

    [EventHandler(event="UserEvent.CANCEL")]
    public function cancel():void {

        finishEditOperation(false);

        model.editedUser = null;
    }

    [EventHandler(event="UserEvent.ASSIGN", properties="user")]
    public function assign(user:User):void {

        model.assign(user);
    }

    [EventHandler(event="UserEvent.UNASSIGN", properties="user")]
    public function remove(user:User):void {

        model.unassign(user);
    }

    [EventHandler(event="UserEvent.ADD_AND_ASSIGN")]
    public function createAndAssign():void {


        var createStep:ResultEventChainStep = new ResultEventChainStep(new UserEvent(UserEvent.ADD), function (user:User):void {
            assignEvent.user = user;
        });

        var assignEvent:UserEvent = new UserEvent(UserEvent.ASSIGN);
        var assignStep:EventChainStep = new EventChainStep(assignEvent);

        new EventChain(dispatcher)
                .addEvent(createStep)
                .addEvent(assignStep)
                .start();
    }

    // endregion

    // region Operation handling

    private var _editOperation:IAsynchronousOperation;

    private function startEditOperation():IAsynchronousOperation {

        if (_editOperation) {
            finishEditOperation(false);
        }

        return _editOperation = new ManualAsynchronousOperation();
    }

    private function finishEditOperation(success:Boolean):void {

        if (!_editOperation)
            return;

        if (success) {
            _editOperation.complete(model.editedUser);
        } else {
            _editOperation.fail(model.editedUser);
        }

        _editOperation = null;
    }

    // endregion
}
}
