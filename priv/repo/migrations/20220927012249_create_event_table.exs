defmodule OctoEvents.Repo.Migrations.CreateEventTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :action, :string, null: false
      add :number, :integer, null: false
      add :created_at, :string, null: false
    end

    create index(:events, [:number])
  end
end
