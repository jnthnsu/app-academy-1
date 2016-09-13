import {TodoActions} from '../actions/todo_actions';
import {merge} from 'lodash';

export default function todosReducer(state = {}, action) {
  switch (action.type) {
    case TodoActions.RECEIVE_TODOS:
      return merge({}, state, action.todos);
    case TodoActions.RECEIVE_TODO:
      return merge({}, state, action.todo);
    default:
      return state;
  }
}
