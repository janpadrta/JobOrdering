class OrderController < ApplicationController
  def start
  end

  def result
    i = 0
    input = []
    (params.count - 5).times do
      i += 1
      job = []
      if params["#{i}"][:job] == ""

      else
        job << params["#{i}"][:job]
        job << params["#{i}"][:dependency] unless params["#{i}"][:dependency] == ""
      end

      input << job unless job == []

    end

    @output = Order.order_jobs(input)
  end
end
