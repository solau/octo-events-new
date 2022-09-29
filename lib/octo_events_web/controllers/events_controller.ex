defmodule OctoEventsWeb.EventsController do
    use OctoEventsWeb, :controller

    action_fallback OctoEventsWeb.FallbackController

    def create(conn, params) do
        params
        |> OctoEvents.create_event()
        |> handle_response(conn)
    end

    defp handle_response({:ok, event}, conn) do
        conn
        |> put_status(:created-)
        |> render("create.json", event: event)
    end

    defp handle_response({:error, _changeset} = error, _conn), do: error
end
