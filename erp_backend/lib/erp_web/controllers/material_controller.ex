defmodule ErpWeb.MaterialController do
@moduledoc """
A module that acts as the controller for managing materials.
"""
  use ErpWeb, :controller 
  #The code defines a controller module ErpWeb.MaterialController responsible for managing materials. 
  import Ecto.Query, warn: false

  alias Erp.Production.Material
#The show function retrieves and renders a single material based on the provided material ID.
  @doc false
  def show(conn, %{"id" => material_id}) do
    material = Erp.Production.Material.get_material!(material_id)
    render(conn, "show.json", material: material)
  end

#The show_all_materials function retrieves all materials and renders them in JSON format.
  @doc """
  Show all materials.
  """
  def show_all_materials(conn, _params) do
    materials = Erp.Production.Material.list_materials()
    render(conn, "index.json", materials: materials)
  end
#The get_materials_by_plant_id function retrieves a list of materials to a specific plant ID and renders them in JSON format.
  @doc """
  Get a list of materials that correlate to a plant ID.
  """
  def get_materials_by_plant_id(conn, %{"id" => plant_id}) do
    materials = Erp.Production.Material.get_materials_by_plant_id(plant_id)
    render(conn, "index.json", materials: materials)
  end

  @doc """
  Update the quanity of a material by ID.
  """
  def update_quantity(conn, %{"id" => plant_id, "quantity" => quantity}) do
    material = Material.get_material!(plant_id)
    @doc """
    It first retrieves the material by calling Material.get_material!(plant_id),
    which raises an exception if the material with the given plant ID is not found.
    """

    with {:ok, %Material{} = material} <- Material.update_quantity(material, quantity) do
     @doc """
     Then, using the retrieved material, it calls Material.update_quantity(material, quantity) to update the quantity.
      The update_quantity function returns {:ok, updated_material} if the update is successful.
      """
      render(conn, "show.json", material: material)
    @doc """
      The with construct is used to handle the result of Material.update_quantity. If the update is successful and the result is {:ok, %Material{} = material}, 
      it renders the "show.json" template with the updated material using render(conn, "show.json", material: material).
      """
    end
  end
end
