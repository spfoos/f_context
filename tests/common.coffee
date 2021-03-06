describe "Common", ->
  #delete it after divide tests
  test_module = f_context ->

    #factorial
    f_fact(0) -> 1
    f_fact(N) -> N * f_fact(N - 1)

    #fibonacci range
    fibonacci_range(Count) ->
      fibonacci_range(Count, 0, [])

    fibonacci_range(Count, Count, Accum) -> Accum

    fibonacci_range(Count, Iterator, Accum) where(Iterator is 0 or Iterator is 1) ->
      fibonacci_range(Count, Iterator + 1, [Accum..., Iterator])

    fibonacci_range(Count, Iterator, [AccumHead..., A, B]) ->
      fibonacci_range(Count, Iterator + 1, [AccumHead..., A, B, A + B])

    #array elements count
    f_count(List) ->
      f_count(List, 0)

    f_count([], Iterator) -> Iterator
    f_count([Head, List...], Iterator) ->
      f_count(List, Iterator + 1)


    #array range
    f_range(I) ->
      f_range(I, 0, [])

    f_range(I, I, Accum) -> Accum
    f_range(I, Iterator, Accum) ->
      f_range(I, Iterator + 1, [Accum..., Iterator])


    #test guards
    f_range_guard(I) ->
      f_range_guard(I, 0, [])

    f_range_guard(I, Iterator, Accum) where(I == Iterator) -> Accum
    f_range_guard(I, Iterator, Accum) ->
      f_range_guard(I, Iterator + 1, [Accum..., Iterator])


    #example of function all
    f_all([Head, List...], F) ->
      f_all(List, F, F(Head))

    f_all(_, _, false) -> false
    f_all([], _, _) -> true

    f_all([Head, List...], F, Memo) ->
      f_all(List, F, F(Head))


    # flatten example
    f_flatten(List) ->
      f_flatten(List, [])

    f_flatten([], Acc) -> Acc
    f_flatten([Head, List...], Acc) where(Head instanceof Array) ->
      f_flatten(List, f_flatten(Head, Acc))

    f_flatten([Head, List...], Acc) ->
      f_flatten(List, [Acc..., Head])


  it('computes factorial', ->
    expect(test_module.f_fact(5)).toBe(120)
  )

  it('computes fibonacci range', ->
    expect(test_module.fibonacci_range(10)).toEqual([0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
  )

  it('computes count', ->
    expect(test_module.f_count([0,1,2,3,4])).toBe(5)
  )

  it('computes range', ->
    expect(test_module.f_range(5)).toEqual([0,1,2,3,4])
  )

  it('computes range with guards', ->
    expect(test_module.f_range_guard(5)).toEqual([0,1,2,3,4])
  )

  it('computes function all', ->
    expect(test_module.f_all([1,2,3,4], (i) -> i > 0)).toBe(true)
    expect(test_module.f_all([1,2,3,4], (i) -> i > 1)).toBe(false)
  )

  it('computes function flatten', ->
    expect(test_module.f_flatten([1, 2, [3], [4, 5, [6, [7]]], 8])).toEqual([1,2,3,4,5,6,7,8])
  )
