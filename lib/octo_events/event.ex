defmodule OctoEvents.Event do
    use Ecto.Schema
    import Ecto.Changeset


    schema "events" do
      field :action,  :string
      field :number, :integer
      field :created_at, :string
    end

    @required_params [:action, :number, :created_at]

    def build(params) do
        params
        |> build_event()
        |> changeset()
        |> apply_action(:insert)
    end

    defp build_event(%{
        "action" => action,
        "issue" => %{
          "number" => number,
          "created_at" => created_at,
        }
      }) do
   %{
     action: action,
     number: number,
     created_at: created_at
   }
 end


    def changeset(params) do
        %__MODULE__{}
        |> cast(params, @required_params)
        |> validate_required(@required_params)
    end
end
