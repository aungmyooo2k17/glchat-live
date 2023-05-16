defmodule GlchatLive.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :user_id, :integer, null: true
      add :group_id, :integer, null: true
      add :chat_id, :integer, null: true
      add :type, :string, null: true
      add :content, :string, null: true
      add :send_at, :naive_datetime, null: true
      add :delivered_at, :naive_datetime, null: true
      add :seen_at, :naive_datetime, null: true

      timestamps()
    end
  end
end
