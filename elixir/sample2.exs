defmodule Sample do
  def p([]) -> end
  def p([x | xs]) do
    IO.puts x
    p(xs)
  end
end


Sample.p([1,2,3])
