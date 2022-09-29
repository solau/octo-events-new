defmodule OctoEvents.Repo.Migrations.CreateEventTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :action, :string
      add :number, :integer
      add :created_at, :string
    end
  end
end
