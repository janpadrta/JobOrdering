require 'spec_helper'
#require 'rspec-rails'

describe 'correct order' do

  it 'should return empty sequence' do
    a = []
    b = Order.order_jobs(a)
    b.should == []
  end

  it 'should return the same' do
    a = [['a'],['b'],['c']]
    b = Order.order_jobs(a)
    b.should == [['a'],['b'],['c']]
  end

  it 'should put c before b' do
    a = [['a'],['b','c'],['c']]
    b = Order.order_jobs(a)
    b.should == [['a'],['c'],['b','c']]
  end

  it 'should return in correct order' do
    a = [['a'],['b','c'],['c','f'],['d','a'],['e','b'],['f']]
    b = Order.order_jobs(a)
    b.should == [['f'],['c','f'],['b','c'],['a'],['d','a'],['e','b']]
  end

  it 'should not depend on itself' do
    a = [['a'],['b'],['c','c']]
    b = Order.order_jobs(a)
    b.should == 'depend on itself'
  end

  it 'should have circular dependency' do
    a = [['a'],['b','c'],['c','f'],['d','a'],['e'],['f','b']]
    b = Order.order_jobs(a)
    b.should == 'circular dependency'
  end

  it 'should return in correct order' do
    a = [['a','c'],['b','c'],['c'],['d','c'],['e','c']]
    b = Order.order_jobs(a)
    b.should == [['c'],['a','c'],['b','c'],['d','c'],['e','c']]
  end

  it 'should have circular dependency' do
    a = [['a','b'],['b','b']]
    b = Order.order_jobs(a)
    b.should == 'circular dependency'
  end

end