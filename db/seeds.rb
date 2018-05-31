User.create(name: "Daria", email:"sicksadworld@lawndale.com", password: "sarcasm")
User.create(name: "River", email:"tam@firefly.com", password: "reader")

Log.create(date: "2018/01/15", swim_distance: 50, bike_distance: 2, run_distance: 2, user_id: 1)
Log.create(date: "2018/01/20", swim_distance: 100, bike_distance: 5, run_distance: 3, user_id: 2)
Log.create(date: "2018/02/15", swim_distance: 150, bike_distance: 3, run_distance: 5, user_id: 1)
Log.create(date: "2018/02/20", swim_distance: 100, bike_distance: 7, run_distance: 6, user_id: 2)