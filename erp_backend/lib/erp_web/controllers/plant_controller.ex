defmodule ErpWeb.PlantController do
@moduledoc """
A module that acts as the controller for managing manufacturing plants. This module is responsible for managing 
manufacturing plants in an ERP (Enterprise Resource Planning) system. 
It imports the necessary functionality from the ErpWeb module using the use ErpWeb, 
:controller directive and imports the Ecto.Query module without displaying warnings.
Overall, this module provides the necessary controller actions to handle requests related to 
individual plants and the list of all plants in the ERP system.
"""
  use ErpWeb, :controller
  import Ecto.Query, warn: false

  @doc false
  def show(conn, %{"id" => plant_id}) do
    plant = Erp.Production.Plant.get_plant!(plant_id)
    render(conn, "show.json", plant: plant)
  end

  @doc """
  Show a list of all plants.
  """
  def show_all_plants(conn, _params) do
    plants = Erp.Production.Plant.list_plants()
    render(conn, "index.json", plants: plants)
  end
end
