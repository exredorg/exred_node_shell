defmodule Exred.Node.Shell do
  @moduledoc """
  Executes shell calls when receives a message.

  The incoming message content is ignored.
  The node executes the configured command in a new shell and
  updates the payload. The rest of the incoming message is unaltered.

  **Incoming message format**
  N/A

  **Outgoing message format**
  ```elixir
  msg = %{
    payload :: %{
      out :: String.t,
      err :: String.t,
      status :: integer
    }
  }
  ```
  """

  @name "Shell"
  @category "function"
  @config %{
    name: %{
      info: "Visible node name",
      value: @name,
      type: "string",
      attrs: %{max: 20}
    },
    command: %{
      info: "Arbitrary shell command",
      value: "# echo \"hello\"\n# grep sent /var/log/mail.log\n\n",
      type: "codeblock"
    }
  }
  @info @moduledoc
  @ui_attributes %{fire_button: false, left_icon: "computer", right_icon: nil}

  use Exred.NodePrototype
  alias Porcelain.Result
  require Logger

  @impl true
  def handle_msg(%{} = msg, state) do
    cmd = state.config.command.value
    Logger.debug("Executing #{inspect(cmd)}")
    res = %Result{out: output, err: error, status: status} = Porcelain.shell(cmd)
    Logger.debug("Result: #{inspect(res)}")
    out = Map.put(msg, :payload, res)
    {out, state}
  end

  def handle_msg(msg, state) do
    Logger.warn(
      "UNHANDLED MSG node: #{state.node_id} #{get_in(state.config, [:name, :value])} msg: #{
        inspect(msg)
      }"
    )

    {nil, state}
  end
end
