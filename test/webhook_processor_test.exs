defmodule WebhookProcessorTest do
  use ExUnit.Case
  doctest WebhookProcessor

  test "greets the world" do
    assert WebhookProcessor.hello() == :world
  end
end
