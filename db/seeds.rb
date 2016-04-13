City.create([{title: '长沙'}, {title: '永州市'}])

city = City.first
# 长沙公司
Company.create([{title: '长沙第一分公司', city_id: city.id}, 
                {title: '长沙第二分公司', city_id: city.id},
                {title: '长沙第三分公司', city_id: city.id}
])

city = City.last

#永州公司
Company.create([{title: '永州第一分公司', city_id: city.id},
                {title: '永州第二分公司', city_id: city.id},
                {title: '永州第三分公司', city_id: city.id}
])
