module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0

    self.to_a.my_each do |each|
      yield(each, index)
      index = index.next
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = self.is_a?(Array) ? [] : {}

    array_proc = Proc.new { |item| result << item if yield(item) }

    hash_proc = Proc.new { |key, val| result[key] = val if yield(key, val) }

    filter = self.is_a?(Array) ? array_proc : hash_proc

    self.my_each(&filter)

    result
  end

  def my_all?(pattern = nil)
    # argument `pattern` is priority criterion if given
    if pattern
      # hashes are treated as arrays
      self.to_a.my_each { |each| return false unless pattern === each }

      return true
    end

    if block_given?
      array_proc = Proc.new { |each| return false unless yield(each) }

      hash_proc = Proc.new { |key, val| return false unless yield(key, val) }

      check = self.is_a?(Array) ? array_proc : hash_proc

      self.my_each(&check)

      return true
    end

    # no block and no argument given, return truthiness of every element
    self.to_a.my_each { |each| return false if [nil, false].include? each }

    true
  end

  def my_any?(pattern = nil)
    if pattern
      self.to_a.my_each { |each| return true if pattern === each }

      return false
    end

    if block_given?
      array_proc = Proc.new { |each| return true if yield(each) }

      hash_proc = Proc.new { |key, val| return true if yield(key, val) }

      check = self.is_a?(Array) ? array_proc : hash_proc

      self.my_each(&check)

      return false
    end

    # no block and no argument given, return truthiness of any element
    self.to_a.my_each { |each| return true unless [nil, false].include? each }

    false
  end

  def my_none?(pattern = nil)
    # argument `object` is priority criterion if given
    if pattern
      self.to_a.my_each { |each| return false if pattern === each }

      return true
    end

    if block_given?
      array_proc = Proc.new { |each| return false if yield(each) }

      hash_proc = Proc.new { |key, val| return false if yield(key, val) }

      check = self.is_a?(Array) ? array_proc : hash_proc

      self.my_each(&check)

      return true
    end

    # no block and no argument given, return truthiness of no element
    self.to_a.my_each { |each| return false unless [nil, false].include? each }

    true
  end

  def my_count(object = nil)
    total = 0

    if object
      self.my_each { |each| total += 1 if each == object }

      return total
    end

    if block_given?
      self.my_each { |each| total += 1 if yield(each) }

      return total
    end

    # no block and no argument given, return the size of the enumerable
    self.my_each { total += 1 }

    return total
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []

    self.my_each { |each| mapped << yield(each) }

    mapped
  end

  def my_inject(initial_value = nil)
    self.my_each do |each|
      initial_value = initial_value.nil? ? each : yield(initial_value, each)
    end

    initial_value
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    for item in self
      yield item
    end

    self
  end
end

# Custom `each` (`each_pair`) for Hash class.
class Hash
  def my_each
    return enum_for(__method__) unless block_given?

    for key, value in self
      yield key, value
    end

    self
  end
end
