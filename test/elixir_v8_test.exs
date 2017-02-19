defmodule ElixirV8Test do
  use ExUnit.Case
  doctest ElixirV8

  test "Simple execution" do
    {:ok, _} = ElixirV8.create_pool(:main, 10)
    {:ok, result} = ElixirV8.eval({:global, :main}, "2 * 4")
    assert result == 8
    ElixirV8.delete_pool(:main)
  end

  test "Context remaining" do
    {:ok, _} = ElixirV8.create_pool(:main, 10)
    {:ok, _} = ElixirV8.eval({:global, :main}, "function sum(a, b) { return a + b; }")
    {:ok, result} = ElixirV8.eval({:global, :main}, "sum(3, 4)")
    assert result == 7
    ElixirV8.delete_pool(:main)
  end

  test "Function calling" do
    {:ok, _} = ElixirV8.create_pool(:main, 10)
    {:ok, result} = ElixirV8.eval_function({:global, :main}, "return arguments[0] * arguments[1]", [20, 5])
    assert result == 100
    ElixirV8.delete_pool(:main)
  end

  test "Loading JavaScript library" do
    js_library = Path.join File.cwd!, "test/resource/library.js"
    {:ok, _} = ElixirV8.create_pool(:main, 10, file: js_library)
    {:ok, result2} = ElixirV8.eval({:global, :main}, "multiply(3, 4)")
    assert result2 == 12
    ElixirV8.delete_pool(:main)
  end
end
