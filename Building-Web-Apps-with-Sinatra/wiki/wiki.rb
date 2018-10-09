require "sinatra"
require "uri"

# Instead of localhost:port, 0.0.0.0:port
set :bind, "0.0.0.0"

# Escape any HTML code that appears in a page's content to prevent malicious use
def h(string)
    Rack::Utils.escape_html(string)
  end

# Loads the contents of a text file in the pages directory and returns them as a string.
def page_content(title)
    File.read("pages/#{title}.txt")
rescue Errno::ENOENT
    return nil
end

# Saves a file to the pages directory.
def save_content(title, content)
    File.open("pages/#{title}.txt", "w") do |file|
        file.print(content)
    end
end

# Deletes a file in the pages directory.
def delete_content(title)
    File.delete("pages/#{title}.txt")
end

# Sinatra route that handles requests for the root path.
get "/" do 
    erb :welcome
end

get "/new" do 
    erb :new
end

# You can specify as many named parameters as needed in your route pattern, their corresponding values will be accessible from the params hash.
get "/:title" do
    @title = params[:title]
    @content = page_content(@title)
    # Templates in /views are used for "viewing" the data you embed in them.
    erb :show
end

get "/:title/edit" do
    @title = params[:title]
    @content = page_content(@title)
    erb :edit
end

post "/create" do
    # params.inspect => {"title"=>"Yellow", "content"=>"Mellow"} 
    @title = params[:title]
    @content = params[:content]
    save_content(@title, @content)
    # The return value of URI.escape will be the same path string except that if it contains any bases or other invalid characters, they'll be encoded so the path is valid.
    redirect URI.escape("/#{@title}")
end

put "/:title" do
    @title = params[:title]
    @content = params[:content]
    save_content(@title, @content)
    redirect URI.escape("/#{@title}")
end

delete "/:title" do
    delete_content(params[:title])
    redirect "/"
end