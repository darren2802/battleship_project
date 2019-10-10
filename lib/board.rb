require_relative './cell'

class Board

  def initialize
  end

  def cells(height=4, width=4)
    cell_hash = Hash.new
    height.times do |i|
      width.times do |j|
        hash_key = (i + 65).chr + (j + 1).to_s
        cell_hash[hash_key] = Cell.new(hash_key)
      end
    end
    cell_hash
  end

end
