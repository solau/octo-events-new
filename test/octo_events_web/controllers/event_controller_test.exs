defmodule OctoEventsWeb.EventControllerTest do
  use OctoEventsWeb.ConnCase

  describe "index/2" do
    test "when there is events with given issue number, returns a list of events", %{conn: conn} do
      params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}
      OctoEvents.create_event(params)

      response =
        conn
        |> get(Routes.event_path(conn, :index, 1))
        |> json_response(:ok)

      assert [%{"action" => "open", "number" => 1, "created_at" => "2022-10-05T10:10:10"}] == response
    end


  test "when the issue number does not exists, returns not found", %{conn: conn} do
    response =
      conn
      |> get(Routes.event_path(conn, :index, 10))
      |> json_response(:not_found)

    assert %{"message" => "Events not found!"} == response
  end

  test "when receive an invalid number, returns an error", %{conn: conn} do
    response =
      conn
      |> get(Routes.event_path(conn, :index, "a"))
      |> json_response(:bad_request)

    assert %{"message" => "'a' is not a number"} == response
  end
end

describe "create/2" do
  test "when receive an event by post, saves that and returns the event created", %{conn: conn} do
    params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}

    response =
      conn
      |> post(Routes.event_path(conn, :create, params))
      |> json_response(:created)

    assert %{"action" => "open", "number" => 1, "created_at" => "2022-10-05T10:10:10"} == response
  end

  test "when receive an invalid body, returns the error", %{conn: conn} do
    params = %{"action" => "", "issue" => %{"number" => "", "created_at" => ""}}

    response =
      conn
      |> post(Routes.event_path(conn, :create, params))
      |> json_response(:bad_request)

    assert %{"message" => %{
      "action" => ["can't be blank"],
      "created_at" => ["can't be blank"],
      "number" => ["can't be blank"]
    }} == response
  end
  end
end
