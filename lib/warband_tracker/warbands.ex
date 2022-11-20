defmodule WarbandTracker.Warbands do
  @moduledoc """
  The Warbands context.
  """

  import Ecto.Query, warn: false
  alias WarbandTracker.Repo

  alias WarbandTracker.Warbands.{Hero, Warband}

  @doc """
  Returns the list of warbands.

  ## Examples

      iex> list_warbands()
      [%Warband{}, ...]

  """
  def list_warbands do
    Repo.all(Warband)
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

  def create_hero(warband, attrs \\ %{}) do
    %Hero{}
    |> Hero.changeset(attrs, warband)
    |> Repo.insert()
  end
end
