require_relative 'p04_linked_list'
require_relative 'p02_hashing.rb'
class HashMap
  include Enumerable
  
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    unless self.include?(key)
      bucket(key).append(key,val)
      @count += 1
    end 
    bucket(key).update(key,val) if self.include?(key)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 unless !self.include?(key)
    bucket(key).remove(key)
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key,node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    storage = []
    self.each do |node|
      storage << node
    end
    temp_length = num_buckets * 2
    @store = []
    temp_length.times do
      @store << LinkedList.new
    end
    storage.each do |node|
      self.set(node.key,node.val)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
