require 'tzinfo/data'

ENV['TZ'] = 'Asia/Tokyo'

TARGET_FOLDER = 'C:/Users/tkota/project_k/Daily-Log/My-daily-Logs/kota'
BRANCH_NAME = 'daily-log'
COMMIT_MESSAGE = 'auto'
FILE_NAME_FORMAT = '%Y-%m-%d.md'

def run_command(command)
  result = `#{command}`
  unless $?.success?
    puts "Command failed: #{command}"
    puts "Error: #{result}"
  end
end

def create_daily_file(target_folder, file_name_format)
  today = Time.now.getlocal("+09:00").strftime(file_name_format)
  file_path = File.join(target_folder, today)

  unless File.exist?(file_path)
    File.open(file_path, 'w') do |file|
      file.puts("# Log for #{today}")
      file.puts("\n## Tasks\n\n- [ ] Example task 1\n- [ ] Example task 2\n")
    end
    puts "Created file: #{file_path}"
  else
    puts "File already exists: #{file_path}"
  end

  file_path
end

Dir.chdir(TARGET_FOLDER) do
  puts "[#{Time.now}] Starting Git operations in #{TARGET_FOLDER}"

  # ブランチを確認して切り替え
  run_command("git checkout #{BRANCH_NAME}")

  # ファイルを作成
  file_path = create_daily_file(TARGET_FOLDER, FILE_NAME_FORMAT)

  # Gitの操作
  run_command("git add #{file_path}")
  run_command("git commit -m \"#{COMMIT_MESSAGE}\"")
  run_command("git push origin #{BRANCH_NAME}")
end