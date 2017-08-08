# Fill the array with Fibonacci numbers up to 100

def fib(n)
  n <= 1 ? n : fib(n - 1) + fib(n - 2)
end

array = []
i = 1

while fib(i) < 100
  array << fib(i)
  i += 1
end
puts array
