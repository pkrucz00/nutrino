defmodule NutrinoWeb.BadRequest do
  defexception [:message, plug_status: 400]
end
