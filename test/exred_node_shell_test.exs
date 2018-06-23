defmodule ExredNodeShellTest do
  use ExUnit.Case
  doctest ExredNodeShell

  test "greets the world" do
    assert ExredNodeShell.hello() == :world
  end
end
