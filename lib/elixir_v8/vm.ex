defmodule ElixirV8.VM do
  use GenServer

  def start_link(opts) do
    GenServer.start_link ElixirV8.VM, opts
  end

  def eval(vm, source, timeout) do
    GenServer.call(vm, {:eval, source, timeout})
  end

  def handle_call({:eval, source, timeout}, _, {v8, context}) do
    result = :erlang_v8.eval(v8, context, source, timeout)
    {:reply, result, {v8, context}}
  end

  def init(opts) do
    {:ok, v8} = :erlang_v8.start_vm(opts)
    {:ok, context} = :erlang_v8.create_context(v8)
    {:ok, {v8, context}}
  end
end

