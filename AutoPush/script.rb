require 'fileutils'

# 設定
TARGET_DIR = "C:/Users/tkota/project_k/Daily-Log/My-daily-Logs/AutoPush" # フォルダのパス
COMMIT_MESSAGE = "Automated commit at #{Time.now}" # コミットメッセージ

def git_push
# カレントディレクトリを対象のフォルダに変更
Dir.chdir(TARGET_DIR) do
	# Git操作を順に実行
	puts "Starting Git operations at #{Time.now}"

	# git add
	unless system('git add .')
	raise "Error: Failed to add files"
	end

	# git commit
	if system("git commit -m \"#{COMMIT_MESSAGE}\"")
	puts "Changes committed successfully."
	else
	puts "No changes to commit."
	end

	# git push
	unless system('git push')
	raise "Error: Failed to push changes"
	end

	puts "Files pushed successfully at #{Time.now}"
end
rescue => e
puts "An error occurred: #{e.message}"
end

# 実行
git_push
