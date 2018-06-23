defmodule ExredNodeShell do
  @moduledoc """
  Executes shell calls.
  
  **Incoming message format**  
  ```elixir
  msg = %{
    payload :: String.t()
  }
  ```
  
  **Outgoing message format**
  ```elixir
  msg = %{
    payload :: %{
      out :: String.t,
      err :: String.t,
      status :: integer
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
    },
  }
  @info @moduledoc
  @ui_attributes %{fire_button: false, left_icon: computer, right_icon: nil}
  
  use Exred.Library.NodePrototype
  alias Porcelain.Result
  require Logger
  
  
  @impl true
  def handle_msg(msg, state) do
    cmd = state.config.command
    Logger.debug "Executing #{inspect cmd}"
    res = %Result{out: output, err: error, status: status} = Porcelain.shell( cmd )
    Logger.debug "Result: #{inspect res}"
    out = Map.put(msg, :payload, res)
    {out, state}
  end

end
