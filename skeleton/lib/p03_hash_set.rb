class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == count
    unless include?(num)
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    storage = []
    @store.each do |arr|
      until arr.empty?
        storage << arr.pop
      end
    end
    
    to_add = num_buckets
    to_add.times do 
      @store << Array.new
    end
    
    storage.each do |el|
        self[el] << el
    end
    
  end
end
