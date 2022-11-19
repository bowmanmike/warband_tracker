defmodule WarbandTracker.Factories.User do
  alias WarbandTracker.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        password = Faker.Lorem.characters(10) |> to_string()

        %User{
          email: sequence(:email, &"email-#{&1}@example.com"),
          password: password,
          hashed_password: Bcrypt.hash_pwd_salt(password)
        }
      end

      def set_password(user, password \\ Faker.Lorem.characters(10) |> to_string()) do
        hashed_password = Bcrypt.hash_pwd_salt(password)
        %{user | hashed_password: hashed_password, password: nil}

        # potentially replace with:
        # user
        # |> User.changeset(%{password: password})
        # |> Ecto.Changeset.apply_changes()
      end
    end
  end
end
