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

  CITY_STATE_HASH = {}

  def read_csv
    path = './city-xy.csv'
    csv_data = CSV.read(path, headers: true, skip_lines: /\A(,)+\z/)

    aleady_map = []
    city_to_state_list = {}

    csv_data.each do |row|
      city_name = row['AA45']
      next if aleady_map.include?(city_name.strip)

      city_s = CITY[city_name]
      if CITY_STATE_HASH[city_s].nil?
        state_list = city_to_state_list[city_s] ||= HTTParty.post('http://easymap.land.moi.gov.tw/R02/City_json_getTownList', body: {cityCode: city_s, cityName: CITY[city_name], doorPlateType: 'A'})
        state_list.each do |state_obj|
          next if aleady_map.include?("#{city_name}_#{state_obj['name']}")
          road_list = HTTParty.post('http://easymap.land.moi.gov.tw/R02/City_json_getSectionList', body: {cityCode: city_s, area: state_obj['id'] })
          road_list.each do |road|
            Map.find_or_create_by(
              city: city_name,
              city_s: city_s,
              state: state_obj['name'],
              state_s: state_obj['id'],
              road: road['name'],
              road_s: road['id'],
              office: road['officeCode'],
            )
          end

          aleady_map.push "#{city_name}_#{state_obj['name']}"
        end
      end
    end
  end
end
