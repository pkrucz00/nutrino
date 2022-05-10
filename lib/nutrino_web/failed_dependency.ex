defmodule NutrinoWeb.FailedDependency do
  defexception [:message, plug_status: 424]
end
