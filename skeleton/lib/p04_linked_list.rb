class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.prev = @tail
    @tail.next = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.prev
  end

  def last
    @tail.next
  end

  def empty?
    @head.prev == @tail
  end

  def get(key)
    self.each do |el|
      return el.val if el.key == key
    end
    nil
  end

  def include?(key)
    self.each do |el|
      return true if el.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    
    new_node.next = @tail.next
    @tail.next.prev = new_node
    @tail.next = new_node
    new_node.prev = @tail
  end

  def update(key, val)
    self.each do |el|
      el.val = val if el.key == key
    end
  end

  def remove(key)
    # puts 'before'
    # # self.each do |el|
    # #   puts el.key
    # # end
    self.each do |el|
      if el.key == key
        el.prev.next = el.next
        el.next.prev = el.prev
      end
    end
    # puts 'after'
    # self.each do |el|
    #   puts el.key
    # end
  end

  def each(&prc)
    current = @head.prev
    # result = []
    until current.prev == nil
      prc.call(current)
      current = current.prev
    end
  end
  

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
  
  # def inspect
  #   self.each { |node| p node.val }
  # end
end
