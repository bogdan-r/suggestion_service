defmodule SuggestionService.Bitap do
  use Bitwise

  @spec search(binary(), binary(), non_neg_integer()) :: any()
  def search(haystack, needle, maxErrors) do
    haystack_length = String.length(haystack)
    needle_length = String.length(needle)

    alphabet = generate_alphabet(needle, haystack)

    empty_column = (2 <<< (needle_length - 1)) - 1
    undeground = Enum.map(1..haystack_length + 1, fn _ -> empty_column end)
    table = [undeground, [empty_column]]

    if maxErrors == 0 do
      {place, error, _} = precise_search(haystack, needle_length, table, alphabet)
      {place, error}
    else
      {_, _, current_table} = precise_search(haystack, needle_length, table, alphabet)
      {place, error, _} = fuzzy_search(haystack, needle_length, current_table, alphabet, maxErrors, empty_column)
      {place, error}
    end
  end

  defp precise_search(haystack, needle_length, table, alphabet) do
    haystack_length = String.length(haystack)
    Enum.reduce_while(
      1..haystack_length,
      {"", -1, table},
      fn column_num, {_, _, current_table} ->
      index =
        current_table
        |> Enum.at(1)
        |> Enum.at(column_num - 1)

      prev_column = index >>> 1
      letter_pattern = alphabet[String.at(haystack, column_num - 1)]
      current_column = prev_column ||| letter_pattern

      added_column = Enum.at(current_table, 1) ++ [current_column]
      current_table = List.replace_at(current_table, 1, added_column)
      if (current_column &&& 0x1) == 0 do
        place = String.slice(haystack, column_num - needle_length..column_num)
        {:halt, {place, 0, current_table}}
      else
        {:cont, {"", -1, current_table}}
      end
    end)
  end

  def fuzzy_search(haystack, needle_length, table, alphabet, max_errors, empty_column) do
    haystack_length = String.length(haystack)

    Enum.reduce_while(2..max_errors + 1, {"", -1, table}, fn k, {_, _, current_table} ->
      current_table = current_table ++ [[empty_column]]

      res = Enum.reduce_while(
        1..haystack_length,
        {nil, "", -1, current_table},
        fn column_num, {_, _, _, inner_table} ->
          prev_num = column_num - 1
          prev_column = (inner_table |> Enum.at(k) |> Enum.at(prev_num)) >>> 1
          letter_pattern = alphabet[String.at(haystack, prev_num)]
          current_column = prev_column ||| letter_pattern

          insert_column = current_column &&& (inner_table |> Enum.at(k - 1) |> Enum.at(prev_num))
          delete_column = current_column &&& (inner_table |> Enum.at(k - 1) |> Enum.at(column_num) |> Bitwise.>>>(1))
          replace_column = current_column &&& (inner_table |> Enum.at(k - 1) |> Enum.at(prev_num) |> Bitwise.>>>(1))
          res_column = insert_column &&& delete_column &&& replace_column

          added_column = Enum.at(inner_table, k) ++ [res_column]
          inner_table = List.replace_at(inner_table, k, added_column)

          if (res_column &&& 0x1) == 0 do
            start_pos = max(0, column_num - needle_length)
            end_pos = min(column_num, haystack_length)
            place = String.slice(haystack, start_pos..end_pos)
            {:halt, {:halt, place, k - 1, inner_table}}
          else
            {:cont, {:cont, "", -1, inner_table}}
          end
        end
      )

      case res do
        {:halt, place, errors, tab} -> {:halt, {place, errors, tab}}
        {:cont, place, errors, tab} -> {:cont, {place, errors, tab}}
      end
    end)
  end

  defp generate_alphabet(needle, haystack) do
    haystack
    |> String.graphemes()
    |> Enum.reduce(%{}, fn letter, alphabet ->
      if Map.has_key?(alphabet, letter) do
        alphabet
      else
        symbol_position = Enum.reduce(String.graphemes(needle), 0, fn symbol, position ->
          fl = if letter != symbol, do: 1, else: 0
          position = position <<< 1
          position ||| fl
        end)
        Map.put(alphabet, letter, symbol_position)
      end
    end)
  end
end
