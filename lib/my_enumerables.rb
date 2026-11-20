module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0

    self.my_each do |each|
      yield(each, index)
      index = index.next
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []

    self.my_each do |each|
      result << each if yield(each)
    end

    result
  end

  def my_all?(object = nil)
    # argument `object` is priority criterion if given
    if object
      self.each { |each| return false unless object === each }

      return true
    end

    if block_given?
      self.my_each { |each| return false unless yield(each) }

      return true
    end

    # no block and no argument given, return truthiness of every element
    self.each { |each| return false if [nil, false].include? each }

    true
  end

  def my_any?(pattern = nil)
    if pattern
      self.each { |each| return true if pattern === each }

      return false
    end

    if block_given?
      self.my_each { |each| return true if yield(each) }

      return false
    end

    # no block and no argument given, return truthiness of any element
    self.each { |each| return true unless [nil, false].include? each }

    false
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

    for i in 0...self.size
      yield self[i]
    end

    self
  end
end
