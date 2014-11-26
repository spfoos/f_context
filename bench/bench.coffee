Benchmark = require('benchmark');

f_context = require("./../dist/f_context").f_context;


#factorial computation benchmarks
f_context ->

  f_fact(0) -> 1
  f_fact(N) -> N * f_fact(N - 1)

plain_f_factorial = (n) -> !n and 1 or n * plain_f_factorial(n - 1);

plain_c_factorial = (n) ->
  result = 1
  for i in [1..n]
    result *= i
  result


suite = new Benchmark.Suite

suite
  .add 'f_context factorial', ->
    f_fact(10)
  .add 'plain recursion style factorial', ->
    plain_f_factorial(10)
  .add 'plain loop style factorial', ->
    plain_c_factorial(10)
  .on 'cycle', (event) ->
    console.log(String(event.target))
  .on 'complete', ->
    console.log('Fastest is ' + this.filter('fastest').pluck('name'))
  .run('async': false)
# / factorial computation benchmarks
