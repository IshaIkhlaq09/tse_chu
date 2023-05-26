defmodule ErpWeb.TaskController do
  use ErpWeb, :controller

  alias Erp.Planning
  alias Erp.Planning.Task
  
# Create a new task
  def new(conn, %{"task" => task_params}) do
    user = Guardian.Plug.current_resource(conn)
    case Planning.add_task(task_params, user) do
          {:ok} ->
            tasks = Erp.Planning.list_tasks()
            render(conn, "index.json", tasks: tasks) # Render the "index.json" template with the updated list of tasks
    {:error, error} ->
          {:error, error} ->
            {:error, error} # Return the error if adding the task was unsuccessful
    end
  end

  def show(conn, %{"id" => id}) do
    task = Planning.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def show_all_tasks(conn, _params) do
    tasks = Erp.Planning.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  # Update a task
def update_task(conn, %{"task" => task_params}) do
  task = Planning.get_task!(task_params["id"])  # Retrieve the task based on the provided task ID
  case Planning.update_task(task, task_params) do
    {:ok} ->
      tasks = Erp.Planning.list_tasks()  # Retrieve the updated list of tasks
      render(conn, "index.json", tasks: tasks)  # Render the "index.json" template with the updated list of tasks
    {:error, error} ->
      {:error, error}  # Return the error if updating the task was unsuccessful
  end
end

  # Delete a task
def delete(conn, %{"taskID" => id}) do
  task = Planning.get_task!(id)  # Retrieve the task based on the provided task ID
  case Planning.delete_task(task) do
    {:ok} ->
      tasks = Erp.Planning.list_tasks()  # Retrieve the updated list of tasks
      render(conn, "index.json", tasks: tasks)  # Render the "index.json" template with the updated list of tasks
    {:error, error} ->
      {:error, error}  # Return the error if deleting the task was unsuccessful
  end
end
