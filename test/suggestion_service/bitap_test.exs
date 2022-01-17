defmodule SuggestionService.BitapTest do
  use SuggestionService.DataCase

  alias SuggestionService.Bitap

  test "Bitap search" do
    haystack = "Hello"
    needle = "Hello"

    {result, errors} = Bitap.search(haystack, needle, 0)

    assert result == "Hello"
    assert errors == 0
  end

  test "Empty result with strict searching" do
    haystack = "Hello"
    needle = "hello"

    {result, errors} = Bitap.search(haystack, needle, 0)

    assert result == ""
    assert errors == -1
  end

  test "Fuzzy search" do
    haystack = "Hello world"
    needle = "hello"

    {result, errors} = Bitap.search(haystack, needle, 1)

    assert result == "Hello "
    assert errors == 1
#
    haystack = "Hello world"
    needle = "world"

    {result, errors} = Bitap.search(haystack, needle, 1)

    assert result == " world"
    assert errors == 1
#
    haystack = "Hello world"
    needle = "hello world"

    {result, errors} = Bitap.search(haystack, needle, 1)

    assert result == "Hello world"
    assert errors == 1
#
    haystack = "Hello world"
    needle = "Hello world"

    {result, errors} = Bitap.search(haystack, needle, 1)

    assert result == "Hello world"
    assert errors == 1
  end

end
