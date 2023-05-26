defmodule ErpWeb.SaleController do
@moduledoc """
A module that acts as the controller for system sales.
"""
  use ErpWeb, :controller

  
  # Process a singular sale of a bike.
  
def process_sale(conn, %{"sale" => sale_params}) do
  # Retrieve the current user from the connection using Guardian authentication
  user = Guardian.Plug.current_resource(conn)

  # Call the add_sale function from the Erp.Sale module, passing sale_params and user
  case Erp.Sale.add_sale(sale_params, user) do
    {:ok} ->
      # If the sale was successfully added, send a JSON response with success message
      json(conn, %{success: ":)"})

    {:error, error} ->
      # If an error occurred during the sale addition, return the error tuple
      {:error, error}
  end
end

