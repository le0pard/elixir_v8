defmodule ElixirV8.Supervisor do
  use Supervisor

  def start_link do
    start_link([], :global)
  end

  def start_link(pools, global_or_local) do
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [pools, global_or_local])
  end

  def create_pool(pool_name, size, options) do
    args = [
      {:name, {:global, pool_name}},
      {:worker_module, :erlang_v8_vm},
      {:size, size},
      {:max_overflow, 10}]
    pool_spec = :poolboy.child_spec(pool_name, args, options)
    :supervisor.start_child(__MODULE__, pool_spec)
  end

  def delete_pool(pool_name) do
    :supervisor.terminate_child(__MODULE__, pool_name)
    :supervisor.delete_child(__MODULE__, pool_name)
  end

  def init([pools, global_or_local]) do
    spec_fun = fn({pool_name, pool_config}) ->
      args = [{:name, {global_or_local, pool_name}}, {:worker_module, :erlang_v8_vm}] ++ pool_config
      :poolboy.child_spec(pool_name, args, pool_config)
    end
    pool_specs = Enum.map(pools, spec_fun)

    supervise(pool_specs, strategy: :one_for_one)
  end

end