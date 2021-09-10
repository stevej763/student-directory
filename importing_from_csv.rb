require 'CSV'

def import_from_csv()
  CSV.foreach("test.csv") do |row|
    puts row
  end
end

import_from_csv()