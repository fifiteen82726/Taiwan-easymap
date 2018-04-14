require 'csv'

class City
  CITY = {
    '基隆市' => 'C',
    '臺北市' => 'A',
    '新北市' => 'F',
    '桃園市' => 'H',
    '新竹市' => 'O',
    '新竹縣' => 'J',
    '苗栗縣' => 'K',
    '臺中市' => 'B',
    '南投縣' => 'M',
    '彰化縣' => 'N',
    '雲林縣' => 'P',
    '嘉義市' => 'I',
    '嘉義縣' => 'Q',
    '臺南市' => 'D',
    '高雄市' => 'E',
    '屏東縣' => 'T',
    '宜蘭縣' => 'G',
    '花蓮縣' => 'U',
    '臺東縣' => 'V',
    '澎湖縣' => 'X',
    '金門縣' => 'W',
    '連江縣' => 'Z'
  }.freeze

  URL = 'http://easymap.land.moi.gov.tw/R02/Map_json_getMapCenter'

  def read_csv
    path = './testcase.csv'
    csv_data = CSV.read(path, headers: true, skip_lines: /\A(,)+\z/)

    csv_data.each do |row|
      binding.pry
      # row['AA45']
    end

  end

  # def query(city, region, section, number)
  #   response = HTTParty.post(URL, body: {'office' => 'AC', 'sectNo' => '0400', 'landNo' => '1'})
  # end
end
