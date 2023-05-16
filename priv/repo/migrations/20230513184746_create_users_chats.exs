defmodule GlchatLive.Repo.Migrations.CreateUsersChatss do
  use Ecto.Migration

  def change do
    create table(:users_chats) do
      add :user_id, :integer
      add :chat_id, :integer

      timestamps()
    end
  end
end
