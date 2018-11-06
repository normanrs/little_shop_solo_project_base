class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

  def remove_item(item_id)
    item_id_str = item_id.to_s
    if @contents.key?(item_id_str)
      @contents[item_id.to_s] -= 1
      if @contents[item_id.to_s] <= 0
        @contents.delete(item_id.to_s)
      end
    end
  end

  def remove_all_item(item_id)
    item_id_str = item_id.to_s
    if @contents.key?(item_id_str)
      @contents.delete(item_id.to_s)
    end
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def actualprice_of(item_id)
    theitem = Item.find(item_id)
    theprice = theitem.price
    theqty = @contents[item_id.to_s].to_i
    if !theitem.discounts.empty?
      theitem.discounts.each do |discount|
        if theqty >= discount.range_low
        theprice = (theitem.price * (1 - (discount.percent / 100))).round(2)
        end
      end
    end
    theprice
  end

  def grand_total
    total = 0
    Item.where(id: @contents.keys).each do |item|
      total += (actualprice_of(item.id) * count_of(item.id))
    end
    total
  end
end
