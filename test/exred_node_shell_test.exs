defmodule Exred.Node.ShellTest do
  use ExUnit.Case
  doctest Exred.Node.Shell

  test "runs echo" do
    state = %{config: %{command: "echo hello"}}
    msg = %{}
    {out, state} = Exred.Node.Shell.handle_msg msg, state
    assert out.payload.status == 0
    assert out.payload.err == nil
    assert out.payload.out == "hello\n"
  end
end
