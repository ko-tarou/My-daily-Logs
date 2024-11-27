# config/schedule.rb

set :output, "log/cron_log.log" # ログ出力先
set :environment, "development" # 必要に応じて変更

# 毎日23時にスクリプトを実行
every 1.day, at: '11:00 pm' do
  command "ruby C:/Users/tkota/project_k/Daily-Log/My-daily-Logs/AutoPush/script.rb"
end
