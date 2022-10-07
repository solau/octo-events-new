defmodule OctoEvents.Event.Get do
    alias OctoEvents.{Event, Repo}

    import Ecto.Query

    def call(number) do
        case Integer.parse(number,10) do
          :error -> {:error, "'#{number}' is not a number"}
          {n, _} -> get(n)
        end
    end

    defp get(number) do
        case fetch_events(number) do
            [] -> {:error, :not_found, "Events not found!"}
            events -> {:ok, events}
        end
    end

    defp fetch_events(number) do
        Event
        |> where(number: ^number)
        |> order_by(desc: :created_at)
        |> Repo.all()
      end
end
