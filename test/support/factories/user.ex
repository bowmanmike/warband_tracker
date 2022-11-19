defmodule WarbandTracker.Factories.User do
  alias WarbandTracker.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        password = Faker.Lorem.characters(10) |> to_string()

        %User{
          email: unique_user_email(),
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

      def valid_user_attributes(attrs \\ %{}) do
        attrs =
          attrs
          |> Enum.into(%{
            email: unique_user_email(),
            password: valid_user_password()
          })
          |> Map.delete(:hashed_password)

        :user |> params_for(attrs) |> Map.delete(:hashed_password)
      end

      def valid_user_password, do: "hello world!"
      def unique_user_email, do: sequence(:email, &"email-#{&1}@example.com")

      def extract_user_token(fun) do
        {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
        [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
        token
      end
    end
  end
end
