import React from 'react';
import {connect} from 'react-redux';
import {allTodos} from '../reducers/selector';
import {requestTodos, createTodo} from '../actions/todo_actions';
import {TodoListItem} from './todo_list_item';
import {TodoForm} from './todo_form';

class TodoList extends React.Component{
  constructor(props){
    super(props);
  }

  componentDidMount(){
    this.props.requestTodos();
  }

  render(){
    const todos = this.props.todos.map(todo => (
      <TodoListItem todo={todo} key={todo.id}/>
    ));


    return (
      <div>
        <ul>
          {todos}
        </ul>
        <TodoForm action={this.props.createTodo}/>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  requestTodos: () => dispatch(requestTodos()),
  createTodo: todo => dispatch(createTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
