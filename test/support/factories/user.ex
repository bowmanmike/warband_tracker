defmodule WarbandTracker.Factories.User do
  alias WarbandTracker.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        password = Faker.Lorem.characters(10) |> to_string()

        %User{
          email: Faker.Internet.email(),
          password: password,
          hashed_password: Bcrypt.hash_pwd_salt(password)
        }
      end
    end
  end
end
