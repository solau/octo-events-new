defmodule OctoEvents.Event.GetTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{Repo, Event}
  alias Event.{Create, Get}

  describe "call/1" do

    test "when the issue number exists, returns a list of events with that number" do
      params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}
      Create.call(params)
      params = %{"action" => "close", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}
      Create.call(params)
      count_after = Repo.aggregate(Event, :count)

      response = Get.call("1")

      assert {:ok, events} = response
      assert count_after == length(events)
      assert %Event{ number: 1 } = hd(events)
    end

    test "when the issue number does not exists, returns not found" do
      params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}
      Create.call(params)

      response = Get.call("10")

      assert {:error, :not_found, "Events not found!"} = response
    end

    test "when the param is invalid, returns an error" do
      response = Get.call("x")

      assert {:error, "'x' is not a number"} = response
    end
  end
end
