defmodule ExredNodeShellTest do
  use ExUnit.Case
  doctest ExredNodeShell

  test "runs echo" do
    state = %{config: %{command: "echo hello"}}
    msg = %{}
    {out, state} = ExredNodeShell.handle_msg msg, state
    assert out.payload.status == 0
    assert out.payload.err == nil
    assert out.payload.out == "hello\n"
  end
end
