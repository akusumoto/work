export interface Todo {
    uid: string;
    name: string;
    list: 'todo' | 'doing' | 'done';
    id: string;
}
