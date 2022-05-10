# Nutrino

Simple cooking app for helping you with a healthy diet 🥕🥝🥑 
To use it just fill up the form with your minimal nutrition requirements (carbohydrates🥖, protein🥚 and fat🥜) and Nutrino will magically 🪄 find cooking recipes 👩‍🍳 just for you! ❤

Under the hood Nutrino uses REST api from two external sites: 
  - edamam.com  - for list of recipes with ingredients
  - nutritionix.com - to retrieve information about nutrition of the ingredients

This app aggregates the data from recipes by summing the nutrition data from nutronix.com and and filters edamam.com recipes on this basis. Although simple, I haven't seen many apps that provide this kind of service. What started as a simple Elixir project with Phoenix framework and LiveBook was a pretty refreshing experience for me. I hope you will have fun with it too! 😊


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
