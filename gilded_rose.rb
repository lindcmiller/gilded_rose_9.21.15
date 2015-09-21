def update_quality(items)
  items.each do |item|
    case item.name
    when "Sulfuras, Hand of Ragnaros"
      next
    when "Conjured Mana Cake"
      conjured(item)
    when "Aged Brie"
      brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      backstage(item)
    else
      default(item)
    end
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1
    end
    limits(item)
  end
end

def limits(item)
  if item.quality > 50
    item.quality = 50
  elsif item.quality < 0
    item.quality = 0
  end
end

def conjured(item)
  2.times { default(item) }
end

def brie(item)
  if item.sell_in > 0
    item.quality += 1
  else
    item.quality += 2
  end
end

def backstage(item)
  if item.sell_in >= 11
    item.quality += 1
  elsif item.sell_in < 11 && item.sell_in > 5
    item.quality += 2
  elsif item.sell_in < 6 && item.sell_in > 0
    item.quality += 3
  else
    item.quality = 0
  end
end

def default(item)
  if item.sell_in > 0
    item.quality -= 1
  else
    item.quality -= 2
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
