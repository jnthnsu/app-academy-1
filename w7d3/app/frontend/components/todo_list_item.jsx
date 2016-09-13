import React from 'react';

export const TodoListItem = ({todo}) => (
  <li key={todo.id}>{todo.title}</li>
);
