defmodule GlchatLive.Repo.Migrations.CreateLiveUsers do
  use Ecto.Migration

  def change do
    create table(:live_users, primary_key: false) do
      add :user_id, :integer, primary_key: true
      add :active_status, :string

      timestamps()
    end
  end
end
