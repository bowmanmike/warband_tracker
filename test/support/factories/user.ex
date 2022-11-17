defmodule WarbandTracker.Factories.User do
  alias WarbandTracker.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{email: "email@email.com"}
      end
    end
  end
end
