defmodule OctoEventsWeb.EventView do
    use OctoEventsWeb, :view

    def render("index.json", %{events: events}) do
        render_many(events, __MODULE__, "create.json")
      end

      def render("create.json", %{event: event}) do
        render_one(event, __MODULE__, "event.json")
      end

      def render("event.json", %{event: event}) do
        %{
          number: event.number,
          action: event.action,
          created_at: event.created_at
        }
      end
end
