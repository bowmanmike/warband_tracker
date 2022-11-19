defmodule WarbandTracker.Factories.Warband do
  alias WarbandTracker.Warbands.Warband

  defmacro __using__(_opts) do
    quote do
      def warband_factory do
        %Warband{
          name: Faker.Company.name(),
          type: Faker.Team.name(),
          gold_crowns: Faker.Random.Elixir.random_between(0, 500),
          wyrdstone_shards: Faker.Random.Elixir.random_between(0, 15),
          water_units: 0,
          burden: 0,
          burden_limit: 0,
          user: build(:user)
        }
      end
    end
  end
end
