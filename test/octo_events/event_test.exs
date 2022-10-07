defmodule OctoEvents.EventTest do
  use OctoEvents.DataCase

  alias OctoEvents.Event

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{action: "open", number: 1, created_at: "2022-10-05T10:10:10"}
      response = Event.changeset(params)

      assert %Ecto.Changeset{
               changes: %{action: "open",  number: 1, created_at: "2022-10-05T10:10:10"},
               errors: [],
               valid?: true
             } = response
    end
  end

  test "when action is blank, returns an invalid changeset" do
    params = %{number: 1, created_at: "2022-10-05T10:10:10"}
    response = Event.changeset(params)

    assert %Ecto.Changeset{
             changes: %{number: 1, created_at: "2022-10-05T10:10:10"},
             errors: [action: {"can't be blank", [validation: :required]}],
             valid?: false
           } = response

    assert %{action: ["can't be blank"]} == errors_on(response)
  end

  test "when number is blank, returns an invalid changeset" do
    params = %{action: "open", created_at: "2022-10-05T10:10:10"}
    response = Event.changeset(params)

    assert %Ecto.Changeset{
             changes: %{action: "open", created_at: "2022-10-05T10:10:10"},
             errors: [number: {"can't be blank", [validation: :required]}],
             valid?: false
           } = response

    assert %{number: ["can't be blank"]} == errors_on(response)
  end

  test "when created_at is blank, returns an invalid changeset" do
    params = %{action: "open", number: 1 }
    response = Event.changeset(params)

    assert %Ecto.Changeset{
             changes: %{action: "open", number: 1},
             errors: [created_at: {"can't be blank", [validation: :required]}],
             valid?: false
           } = response

    assert %{created_at: ["can't be blank"]} == errors_on(response)
  end

  describe "build/1" do
    test "when all params are valid, returns a event struct" do
      params = %{"action" => "open", "issue" => %{"number" => 1, "created_at" => "2022-10-05T10:10:10"}}
      response = Event.build(params)

      assert {:ok,
              %Event{
                action: "open",
                number: 1,
                created_at: "2022-10-05T10:10:10",
                id: nil,
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params =  %{"action" => "", "issue" => %{"number" => "", "created_at" => ""}}
      response = Event.build(params)

      assert {:error,
      %Ecto.Changeset{
        action: :insert,
        changes: %{},
        errors: [
                 action: {"can't be blank", [validation: :required]},
                 number: {"can't be blank", [validation: :required]},
                 created_at: {"can't be blank",
                 [validation: :required]}
               ],
        valid?: false
      }} = response
    end
  end
end
