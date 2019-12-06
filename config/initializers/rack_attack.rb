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
  
  Rack::Attack.blocklist("block all access to admin") do |request|
    # Requests are blocked if the return value is truthy
    request.path.start_with?("/tapass")
  end
  
  Rack::Attack.safelist_ip("126.141.229.170")
  Rack::Attack.safelist_ip("126.141.213.199")
  Rack::Attack.safelist_ip("153.125.122.18")
end