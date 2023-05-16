defmodule GlchatLive.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups) do
      add :user_id, :integer
      add :group_id, :integer

      timestamps()
    end
  end
end
