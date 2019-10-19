class Rack::Attack
  # req=リクエスト数
  Rack::Attack.throttle('req/ip', :limit => 120, :period => 2.minutes) do |req| #1分間に60回のアクセスまで。それを超えたらブロック
    req.ip
  end
  
  Rack::Attack.throttle('logins/ip', :limit => 5, :period => 20.seconds) do |req| #1時間に15回ログインしようとしたらブロック
    if req.path == '/login' && req.post?
      req.ip
    end
  end
end