defmodule Blog.Comment do
  use Blog.Web, :model

  schema "comments" do
    field :post_id, :string
    field :body, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:post_id, :body])
    |> validate_required([:post_id, :body])
  end
end
