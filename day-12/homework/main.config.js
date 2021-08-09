module.exports = {
  apps : [
      {
        name: "sinatra-food",
        script: "./main.rb",
        watch: true,
        env: {
            "DB_PASSWORD": "Gigih#2021",
            "DB_UID": "gigih",
            "DB_NAME": "food_oms_db_homework"
        }
      }
  ]
}
