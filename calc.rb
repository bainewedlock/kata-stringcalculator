def add(numbers)
  add_with_delimiter *extract_delimiter(numbers)
end
def extract_delimiter(text)
  return [/,|\n/, text] unless text.start_with? '//'
  (delimiter_spec, remaining_text) = text[2..-1].split("\n", 2)
  return parse_delimiter(delimiter_spec), remaining_text
end
def parse_delimiter(spec)
  if spec.start_with? '['
    return regexp_for_strings spec[1..-2].split('][')
  else
    return spec
  end
end
def regexp_for_strings(strings)
  pattern = strings.map do |x|
    Regexp.escape x
  end.join '|'
  Regexp.new pattern
end
def add_with_delimiter(delimiter=/,|\n/, numbers)
  integers = numbers.split(delimiter).map &:to_i
  must_not_contain_negatives integers
  integers.select{|n| n <= 1000}.sum
end
def must_not_contain_negatives(numbers)
  negatives = numbers.select &:negative?
  raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
end
