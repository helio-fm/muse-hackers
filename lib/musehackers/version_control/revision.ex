defmodule Musehackers.VersionControl.Revision do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musehackers.VersionControl.Revision
  alias Musehackers.VersionControl.Project

  @primary_key {:id, :string, autogenerate: false}

  schema "revisions" do
    field :message, :string
    field :hash, :string
    field :data, :map

    field :parent_id, :string
    field :project_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Revision{} = revision, attrs) do
    revision
    |> cast(attrs, [:id, :message, :hash, :data, :project_id, :parent_id])
    |> validate_required([:id, :message, :hash, :data])
    |> foreign_key_constraint(:project_id)
    |> foreign_key_constraint(:parent_id)
    |> unique_constraint(:id, name: :revisions_unique_id_per_project)
  end
end