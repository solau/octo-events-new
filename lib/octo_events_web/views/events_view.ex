defmodule OctoEventsWeb.EventsView do
    use OctoEventsWeb, :view

    alias OctoEvents.Event

    def render("create.json", %{event: %Event{action: action, number: number, created_at: created_at}}) do
        %{
            message: "event created!",
            event: %{
                action: action,
                number: number,
                created_at: created_at
            }
        }
    end
end
