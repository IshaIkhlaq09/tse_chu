defmodule ErpWeb.OrderController do
@moduledoc """
A module that acts as the controller for managing orders (customer transactions).
"""
  use ErpWeb, :controller
  import Ecto.Query, warn: false
  import Guardian.Plug

  @doc """ false 
  This function handles the display of details for a specific order.
  It takes a connection (conn) and a map containing the order ID (%{"id" => id}).
  The order ID is parsed and converted to an integer using Integer.parse/1. 
  The corresponding order is retrieved using Erp.Sales.Order.get_order!/1,
  and the ! indicates that an exception will be raised if the order with the given ID is not found.
  """
  
  def show(conn, %{"id" => id}) do
    {int, _rem} = Integer.parse(id)
    order = Erp.Sales.Order.get_order!(int)
    user = Guardian.Plug.current_resource(conn)
    if order.userEmail == user.email do 
      render(conn, "show.json", order: order)
    else 
      send_resp(conn, 404, "not found")
    end
  end

  @doc """
  Show a list of all orders.
  this function captures the process of retrieving and displaying all orders,
  and responding with the list of orders in JSON format.
  
  """
 # Display all orders
def show_all_orders(conn, _params) do
  orders = Erp.Sales.Order.list_orders()  # Retrieve the list of all orders
  render(conn, "index.json", orders: orders)  # Render the "index.json" template with the list of orders
end
