Clerk.configure do |c|
    # c.secret_key = `YOUR_SECRET_KEY` # if omitted: ENV["CLERK_SECRET_KEY"]
    c.logger = Logger.new(STDOUT) # if omitted, no logging
end