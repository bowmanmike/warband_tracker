defmodule WarbandTracker.Warbands do
  @moduledoc """
  The Warbands context.
  """

  import Ecto.Query, warn: false
  alias WarbandTracker.Warbands.Henchmen
  alias WarbandTracker.Repo

  alias WarbandTracker.Warbands.{Henchmen, Hero, Warband}
  alias WarbandTracker.Accounts

  @doc """
  Returns the list of warbands.

  ## Examples

      iex> list_warbands()
      [%Warband{}, ...]

  """
  def list_warbands do
    Repo.all(Warband)
  end

  def list_warbands_for_user(%Accounts.User{id: user_id}) do
    Warband
    |> where([w], w.user_id == ^user_id)
    |> Repo.all()

    # Repo.get_by(Warband, user_id: user_id)
  end

  @doc """
  Gets a single warband.

  Raises `Ecto.NoResultsError` if the Warband does not exist.

  ## Examples

      iex> get_warband!(123)
      %Warband{}

      iex> get_warband!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warband!(id), do: Repo.get!(Warband, id)

  @doc """
  Gets a single warband, scoped to a user

  Raises `Ecto.NoResultsError` if the Warband does not exist.

  ## Examples

      iex> get_warband_for_user!(user, 123)
      %Warband{}

      iex> get_warband_for_user!(user, 456)
      ** (Ecto.NoResultsError)

  """
  def get_warband_for_user!(%Accounts.User{id: user_id}, warband_id) do
    Repo.get_by!(Warband, id: warband_id, user_id: user_id)
  end

  @doc """
  Creates a warband.

  ## Examples

      iex> create_warband(%{field: value})
      {:ok, %Warband{}}

      iex> create_warband(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warband(attrs \\ %{}) do
    %Warband{}
    |> Warband.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warband.

  ## Examples

      iex> update_warband(warband, %{field: new_value})
      {:ok, %Warband{}}

      iex> update_warband(warband, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warband(%Warband{} = warband, attrs) do
    warband
    |> Warband.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a warband.

  ## Examples

      iex> delete_warband(warband)
      {:ok, %Warband{}}

      iex> delete_warband(warband)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warband(%Warband{} = warband) do
    Repo.delete(warband)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warband changes.

  ## Examples

      iex> change_warband(warband)
      %Ecto.Changeset{data: %Warband{}}

  """
  def change_warband(%Warband{} = warband, attrs \\ %{}) do
    Warband.changeset(warband, attrs)
  end

  def change_hero(%Hero{} = hero, attrs \\ %{}, %Warband{} = warband) do
    Hero.changeset(hero, attrs, warband)
  end

  def create_hero(warband, attrs \\ %{}) do
    %Hero{}
    |> Hero.changeset(attrs, warband)
    |> Repo.insert()
  end

  def change_henchmen(%Henchmen{} = henchmen, attrs \\ %{}, %Warband{} = warband) do
    Henchmen.changeset(henchmen, attrs, warband)
  end

  def create_henchmen(warband, attrs \\ %{}) do
    %Henchmen{}
    |> Henchmen.changeset(attrs, warband)
    |> Repo.insert()
  end

  def members(warband) do
    heroes = get_heroes!(warband)
    henchmen = get_henchmen!(warband)

    %{
      heroes: heroes,
      henchmen: henchmen
    }
  end

  def get_heroes!(%Warband{} = warband) do
    warband
    |> Repo.preload(:heroes)
    |> Map.get(:heroes)
  end

  def get_henchmen!(%Warband{} = warband) do
    warband
    |> Repo.preload(:henchmen)
    |> Map.get(:henchmen)
  end
end
