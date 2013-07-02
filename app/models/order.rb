class Order

  def self.order_jobs(input)
    begin
      msg = Order.valid?(input)
    rescue Exception => ex
      return 'circular dependency' if ex.class == SystemStackError
    end

    return msg unless msg == true

    res = input
    for arr in input do
      i = nil
      i = res.index(res.detect{|d| d[1] == arr[0]})
      res.insert(i, res.delete(arr)) if i
    end

    res
  end

  def self.valid?(input)
    for arr in input do
      return 'depend on itself' if arr[0] == arr[1]
      @@begin = arr
      return 'circular dependency' if Order.circular?(input, arr)
    end
    return true
  end

  def self.circular?(input, job)
    if job[1]
      dep = input.detect{|d| d[0] == job[1]}
      return true if dep == @@begin
      Order.circular?(input, dep)
    end
  end

end
