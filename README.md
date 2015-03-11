# ElixirV8

V8 engine for [Elixir](http://elixir-lang.org/) with pools.

## Examples

Application start:

```
ElixirV8.start
```
or add it in `application` section in mix:

```
def application do
  [mod: {Example, []},
   applications: [ :elixir_v8 ] ]
end
```

### Create pools

```
ElixirV8.create_pool(:default, 10)
```

Where `:default` is name of poll and `10` is size of pool.

Also you can configure ElixirV8 directly from configuration file to get pools automatically created at application startup. In `config/config.exs`, add :

```
config :elixir_v8, :pools, [
  test_pool:   [size: 10],
  test_pool_2: [size: 20]
]
```

### Delete pools

```
ElixirV8.delete_pool(:default)

ElixirV8.delete_pool(:test)
```

### Usage

Usage of pools (`eval` js code):

```
iex(2)> ElixirV8.eval({:global, :main}, "1+2")
{:ok, 3}
iex(3)> ElixirV8.eval({:global, :main}, "1+2+3")
{:ok, 6}
```

Method `eval_function` is execute function body with some arguments:

```
iex(4)> ElixirV8.eval_function({:global, :main}, "return data + 13", [13])
{:ok, 26}
iex(6)> ElixirV8.eval_function({:global, :main}, "return data * 13", [20])
{:ok, 260}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
