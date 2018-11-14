# ./test/webhook_processor/endpoint_test.exs
defmodule WebhookProcessor.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts WebhookProcessor.Endpoint.init([])

  test "it returns pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong!"
  end

  test "it returns 200 with a valid payload" do
    # Create a test connection
    conn = conn(:post, "/events", %{events: [%{}]})

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 200
  end

  test "it returns 422 with an invalid payload" do
    # Create a test connection
    conn = conn(:post, "/events", %{})

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 422
  end

  test "it returns 404 when no route matches" do
    # Create a test connection
    conn = conn(:get, "/fail")

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 404
  end
end
