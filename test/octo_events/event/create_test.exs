defmodule OctoEvents.Event.CreateTest do
  use OctoEvents.DataCase

  alias OctoEvents.{Repo, Event}
  alias Event.Create

  describe "call/1" do
    test "when all params are valid, creates an event" do
      params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}

      count_before = Repo.aggregate(Event, :count)

      {:ok, response} = Create.call(params)

      count_after = Repo.aggregate(Event, :count)

      assert %Event{
               action: "open",
               number: 1,
               created_at: "2022-10-05T10:10:10"
             } = response

      assert count_after > count_before
    end

    test "when there are invalid, returns an error" do
      params =  %{"action" => "", "issue" => %{"number" => "", "created_at" => ""}}
      response = Create.call(params)

      assert {:error, changeset} = response
      # One way to test using errors_on
      assert %{action: ["can't be blank"],
               number: ["can't be blank"],
               created_at: ["can't be blank"]
              } == errors_on(changeset)
    end
  end
end
