defmodule Blog.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :post_id, :string
      add :body, :string

      timestamps()
    end

  end
end
