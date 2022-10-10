# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  TAB = "\t"
  NEWLINE = "\n"
  def take_tsv(tsv)
    my_lines = tsv.split(NEWLINE)
    keys = my_lines[0].split(TAB)
    my_lines.shift
    @data = handle(my_lines, keys)
  end

  def handle(lines, keys)
    result = []
    lines.each do |line|
      value = line.split(TAB)
      content = {}
      keys.each_index { |index| content[keys[index]] = value[index].chomp }
      result.push(content)
    end
    result
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    list = @data[0].map { |key,| key }.join("\t") << "\n"
    data = @data.map do |line|
      line.map { |_, word| word }.join("\t") << "\n"
    end
    list + data.join
  end
end
